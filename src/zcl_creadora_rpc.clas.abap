CLASS zcl_creadora_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES tty_emp TYPE STANDARD TABLE OF zdb_eje_obj_rpc WITH EMPTY KEY.

    METHODS:

      constructor IMPORTING iv_nombre          TYPE zde_nombre_rpc
                            iv_apellido        TYPE zde_apellido_rpc
                            iv_telefono        TYPE zde_telefono_rpc
                            iv_experiencia     TYPE i
                            iv_certificaciones TYPE i,

      calcular_sueldo,
      ex_id_empleado,
      alta_empleado RETURNING VALUE(rv_mensaje) TYPE string,
      modificacion IMPORTING iv_nombre          TYPE zde_nombre_rpc
                             iv_apellido        TYPE zde_apellido_rpc
                             iv_telefono        TYPE zde_telefono_rpc
                             iv_experiencia     TYPE i
                             iv_certificaciones TYPE i
                             iv_id_empleado     TYPE i
                   RETURNING VALUE(rv_mensaje)  TYPE string,

      traer_lt IMPORTING iv_id_empleado  TYPE i
               RETURNING VALUE(rv_tabla) TYPE tty_emp,

      traer_n_filas IMPORTING iv_n_filas      TYPE i
                    RETURNING VALUE(rv_tabla) TYPE tty_emp.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      lt_registro     TYPE tty_emp,
      ls_prueba       TYPE zdb_eje_obj_rpc,
      experiencia     TYPE i,
      id_empleado     TYPE i,
      certificaciones TYPE i.

ENDCLASS.



CLASS zcl_creadora_rpc IMPLEMENTATION.

  METHOD constructor.

    ls_prueba-nombre = iv_nombre.
    ls_prueba-apellido = iv_apellido.
    ls_prueba-telefono = iv_telefono.
    experiencia = iv_experiencia.
    certificaciones = iv_certificaciones.
    ls_prueba-currency_code = 'EUR'.

  ENDMETHOD.



  METHOD calcular_sueldo.

    "Cálculo de sueldo con la fórmula proporcionada
    ls_prueba-sueldo = ( certificaciones * 50 + experiencia * 100 ) + 1000.

  ENDMETHOD.



  METHOD ex_id_empleado.

    "Comprobación ID más alto
    SELECT MAX( id_empleado ) FROM zdb_eje_obj_rpc INTO @DATA(id_maximo).
    "Comprobación consulta exitosa
    IF sy-subrc = 0.
      IF id_maximo IS INITIAL.
        ls_prueba-id_empleado = 00000001.
      ELSE.
        ls_prueba-id_empleado = id_maximo + 1.
      ENDIF.
    ENDIF.

  ENDMETHOD.



  METHOD alta_empleado.

    me->calcular_sueldo(  ).
    me->ex_id_empleado(  ).

    MODIFY zdb_eje_obj_rpc FROM @ls_prueba.

    IF sy-subrc = 0.
      COMMIT WORK.
      rv_mensaje = 'Subida correcta'.
    ELSE.
      rv_mensaje = 'Error en la subida'.
    ENDIF.

  ENDMETHOD.


  METHOD modificacion.

    "Asignación de nuevos valores
    ls_prueba-nombre = iv_nombre.
    ls_prueba-apellido = iv_apellido.
    ls_prueba-telefono = iv_telefono.
    ls_prueba-currency_code = 'EUR'.
    ls_prueba-id_empleado = iv_id_empleado.
    experiencia = iv_experiencia.
    certificaciones =  iv_certificaciones.

    "Comprobación existencia ID
    SELECT SINGLE @abap_true
    FROM zdb_eje_obj_rpc
    WHERE id_empleado = @ls_prueba-id_empleado INTO @DATA(lv_existe).

    "Comprobación éxito de la consulta
    IF sy-subrc = 0 AND lv_existe.
      me->calcular_sueldo(  ).
      MODIFY zdb_eje_obj_rpc FROM @ls_prueba.
      COMMIT WORK.
      rv_mensaje = 'El empleado ha sido modificado con éxito.'.
    ELSE.
      rv_mensaje = 'El ID no existe en la base de datos, no se ha podido hacer la modificación.'.
    ENDIF.

  ENDMETHOD.



  METHOD traer_lt.

    "Limpiar el registro para que no se acumulen consultas
    CLEAR lt_registro.

    "Comprobación de ID introducido para realizar una de las 2 operaciones
    IF iv_id_empleado = 0.
      SELECT * FROM zdb_eje_obj_rpc
      ORDER BY id_empleado ASCENDING
      INTO TABLE @me->lt_registro.
    ELSE.
      SELECT * FROM zdb_eje_obj_rpc
      WHERE id_empleado = @iv_id_empleado
      INTO TABLE @me->lt_registro.
    ENDIF.

    rv_tabla = lt_registro.

  ENDMETHOD.



  METHOD traer_n_filas.

    CLEAR lt_registro.

    SELECT * FROM zdb_eje_obj_rpc
    ORDER BY id_empleado
    INTO TABLE @lt_registro
    UP TO @iv_n_filas ROWS.

    rv_tabla = lt_registro.

  ENDMETHOD.

ENDCLASS.
