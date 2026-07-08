CLASS zcl_flight_manager_rpc DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_flight_manager_rpc.

    METHODS constructor
      IMPORTING it_preload_flights TYPE zif_flight_manager_rpc=>tt_flights OPTIONAL.

  PRIVATE SECTION.
    DATA mt_flights TYPE zif_flight_manager_rpc=>tt_flights.
ENDCLASS.

CLASS zcl_flight_manager_rpc IMPLEMENTATION.


  METHOD constructor.
    me->mt_flights = it_preload_flights.
  ENDMETHOD.



  METHOD zif_flight_manager_rpc~add_flight.
    IF is_flight-price <= 0.
      RAISE EXCEPTION NEW zcx_flight_error_rpc( iv_msg = 'Error: El precio del vuelo debe ser positivo.' ).
    ENDIF.

    READ TABLE me->mt_flights TRANSPORTING NO FIELDS
      WITH KEY airline    = is_flight-airline
               flight_num = is_flight-flight_num.
    IF sy-subrc = 0.
      RAISE EXCEPTION NEW zcx_flight_error_rpc( iv_msg = |Error: El vuelo { is_flight-airline }{ is_flight-flight_num } ya existe.| ).
    ENDIF.

    APPEND is_flight TO me->mt_flights.
  ENDMETHOD.



  METHOD zif_flight_manager_rpc~get_flights_by_airline.
    CLEAR rt_flights.
    LOOP AT me->mt_flights INTO DATA(ls_flight) WHERE airline = iv_airline.
      APPEND ls_flight TO rt_flights.
    ENDLOOP.
  ENDMETHOD.



  METHOD zif_flight_manager_rpc~get_cheapest_flight.
    IF me->mt_flights IS INITIAL.
      RETURN.
    ENDIF.

    IF me->mt_flights IS INITIAL.
      RETURN.
    ENDIF.

    READ TABLE me->mt_flights INTO rs_flight INDEX 1.

    LOOP AT me->mt_flights INTO DATA(ls_flight).
      IF ls_flight-price < rs_flight-price.
        rs_flight = ls_flight.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.



  METHOD zif_flight_manager_rpc~get_total_revenue.
    rv_revenue = 0.

    LOOP AT me->mt_flights INTO DATA(ls_flight).
      rv_revenue = rv_revenue + ls_flight-price.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
