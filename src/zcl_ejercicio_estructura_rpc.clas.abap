CLASS zcl_ejercicio_estructura_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio_estructura_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    "1. TY_FLIGHTS y TY_AIRLINES con sus respectivos campos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TYPES: BEGIN OF ty_flights,
             "iduser(40) TYPE c,
             iduser     TYPE c LENGTH 40,
             aircode    TYPE /dmo/carrier_id,
             flightnum  TYPE /dmo/connection_id,
             key        TYPE land1,
             seat       TYPE /dmo/plane_seats_occupied,
             flightdate TYPE /dmo/flight_date,
           END OF ty_flights.

    TYPES: BEGIN OF ty_airlines,
             carrid    TYPE /dmo/carrier_id,
             connid    TYPE /dmo/connection_id,
             countryfr TYPE land1,
             cityfrom  TYPE /dmo/city,
             airpfrom  TYPE /dmo/airport_id,
             countryto TYPE land1,
           END OF ty_airlines.


    "2. Estruturas anidadas
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TYPES:BEGIN OF ty_nested,
            flights  TYPE ty_flights,
            airlines TYPE ty_airlines,
          END OF TY_nested.

    DATA ls_nested TYPE ty_nested.


    "3. Añadir datos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ls_nested-flights-iduser = 'Carlos'.
    ls_nested-flights-aircode = 'LH'.
    ls_nested-flights-flightnum = '0400'.
    ls_nested-flights-key = 'DE'.
    ls_nested-flights-seat = '100'.
    ls_nested-flights-flightdate = '20210101'.

    out->write( |Valores estructura: ls_nested-flights| ).
    out->write( ls_nested-flights ).

    ls_nested-airlines-carrid = 'LH'.
    ls_nested-airlines-connid = '0400'.
    ls_nested-airlines-countryfr = 'ESP'.
    ls_nested-airlines-cityfrom = 'MADRID'.
    ls_nested-airlines-airpfrom = 'MAD'.
    ls_nested-airlines-countryto = 'DE'.

    out->write( |Valores estructura: ls_nested-airlines| ).
    out->write( ls_nested-airlines ).


    "4. Estructura INCLUDE y valores (no solucionado)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    TYPES:BEGIN OF ty_include_flights,
*            include TYPE ty_flights,
*            include TYPE ty_airlines renaming WITH suffix _air.
*    END OF ty_include_flights.
*
*    ls_include_flights type ty_include_flights.


    "5. Eliminar datos de la estructura "NESTED".
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    CLEAR ls_nested.

    out->write( |Valores estructura: ls_nested-flights| ).
    out->write( ls_nested-flights ).

    out->write( |Valores estructura: ls_nested-airlines| ).
    out->write( ls_nested-airlines ).

  ENDMETHOD.
ENDCLASS.
