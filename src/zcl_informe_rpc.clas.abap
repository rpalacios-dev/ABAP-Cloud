CLASS zcl_informe_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_informe_rpc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: ls_nueva_suscrip    TYPE zdb_suscrip_rpc,
          lt_usuarios_activos TYPE zcl_gestion_suscrip_rpc=>tt_suscripcion.

    "Crear un nuevo usuario y añadirlo a la BBDD
    DATA: lv_usuario   TYPE uname VALUE 'RebecaTrial',
          lv_tipo_plan TYPE zde_sub_tipo_rpc VALUE 'A',
          lv_precio    TYPE zdb_suscrip_rpc-precio VALUE '29.99'.


    SELECT * FROM zdb_suscrip_rpc INTO TABLE @DATA(lt_usuarios).
    DATA(lo_usuarios) = NEW zcl_gestion_suscrip_rpc( lt_usuarios ).

    "Impresión de tabla original
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |SUSCRIPCIONES ACTUALES| ).
    out->write( lt_usuarios ).
    out->write( | | ).

    "Creación de una nueva suscripción
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_usuarios->crear_suscripcion( iv_usuario = lv_usuario iv_tipo_plan = lv_tipo_plan iv_precio = lv_precio ).

    out->write( |NUEVA SUSCRIPCIÓN| ).
    out->write( |Usuario = { lv_usuario }     Tipo de plan = { lv_tipo_plan }     Precio = { lv_precio }| ).
    out->write( | | ).

    SELECT * FROM zdb_suscrip_rpc INTO TABLE @lt_usuarios.
    out->write( |SUSCRIPCIONES ACTUALES| ).
    out->write( lt_usuarios ).
    out->write( | | ).

    "Obtener suscripciones activas
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    lo_usuarios->obtener_activas( IMPORTING et_suscripciones_activas = lt_usuarios_activos ).
    out->write( |USUARIOS ACTIVOS| ).
    out->write( lt_usuarios_activos ).











  ENDMETHOD.
ENDCLASS.
