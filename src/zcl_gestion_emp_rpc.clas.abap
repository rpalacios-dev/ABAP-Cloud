CLASS zcl_gestion_emp_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES tty_empleado TYPE TABLE OF zdb_empleado_rpc.
    DATA ms_empleado TYPE zdb_empleado_rpc.

    METHODS:

      constructor IMPORTING iv_nombre          TYPE zdb_empleado_rpc-nombre
                            iv_apellido        TYPE zdb_empleado_rpc-apellido
                            iv_telefono        TYPE zdb_empleado_rpc-telefono
                            iv_experiencia     TYPE i
                            iv_certificaciones TYPE i,

      calculo_sueldo RETURNING VALUE(rv_sueldo) TYPE zde_sueldo_rpc,

      generacion_id_empleado RETURNING VALUE(rv_id) TYPE i,

      alta_empleado RETURNING VALUE(rv_estado_alta) TYPE string,

      modificar_empleado IMPORTING iv_id                         TYPE zdb_empleado_rpc-id_empleado
                         RETURNING VALUE(rv_estado_modificacion) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA:
      mv_nombre          TYPE zdb_empleado_rpc-nombre,
      mv_apellido        TYPE zdb_empleado_rpc-apellido,
      mv_telefono        TYPE zdb_empleado_rpc-telefono,
      mv_experiencia     TYPE i,
      mv_certificaciones TYPE i.

ENDCLASS.



CLASS zcl_gestion_emp_rpc IMPLEMENTATION.

  METHOD constructor.

    mv_nombre = iv_nombre.
    mv_apellido = iv_apellido.
    mv_telefono = iv_telefono.
    mv_experiencia = iv_experiencia.
    mv_certificaciones = iv_certificaciones.

  ENDMETHOD.

  METHOD calculo_sueldo.

    rv_sueldo = 1000 + ( mv_certificaciones * 50 ) + ( mv_experiencia * 100 ).

  ENDMETHOD.


  METHOD generacion_id_empleado.

    SELECT MAX( id_empleado ) FROM zdb_empleado_rpc INTO @DATA(lv_num_registros).

    IF lv_num_registros = 0 OR lv_num_registros IS INITIAL.
      rv_id = 1.
    ELSE.
      rv_id += 1.
    ENDIF.

  ENDMETHOD.



  METHOD alta_empleado.

    CLEAR ms_empleado.

    ms_empleado-nombre = mv_nombre.
    ms_empleado-apellido = mv_apellido.
    ms_empleado-telefono = mv_telefono.
    ms_empleado-sueldo = me->calculo_sueldo(  ).
    ms_empleado-id_empleado = me->generacion_id_empleado(  ).

    INSERT zdb_empleado_rpc FROM @ms_empleado.

    rv_estado_alta = 'Se ha completado con éxito el alta del empleado'.

  ENDMETHOD.

  METHOD modificar_empleado.


  ENDMETHOD.

ENDCLASS.
