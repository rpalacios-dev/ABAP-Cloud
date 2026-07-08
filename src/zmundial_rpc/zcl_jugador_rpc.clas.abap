CLASS zcl_jugador_rpc DEFINITION
  PUBLIC
  INHERITING FROM zcl_acreditado_rpc
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: dorsal    TYPE i,
          posicion  TYPE string,
          convocado TYPE abap_bool.

    METHODS: constructor IMPORTING iv_nombre          TYPE string
                                   iv_pais            TYPE string
                                   iv_acreditacion    TYPE i
                                   iv_fecha_caducidad TYPE d
                                   iv_dorsal          TYPE i
                                   iv_posicion        TYPE string
                                   iv_convocado       TYPE abap_bool,

      descripcion_pase REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jugador_rpc IMPLEMENTATION.

  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre
                        iv_pais = iv_pais
                        iv_acreditacion = iv_acreditacion
                        iv_fecha_caducidad = iv_fecha_caducidad ).
    dorsal = iv_dorsal.
    posicion = iv_posicion.
    convocado = iv_convocado.

  ENDMETHOD.



  METHOD descripcion_pase.
    CLEAR rs_descripcion.

    rs_descripcion-nombre = nombre.
    rs_descripcion-pais = pais.
    rs_descripcion-acreditacion = get_acreditacion( ).
    rs_descripcion-caducidad = fecha_caducidad.
    rs_descripcion-dorsal = dorsal.
    rs_descripcion-posicion = posicion.
    rs_descripcion-convocado = convocado.

  ENDMETHOD.

ENDCLASS.
