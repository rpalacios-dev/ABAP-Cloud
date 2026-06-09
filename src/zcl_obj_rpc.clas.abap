CLASS zcl_obj_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  "Evitar si es posible crear elementos públicos
  PUBLIC SECTION.
    "Atributos estáticos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    CLASS-DATA lv_moneda TYPE c LENGTH 3.
    "Atributos de clase
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA lv_cliente TYPE string.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_obj_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA(lo_nombre) = new zcl_obj_der(  ).


  ENDMETHOD.
ENDCLASS.
