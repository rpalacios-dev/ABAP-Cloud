CLASS zcl_acreditado_rpc DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_descripcion,
             nombre             TYPE string,
             pais               TYPE string,
             acreditacion       TYPE i,
             caducidad          TYPE d,
             dorsal             TYPE i,
             posicion           TYPE string,
             convocado          TYPE abap_bool,
             medio_comunicacion TYPE string,
             acceso_mixta       TYPE abap_bool,
           END OF ty_descripcion.

    DATA: nombre          TYPE string,
          pais            TYPE string,
          fecha_caducidad TYPE d.

    METHODS: constructor IMPORTING iv_nombre          TYPE string
                                   iv_pais            TYPE string
                                   iv_acreditacion    TYPE i
                                   iv_fecha_caducidad TYPE d,

      descripcion_pase RETURNING VALUE(rs_descripcion) TYPE ty_descripcion,

      get_acreditacion RETURNING VALUE(rv_acreditacion) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA acreditacion TYPE i.
ENDCLASS.

CLASS zcl_acreditado_rpc IMPLEMENTATION.

  METHOD constructor.
    nombre = iv_nombre.
    pais = iv_pais.
    acreditacion = iv_acreditacion.
    fecha_caducidad = iv_fecha_caducidad.

  ENDMETHOD.


  METHOD descripcion_pase.

    rs_descripcion-nombre = nombre.
    rs_descripcion-pais = pais.
    rs_descripcion-acreditacion = acreditacion.
    rs_descripcion-caducidad = fecha_caducidad.

  ENDMETHOD.


  METHOD get_acreditacion.

    rv_acreditacion = acreditacion.

  ENDMETHOD.

ENDCLASS.
