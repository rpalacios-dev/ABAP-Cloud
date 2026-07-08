CLASS lhc_zr_recetas_rpc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrRecetasRpc
        RESULT result,
      validateTiempo FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrRecetasRpc~VALIDATETIEMPO,
      setPublicada FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZrRecetasRpc~setPublicada.
ENDCLASS.

CLASS lhc_zr_recetas_rpc IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD validateTiempo.

    " 1. Leemos el campo TiempoPrep de los registros que el usuario intenta guardar
    READ ENTITIES OF zr_recetas_rpc IN LOCAL MODE
      ENTITY ZrRecetasRpc
      FIELDS ( TiempoPrep )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_recetas).

    " 2. Analizamos las recetas introducidas una a una
    LOOP AT lt_recetas INTO DATA(ls_receta).

      " Si el tiempo es menor que 1 o mayor que 600...
      IF ls_receta-TiempoPrep < 1 OR ls_receta-TiempoPrep > 600.

        " A) Bloqueamos el guardado de este registro metiendo su llave (%tky) en 'failed'
        APPEND VALUE #( %tky = ls_receta-%tky ) TO failed-zrrecetasrpc.

        " B) Creamos el mensaje de error para el usuario en 'reported'
        APPEND VALUE #(
            %tky        = ls_receta-%tky
            " Esto marca el campo TiempoPrep en rojo en la pantalla
            %element-tiempoprep = if_abap_behv=>mk-on
            %msg        = new_message_with_text(
                            severity = if_abap_behv_message=>severity-error
                            text     = 'El tiempo de preparación debe estar entre 1 y 600 minutos.' )
        ) TO reported-zrrecetasrpc.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD setPublicada.

  " Modificamos las entidades en modo local para cambiar el campo 'Publicada'
    MODIFY ENTITIES OF zr_recetas_rpc IN LOCAL MODE
      ENTITY ZrRecetasRpc
        UPDATE FIELDS ( Publicada )
        WITH VALUE #( FOR key IN keys (
                        %tky      = key-%tky
                        Publicada = abap_true ) ) " <- Asigna automáticamente 'X'
    REPORTED DATA(lt_reported).

  ENDMETHOD.

ENDCLASS.
