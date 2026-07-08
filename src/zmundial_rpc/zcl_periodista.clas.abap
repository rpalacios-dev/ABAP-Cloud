CLASS zcl_periodista DEFINITION
  PUBLIC
  INHERITING FROM zcl_acreditado_rpc
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: medio_comunicacion TYPE string,
          acceso_mixta       TYPE abap_bool.

    METHODS: constructor IMPORTING iv_nombre             TYPE string
                                   iv_pais               TYPE string
                                   iv_acreditacion       TYPE i
                                   iv_fecha_caducidad    TYPE d
                                   iv_medio_comunicacion TYPE string
                                   iv_acceso_mixta       TYPE abap_bool,

      descripcion_pase REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_periodista IMPLEMENTATION.
  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre
                        iv_pais = iv_pais
                        iv_acreditacion = iv_acreditacion
                        iv_fecha_caducidad = iv_fecha_caducidad ).

    medio_comunicacion = iv_medio_comunicacion.
    acceso_mixta = iv_acceso_mixta.

  ENDMETHOD.

  METHOD descripcion_pase.

    CLEAR rs_descripcion.

    rs_descripcion-nombre = nombre.
    rs_descripcion-pais = pais.
    rs_descripcion-acreditacion = get_acreditacion( ).
    rs_descripcion-caducidad = fecha_caducidad.
    rs_descripcion-medio_comunicacion = medio_comunicacion.
    rs_descripcion-acceso_mixta = acceso_mixta.

  ENDMETHOD.

ENDCLASS.
