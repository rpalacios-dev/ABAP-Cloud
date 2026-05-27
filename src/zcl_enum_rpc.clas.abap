CLASS zcl_enum_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_enum_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Usar para desplegables

    TYPES: BEGIN OF ENUM ty_color,
             rojo,
             verde,
             azul,
             amarillo,
           END OF ENUM ty_color.

    DATA lv_color TYPE ty_color.

    lv_color =  amarillo.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    TYPES: BEGIN OF ENUM ty_vuelos,
             nacional, "dentro del pais
             internacional, "fuera del pais
             charter, "vuelo especial/privado
           END OF ENUM ty_vuelos.

    DATA lv_vuelo TYPE ty_vuelos.
    lv_vuelo = internacional.

    CASE lv_vuelo.

      WHEN nacional.
        out->write( |Vuelos dentro de tu mismo país| ).
      WHEN internacional.
        out->write( |Vuelos fuera de tu país| ).
      WHEN charter.
        out->write( |Vuelos especiales y/o privados| ).
      WHEN OTHERS.
        out->write( |No son ninguna de las opciones anteriores| ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
