CLASS zcl_cp02_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp02_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "CASO PRÁCTICO 4 - Resolución en ZCL_CP04_RPC
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    TYPES: BEGIN OF ty_reserva,
             id_reserva TYPE i,
             aerolinea  TYPE c LENGTH 2,
             num_vuelo  TYPE n LENGTH 4,
             pasajero   TYPE string,
             fecha      TYPE d,
             precio     TYPE p LENGTH 8 DECIMALS 2,
             estado     TYPE c LENGTH 1,
           END OF ty_reserva.

    DATA lt_reservas TYPE SORTED TABLE OF ty_reserva WITH UNIQUE KEY id_reserva.
    DATA ls_reserva TYPE ty_reserva.

    lt_reservas = VALUE #(
      ( id_reserva = 1 aerolinea = 'LH' num_vuelo = '0400' pasajero = 'Ana García'    fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id_reserva = 2 aerolinea = 'IB' num_vuelo = '3740' pasajero = 'Carlos López'  fecha = '20260515' precio = '120.00'  estado = 'A' )
      ( id_reserva = 3 aerolinea = 'AA' num_vuelo = '0017' pasajero = 'John Smith'    fecha = '20260520' precio = '450.50'  estado = 'A' )
      ( id_reserva = 4 aerolinea = 'LH' num_vuelo = '0455' pasajero = 'María Pérez'   fecha = '20260520' precio = '310.75'  estado = 'A' )
      ( id_reserva = 5 aerolinea = 'IB' num_vuelo = '3740' pasajero = 'Pedro Ruiz'    fecha = '20260515' precio = '120.00'  estado = 'C' )
      ( id_reserva = 6 aerolinea = 'SQ' num_vuelo = '0026' pasajero = 'Lisa Tan'      fecha = '20260601' precio = '1250.00' estado = 'A' )
      ( id_reserva = 7 aerolinea = 'LH' num_vuelo = '0400' pasajero = 'Hans Müller'   fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id_reserva = 8 aerolinea = 'AA' num_vuelo = '0064' pasajero = 'Sarah Jones'   fecha = '20260525' precio = '510.00'  estado = 'A' )
    ).

    "TAREA 1: Altas de reservas
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 1: Altas de reservas| ).
    out->write( | | ).

    INSERT VALUE #( id_reserva = 9  aerolinea = 'IB' num_vuelo = '3950' pasajero = 'Elena Martín' fecha = '20260601' precio = '275.30' estado = 'A' ) INTO TABLE lt_reservas.
    INSERT VALUE #( id_reserva = 10 aerolinea = 'LH' num_vuelo = '2030' pasajero = 'Franz Weber'  fecha = '20260610' precio = '95.00'  estado = 'A' ) INTO TABLE lt_reservas.

    out->write( lt_reservas ).
    out->write( | | ).


    "TAREA 2: Modificaciones
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 2: Modificaciones| ).
    out->write( | | ).

    READ TABLE lt_reservas INTO ls_reserva WITH TABLE KEY id_reserva = 3.
    IF sy-subrc = 0.
      ls_reserva-precio = '480.00'.
    ENDIF.

    MODIFY TABLE lt_reservas FROM ls_reserva.

    LOOP AT lt_reservas INTO ls_reserva.
      IF ls_reserva-aerolinea = 'LH'.
        ls_reserva-precio = ls_reserva-precio * '0.9'.
        MODIFY TABLE lt_reservas FROM ls_reserva.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_reservas INTO ls_reserva.
      IF ls_reserva-aerolinea = 'LH' OR ls_reserva-id_reserva = 3.
        out->write( ls_reserva ).
      ENDIF.
    ENDLOOP.
    out->write( | | ).


    "TAREA 3: Cancelaciones y borrados
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 3: Cancelaciones y borrados| ).
    out->write( | | ).

    READ TABLE lt_reservas INTO ls_reserva WITH TABLE KEY id_reserva = 4.
    IF sy-subrc = 0.
      ls_reserva-estado = 'C'.
    ENDIF.

    DATA(lv_registros_originales) = lines( lt_reservas ).
    DELETE lt_reservas WHERE estado = 'C'.

    DATA(lv_registros_finales) = lines( lt_reservas ).
    DATA(lv_eliminados) = lv_registros_originales - lv_registros_finales.

    out->write( lt_reservas ).
    out->write( |Registros eliminados: { lv_eliminados }| ).
    out->write( | | ).


    "TAREA 4: Búsquedas
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |TAREA 4: Búsquedas| ).
    out->write( | | ).

    READ TABLE lt_reservas TRANSPORTING NO FIELDS WITH KEY pasajero = 'Lisa Tan'.
    IF sy-subrc = 0.
      out->write( 'Existe una reserva para Lisa Tan.' ).
    ELSE.
      out->write( 'No se encontró la reserva de Lisa Tan.' ).
    ENDIF.

    READ TABLE lt_reservas REFERENCE INTO DATA(lr_reserva) WITH TABLE KEY id_reserva = 6.
    IF sy-subrc = 0.
      out->write( |Referencia del ID 6 -> Pasajero: { lr_reserva->pasajero }  Precio: { lr_reserva->precio }| ).
    ENDIF.

    DATA(lv_pasajero) = VALUE string( lt_reservas[ id_reserva = 1 ]-pasajero OPTIONAL ).
    out->write( |Acceso directo ID 1 - Pasajero: { lv_pasajero }| ).
    out->write( | | ).

    "TAREA 5: Agrupación y agregados
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |TAREA 5: Agrupación y agregados| ).
    out->write( | | ).

    TYPES: BEGIN OF ty_informe,
             aerolinea    TYPE c LENGTH 2,
             num_reservas TYPE i,
             precio_total TYPE p LENGTH 8 DECIMALS 2,
             precio_medio TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_informe.
    DATA lt_informe TYPE STANDARD TABLE OF ty_informe.

    " Agrupamos las reservas donde el estado sea 'A'
    LOOP AT lt_reservas INTO DATA(ls_res) WHERE estado = 'A'
         GROUP BY ( key_aerolinea = ls_res-aerolinea )
         ASCENDING
         ASSIGNING FIELD-SYMBOL(<group>).

      DATA(ls_linea_informe) = VALUE ty_informe( aerolinea = <group>-key_aerolinea ).
      LOOP AT GROUP <group> INTO DATA(ls_miembro).
        ls_linea_informe-num_reservas += 1.
        ls_linea_informe-precio_total += ls_miembro-precio.
      ENDLOOP.

      ls_linea_informe-precio_medio = round( val  = ( ls_linea_informe-precio_total / ls_linea_informe-num_reservas )
                                             dec  = 2
                                             mode = cl_abap_math=>round_half_up ).

      APPEND ls_linea_informe TO lt_informe.
    ENDLOOP.

    out->write( lt_informe ).

  ENDMETHOD.
ENDCLASS.
