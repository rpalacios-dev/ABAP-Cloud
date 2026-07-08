CLASS zcl_mundial_main_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mundial_main_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " 1. Instanciamos al Jugador (Lamine Yamal) siguiendo la pista 5
    DATA(lo_jugador) = NEW zcl_jugador_rpc(
      iv_nombre          = 'Lamine Yamal'
      iv_pais            = 'España'
      iv_acreditacion    = 191919
      iv_fecha_caducidad = '20260715' " Final del mundial
      iv_dorsal          = 19
      iv_posicion        = 'Extremo'
      iv_convocado       = abap_true
    ).

    " 2. Instanciamos a la Periodista (Cadena SER) con acceso a Zona Mixta
    DATA(lo_periodista) = NEW zcl_periodista(
      iv_nombre             = 'Marta Ramón'
      iv_pais               = 'España'
      iv_acreditacion       = 555444
      iv_fecha_caducidad    = '20260715'
      iv_medio_comunicacion = 'Cadena SER'
      iv_acceso_mixta       = abap_true
    ).

    " ------------------------------------------------------------------
    " EJECUCIÓN Y DEMOSTRACIÓN DE POLIMORFISMO
    " ------------------------------------------------------------------

    " Llamada al método en el Jugador
    DATA(ls_info_jugador) = lo_jugador->descripcion_pase( ).

    out->write( |--- ACREDITACIÓN DE JUGADOR ---| ).
    out->write( |Nombre: { ls_info_jugador-nombre } ({ ls_info_jugador-pais })| ).
    out->write( |Dorsal: { ls_info_jugador-dorsal } - Posición: { ls_info_jugador-posicion }| ).
    out->write( |ZONAS PERMITIDAS: [Acceso al Campo y Vestuarios]| ).
    out->write( |----------------------------------------\n| ).


    " Llamada al MISMO método, pero en el objeto Periodista
    DATA(ls_info_periodista) = lo_periodista->descripcion_pase( ).

    out->write( |--- ACREDITACIÓN DE PRENSA ---| ).
    out->write( |Nombre: { ls_info_periodista-nombre } - Medio: { ls_info_periodista-medio_comunicacion }| ).

    " Pista 4: Evaluamos el acceso a zona mixta para pintar el texto personalizado
    IF ls_info_periodista-acceso_mixta = abap_true.
      out->write( |ZONAS PERMITIDAS: [Sala de Prensa] y [ZONA MIXTA AUTORIZADA]| ).
    ELSE.
      out->write( |ZONAS PERMITIDAS: [Solo Sala de Prensa]| ).
    ENDIF.
    out->write( |----------------------------------------| ).


  ENDMETHOD.
ENDCLASS.
