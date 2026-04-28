CLASS zcl_dic_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dic_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lv_cliente TYPE zde_cliente_rpc.

    lv_cliente = 'Rebeca'.

    out->write( lv_cliente ).

  ENDMETHOD.

ENDCLASS.
