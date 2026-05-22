CLASS zcl_gestor_vuelos_rpc DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS obtener_vuelos_disponibles RETURNING VALUE(lt_vuelos_disponibles) TYPE /dmo/t_flight.
    METHODS obtener_precios_base IMPORTING it_vuelos        TYPE /dmo/t_flight
                                           iv_connection    TYPE /dmo/connection_id
                                 RETURNING VALUE(rv_precio) TYPE /dmo/flight_price.
    METHODS obtener_vuelo IMPORTING it_vuelos       TYPE /dmo/t_flight
                                    iv_connection   TYPE /dmo/connection_id
                          RETURNING VALUE(rv_vuelo) TYPE /dmo/flight.

ENDCLASS.

CLASS zcl_gestor_vuelos_rpc IMPLEMENTATION.

  METHOD obtener_vuelos_disponibles.
    SELECT * FROM /dmo/flight
    WHERE carrier_id = 'AA'
    INTO TABLE @lt_vuelos_disponibles.

  ENDMETHOD.

  METHOD obtener_precios_base.
    rv_precio = VALUE #( it_vuelos[ connection_id = iv_connection ]-price OPTIONAL ).

  ENDMETHOD.

  METHOD obtener_vuelo.
    rv_vuelo = VALUE #( it_vuelos[ connection_id = iv_connection ] ).
  ENDMETHOD.

ENDCLASS.
