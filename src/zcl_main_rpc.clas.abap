CLASS zcl_main_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_rpc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES tty_emp TYPE STANDARD TABLE OF zdb_eje_obj_rpc.

    DATA: lt_accion  TYPE i VALUE 4,
          lv_mensaje TYPE string,
          lt_tabla   TYPE tty_emp.

    DATA(lo_empleado) = NEW zcl_creadora_rpc(
      iv_nombre          = 'Jesús'
      iv_apellido        = 'Pérez'
      iv_telefono        = '111223344'
      iv_experiencia     = 7
      iv_certificaciones = 2
    ).

    CASE lt_accion.

      WHEN 1.
        lv_mensaje = lo_empleado->alta_empleado(  ).
        out->write( lv_mensaje ).

      WHEN 2.
        lv_mensaje = lo_empleado->modificacion(
        iv_nombre = 'Manuel'
        iv_apellido = 'Rodriguez'
        iv_telefono = '111223344'
        iv_id_empleado = 2
        iv_experiencia = 1
        iv_certificaciones = 2 ).
        out->write( lv_mensaje ).

      WHEN 3.
        lt_tabla = lo_empleado->traer_lt( iv_id_empleado = 0 ).
        out->write( lt_tabla ).

      WHEN 4.

        lt_tabla = lo_empleado->traer_n_filas( iv_n_filas = 2 ).
        out->write( lt_tabla ).

      WHEN OTHERS.
        out->write( |La operación seleccionada no es válida| ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
