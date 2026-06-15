CLASS zcl_cont_tabla_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cont_tabla_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA lt_alumnos TYPE TABLE OF zdb_alumnos_rpc.

    " Generamos la lista de 10 alumnos de prueba (ID como número entero)
    lt_alumnos = VALUE #(
      ( id = '0001' correo = 'alejandro@email.com' nombre = 'Alejandro' edad = 20 telefono = '600111222' )
      ( id = '0002' correo = 'beatriz@email.com'   nombre = 'Beatriz'   edad = 22 telefono = '611222333' )
      ( id = '0003' correo = 'daniel@email.com'    nombre = 'Daniel'    edad = 19 telefono = '622333444' )
      ( id = '0004' correo = 'gabriela@email.com'  nombre = 'Gabriela'  edad = 21 telefono = '633444555' )
      ( id = '0005' correo = 'hector@email.com'    nombre = 'Hector'    edad = 23 telefono = '644555666' )
      ( id = '0006' correo = 'julia@email.com'     nombre = 'Julia'     edad = 20 telefono = '655666777' )
      ( id = '0007' correo = 'marcos@email.com'    nombre = 'Marcos'    edad = 24 telefono = '666777888' )
      ( id = '0008' correo = 'natalia@email.com'   nombre = 'Natalia'   edad = 18 telefono = '677888999' )
      ( id = '0009' correo = 'ricardo@email.com'   nombre = 'Ricardo'   edad = 22 telefono = '688999000' )
      ( id = '0010' correo = 'valeria@email.com'   nombre = 'Valeria'   edad = 21 telefono = '699000111' )
    ).

    " Usamos MODIFY para poder ejecutarlo las veces que quieras sin Dumps
    INSERT zdb_alumnos_rpc FROM TABLE @lt_alumnos.

*    DATA lt_clientes TYPE TABLE OF zdb_cliente_rpc.
*
*    lt_clientes = VALUE #(
*      ( id = '0001' nombre = 'Carlos'    apellido = 'Mendoza'  direccion = 'Calle Mayor 12'      correo = 'carlos.mendoza@email.com'    telefono = '600112233' )
*      ( id = '0002' nombre = 'Ana'       apellido = 'Gomez'    direccion = 'Av. Constitución 4'  correo = 'ana.gomez@email.com'         telefono = '611223344' )
*      ( id = '0003' nombre = 'Luis'      apellido = 'Martinez' direccion = 'Plaza España 8'      correo = 'luis.mtz@email.com'          telefono = '622334455' )
*      ( id = '0004' nombre = 'Sofia'     apellido = 'Rodriguez' direccion = 'Calle Primavera 23'  correo = 'sofia.rod@email.com'         telefono = '633445566' )
*      ( id = '0005' nombre = 'Javier'    apellido = 'Lopez'    direccion = 'Paseo del Prado 15'  correo = 'javi.lopez@email.com'        telefono = '644556677' )
*      ( id = '0006' nombre = 'Elena'     apellido = 'Sanchez'  direccion = 'Calle Nueva 42'      correo = 'elena.sanchez@email.com'     telefono = '655667788' )
*      ( id = '0007' nombre = 'Alejandro' apellido = 'Fernandez' direccion = 'Av. del Sur 7'        correo = 'ale.fer@email.com'           telefono = '666778899' )
*      ( id = '0008' nombre = 'Lucia'     apellido = 'Perez'    direccion = 'Calle Luna 19'       correo = 'lucia.perez@email.com'       telefono = '677889900' )
*      ( id = '0009' nombre = 'Diego'     apellido = 'Garcia'   direccion = 'Camino Real 55'      correo = 'diego.garcia@email.com'      telefono = '688990011' )
*      ( id = '0010' nombre = 'Marta'     apellido = 'Castro'   direccion = 'Av. Estación 30'     correo = 'marta.castro@email.com'      telefono = '699001122' )
*    ).
*
*    MODIFY zdb_cliente_rpc FROM TABLE @lt_clientes.
*
*    IF sy-subrc = 0.
*      out->write( 'La tabla zdb_cliente_rpc se ha actualizado con los 10 registros.' ).
*    ENDIF.

    "EJERCICIO CLASE
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*    DATA ls_nuevo_registro TYPE zdb_cliente_rpc.
*    ls_nuevo_registro = VALUE #(
*      id = '0011'
*      nombre = 'Raquel'
*      apellido = 'Pineda'
*      direccion = 'Av. Estación 12'
*      correo = 'raquel.pineda@email.com'
*      telefono = '699001122'
*     ).
*
*    WAIT UP TO 20 SECONDS.
*    MODIFY zdb_cliente_rpc FROM @ls_nuevo_registro.


  ENDMETHOD.
ENDCLASS.
