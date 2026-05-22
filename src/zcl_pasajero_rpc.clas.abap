CLASS zcl_pasajero_rpc DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    "Atributos
    DATA: mv_id            TYPE i,
          mv_nombre        TYPE string,
          mv_km_recorridos TYPE f.
    TYPES ty_descuento TYPE p LENGTH 4 DECIMALS 2.

    "Métodos
    METHODS constructor IMPORTING iv_id            TYPE i
                                  iv_nombre        TYPE string
                                  iv_km_recorridos TYPE f.
    METHODS calcular_descuento RETURNING VALUE(rv_descuento) TYPE ty_descuento.

ENDCLASS.

CLASS zcl_pasajero_rpc IMPLEMENTATION.

  METHOD constructor.
    mv_id = iv_id.
    mv_nombre = iv_nombre.
    mv_km_recorridos = iv_km_recorridos.
  ENDMETHOD.


  METHOD calcular_descuento.
    rv_descuento = 0.
  ENDMETHOD.

ENDCLASS.
