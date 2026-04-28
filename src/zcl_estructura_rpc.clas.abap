CLASS zcl_estructura_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_estructura_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    types:BEGIN of ty_cliente,
*          nombre type zde_cliente_rpc,
*          edad type i,
*          telefono type string,
*          correo type string,
*         end of ty_cliente.
*
*    DATA ls_cliente TYPE ty_cliente.
*
*    ls_cliente-nombre = 'Rebeca'.
*    ls_cliente-edad = 23.
*    ls_cliente-telefono = '123456789'.
*
*    out->write( ls_cliente ).
*
*    """""""""""""""""""""""""""""""""""""""""""""""""
*
*    DATA(ls_cliente2) = value ty_cliente( nombre = 'Fernando' edad = 32 correo = 'fernando@gmail.com' ).
*
*    out->write( ls_cliente2 ).
*
*    """""""""""""""""""""""""""""""""""""""""""""""""
*
*    data: begin of ls_cliente3,
*          nombre type string VALUE 'Laura',
*          id TYPE i,
*          edad TYPE i VALUE 7,
*          end of LS_cliente3.
*
*
*    ls_cliente3-id = 8.
*    out->write( ls_cliente3 ).

    " EJERCICIO PRÁCTICO "

    TYPES:BEGIN OF ty_cliente_ejercicio,
          nombre TYPE zde_cliente_rpc,
          edad type zde_edad_rpc,
          telefono type zde_telefono_rpc,

          end of TY_CLIENTE_ejercicio.


     " TABLAS INTERNAS "

     types:BEGIN of ty_cliente,
          nombre type zde_cliente_rpc,
          id type i,
          edad type i,
          telefono type string,
          correo type string,
         end of ty_cliente.

     data ls_cliente type ty_cliente.
     data lt_cliente type table of ty_cliente.

    ls_cliente-nombre = 'Rebeca'.
    ls_cliente-id = '009'.
    ls_cliente-edad = 23.
    ls_cliente-telefono = '123456789'.
    ls_cliente-correo = 'rebeca@gmail.com'.

    insert ls_cliente into lt_cliente index 1.

    ls_cliente-nombre = 'María'.
    ls_cliente-id = '010'.
    ls_cliente-edad = 23.
    ls_cliente-telefono = '123456789'.
    ls_cliente-correo = 'maria@gmail.com'.

    insert ls_cliente into lt_cliente index 2.

    insert value #(
        nombre = 'Laura'
        edad = 51
        id = 003
        telefono = '987654321'
        correo = 'laura@gmail.com'
    ) into table lt_cliente. "Podría añadir index

    "Linea en blanco: insert initial line into table lt_cliente
"    out->write( lt_cliente ).

    "Copiado de tablas (no se suele hacer)
    DATA lt_cliente2 like lt_cliente.

    "Duplicidad de contenido
"    insert lines of lt_cliente into table lt_cliente2.

    "Duplicidad hasta X registro
"    insert lines of lt_cliente to 1 into table lt_cliente2.

    "Duplicidad de X registros
    insert lines of lt_cliente from 1 to 2 into table lt_cliente2.

    out->write( lt_cliente2 ).

  ENDMETHOD.

ENDCLASS.
