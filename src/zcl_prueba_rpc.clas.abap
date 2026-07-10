CLASS zcl_prueba_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_prueba_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   TRY.
        DATA(lo_vuelo) = NEW zcl_rpc_flight(
          i_carrier_id    = 'UA'
          i_connection_id = 58
          i_plane_type    = 'xxx' ).
        out->write( lo_vuelo ).
      CATCH zcx_c_abapd_no_connection.
        out->write( 'No flight found' ).
    ENDTRY.

    TRY.
        DATA(lo_vuelo_hija) = NEW zcl_rpc_customer_flight(
          i_carrier_id    = 'UA'
          i_connection_id = 58
          i_plane_type    = '747-400' ).
        out->write( lo_vuelo_hija ).
      CATCH zcx_c_abapd_no_connection.
        out->write( 'No flight found' ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
