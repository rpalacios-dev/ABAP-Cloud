INTERFACE zif_flight_manager_rpc PUBLIC.

  TYPES: BEGIN OF ty_flight,
           airline    TYPE /dmo/carrier_id,
           flight_num TYPE /dmo/connection_id,
           price      TYPE /dmo/flight_price,
         END OF ty_flight,
         tt_flights TYPE STANDARD TABLE OF ty_flight WITH DEFAULT KEY.

  METHODS add_flight
    IMPORTING is_flight TYPE ty_flight
    RAISING   zcx_flight_error_rpc.

  METHODS get_flights_by_airline
    IMPORTING iv_airline        TYPE /dmo/carrier_id
    RETURNING VALUE(rt_flights) TYPE tt_flights.

  METHODS get_cheapest_flight
    RETURNING VALUE(rs_flight) TYPE ty_flight.

  METHODS get_total_revenue
    RETURNING VALUE(rv_revenue) TYPE /dmo/flight_price.

ENDINTERFACE.
