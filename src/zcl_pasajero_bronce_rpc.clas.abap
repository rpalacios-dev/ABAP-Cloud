CLASS zcl_pasajero_bronce_rpc DEFINITION
  PUBLIC
  INHERITING FROM zcl_pasajero_rpc
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS calcular_descuento REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_pasajero_bronce_rpc IMPLEMENTATION.

  METHOD calcular_descuento.
    IF mv_km_recorridos >= 10000.
      rv_descuento = 95.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
