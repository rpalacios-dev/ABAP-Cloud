CLASS zcl_cp03_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp03_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_manager) = NEW zcl_flight_manager_rpc( ).

    out->write( |1. Añadir 5 vuelos | ).
    out->write( | | ).
    TRY.
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'LH' flight_num = '0400' price = '899.00' ) ).
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'IB' flight_num = '3740' price = '120.00' ) ).
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'AA' flight_num = '0017' price = '450.50' ) ).
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'LH' flight_num = '0455' price = '310.75' ) ).
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'SQ' flight_num = '0026' price = '1250.00' ) ).
        out->write( 'Vuelos añadidos correctamente.' ).
      CATCH zcx_flight_error_rpc INTO DATA(lo_ex_init).
        out->write( lo_ex_init->mv_error_msg ).
    ENDTRY.


    out->write( |2. Añadir vuelo con precio negativo | ).
    out->write( | | ).

    TRY.
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'AA' flight_num = '9999' price = '-50.00' ) ).
      CATCH zcx_flight_error_rpc INTO DATA(lo_ex_neg).
        out->write( lo_ex_neg->mv_error_msg ).
    ENDTRY.


    out->write( |3. Añadir un vuelo duplicado | ).
    out->write( | | ).

    TRY.
        lo_manager->zif_flight_manager_rpc~add_flight( VALUE #( airline = 'LH' flight_num = '0400' price = '150.00' ) ).
      CATCH zcx_flight_error_rpc INTO DATA(lo_ex_dup).
        out->write( lo_ex_dup->mv_error_msg ).
    ENDTRY.


    out->write( |4. Buscar vuelos de 'LH' | ).
    out->write( | | ).

    DATA(lt_lh_flights) = lo_manager->zif_flight_manager_rpc~get_flights_by_airline( 'LH' ).
    out->write( lt_lh_flights ).


    out->write( |5. Vuelo más barato | ).
    out->write( | | ).
    DATA(ls_cheapest) = lo_manager->zif_flight_manager_rpc~get_cheapest_flight( ).
    out->write( ls_cheapest ).


    out->write( |6. Facturación total | ).
    out->write( | | ).
    DATA(lv_revenue) = lo_manager->zif_flight_manager_rpc~get_total_revenue( ).
    out->write( |Total Facturado: { lv_revenue } EUR| ).


  ENDMETHOD.
ENDCLASS.
