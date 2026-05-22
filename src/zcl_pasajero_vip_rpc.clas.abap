CLASS zcl_pasajero_vip_rpc DEFINITION
  PUBLIC
  INHERITING FROM zcl_pasajero_rpc
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA mv_acceso_lounge TYPE abap_bool.
    METHODS calcular_descuento REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_pasajero_vip_rpc IMPLEMENTATION.

  METHOD calcular_descuento.
    IF mv_km_recorridos >= 10000.
      rv_descuento = 80.
    ELSE.
      rv_descuento = 85.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
