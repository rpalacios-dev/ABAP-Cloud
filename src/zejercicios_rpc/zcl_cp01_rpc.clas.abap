CLASS zcl_cp01_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp01_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Carga de datos de partida creando un tipo específico para la tabla"
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    TYPES:BEGIN OF ty_viajes,
            aerolinea     TYPE /dmo/carrier_id,
            vuelo         TYPE /dmo/connection_id,
            origen        TYPE /dmo/airport_from_id,
            destino       TYPE /dmo/airport_to_id,
            precio        TYPE /dmo/flight_price,
            plazas_libres TYPE i,
          END OF ty_viajes.

    DATA: ls_viajes TYPE ty_viajes,
          lt_viajes TYPE TABLE OF ty_viajes.

    lt_viajes = VALUE #(
  ( aerolinea = 'LH' vuelo = '0400' origen = 'FRA' destino = 'JFK' precio = '899.00'  plazas_libres = 15 )
  ( aerolinea = 'AA' vuelo = '0017' origen = 'JFK' destino = 'SFO' precio = '450.50'  plazas_libres = 0  )
  ( aerolinea = 'IB' vuelo = '3740' origen = 'MAD' destino = 'BCN' precio = '120.00'  plazas_libres = 42 )
  ( aerolinea = 'LH' vuelo = '0455' origen = 'FRA' destino = 'MAD' precio = '310.75'  plazas_libres = 8  )
  ( aerolinea = 'AA' vuelo = '0064' origen = 'SFO' destino = 'JFK' precio = '510.00'  plazas_libres = 3  )
  ( aerolinea = 'IB' vuelo = '3950' origen = 'BCN' destino = 'LHR' precio = '275.30'  plazas_libres = 0  )
  ( aerolinea = 'LH' vuelo = '2030' origen = 'MUC' destino = 'FRA' precio = '95.00'   plazas_libres = 60 )
  ( aerolinea = 'SQ' vuelo = '0026' origen = 'SIN' destino = 'FRA' precio = '1250.00' plazas_libres = 5  )
).

    "IMPRESION DE TABLA
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |TABLA INTERNA - Datos| ).
    out->write( | | ).
    out->write( lt_viajes ).
    out->write( | | ).

    "TAREA 1: Clasificación por precio
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 1: Clasificación por precio| ).
    out->write( | | ).

    LOOP AT lt_viajes INTO ls_viajes.
      DATA(lv_clasificacion_precio) = COND string(
          WHEN ls_viajes-precio < 150 THEN 'Economico'
          WHEN 150 <= ls_viajes-precio AND ls_viajes-precio < 500 THEN 'Estándar'
          WHEN 500 <= ls_viajes-precio AND ls_viajes-precio < 1000 THEN 'Prémium'
          ELSE 'First Class'
      ).

      out->write( |Aerolinea - { ls_viajes-aerolinea }  Num. Vuelo - { ls_viajes-vuelo }  Precio - { ls_viajes-precio }  Clasificacion - { lv_clasificacion_precio }| ).
    ENDLOOP.


    out->write( | | ).

    "TAREA 2: Filtrado con operadores
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 2: Filtrado con operadores| ).
    out->write( | | ).

    LOOP AT lt_viajes INTO ls_viajes.
      IF 0 < ls_viajes-plazas_libres AND ls_viajes-origen EQ 'FRA' OR ls_viajes-destino EQ 'FRA' AND ls_viajes-precio < 1000.
        out->write( ls_viajes ).
      ENDIF.
    ENDLOOP.

    out->write( | | ).


    "TAREA 3: Transformación de cadenas
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 3: Transformación de cadenas| ).
    out->write( | | ).

    LOOP AT lt_viajes INTO ls_viajes.
      IF 0 < ls_viajes-plazas_libres AND ls_viajes-origen EQ 'FRA' OR ls_viajes-destino EQ 'FRA' AND ls_viajes-precio < 1000.
        "1. Concatenación de aerolínea y número de vuelo
        DATA(lv_codigo_vuelo) = ls_viajes-aerolinea && '-' && ls_viajes-vuelo.

        " 2. Conversión del destino a minúsculas
        DATA(lv_destino_minus) = to_lower( ls_viajes-destino ).

        " 3. Longitud del código generado
        DATA(lv_longitud) = strlen( lv_codigo_vuelo ).

        DATA(lv_resultado) = lv_codigo_vuelo && '|' && lv_destino_minus && '|' && lv_longitud.
        out->write( lv_resultado ).
      ENDIF.
    ENDLOOP.

    out->write( | | ).

    "TAREA 4: Resumen con funciones numéricas
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    out->write( |TAREA 4: Resumen con funciones numéricas| ).
    out->write( | | ).

    DATA(lv_precio_min) = lt_viajes[ 1 ]-precio.
    DATA(lv_precio_max) = lt_viajes[ 1 ]-precio.
    DATA: lv_precio_total TYPE p DECIMALS 2,
          lv_total_plazas TYPE i VALUE 0,
          lv_contador     TYPE i VALUE 0.

    LOOP AT lt_viajes INTO ls_viajes.
      lv_contador = lv_contador + 1.

      IF ls_viajes-precio < lv_precio_min.
        lv_precio_min = ls_viajes-precio.
      ENDIF.

      IF lv_precio_max < ls_viajes-precio.
        lv_precio_max = ls_viajes-precio.
      ENDIF.

      lv_precio_total += ls_viajes-precio.
      lv_total_plazas += ls_viajes-plazas_libres.
    ENDLOOP.

    DATA(lv_precio_medio) = round( val  = ( lv_precio_total / lv_contador )
                                   dec  = 2
                                   mode = cl_abap_math=>round_half_up ).

    out->write( |Precio Máximo: { lv_precio_max }| ).
    out->write( |Precio Mínimo: { lv_precio_min }| ).
    out->write( |Precio Medio:  { lv_precio_medio }| ).
    out->write( |Total Plazas Libres: { lv_total_plazas }| ).
    out->write( | | ).

  ENDMETHOD.
ENDCLASS.
