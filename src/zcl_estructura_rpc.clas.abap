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

    "Explicación de estructuras
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "Las estructuras son matrices en las que la primera fila será
    "el tipo de variable, es decir, los nombres de las variables y
    "el resto de filas serán los valores de las variables.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "ESTRUCTURAS SIMPLES
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


    "1. Declaración de tipo
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TYPES:BEGIN OF ty_cliente,
            nombre   TYPE string,
            edad     TYPE i,
            telefono TYPE string,
            correo   TYPE string,
          END OF ty_cliente.


    "2. Declaración de estructura.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA ls_cliente TYPE ty_cliente.


    "3. Asignación de valores
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ls_cliente-nombre = 'Rebeca'.
    ls_cliente-edad = 23.
    ls_cliente-telefono = '123456789'.

    out->write( ls_cliente ).


    "4. Asignación de valores en línea
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA(ls_cliente2) = VALUE ty_cliente( nombre = 'Fernando' edad = 32 correo = 'fernando@gmail.com' ).


    "5. Declaración de estructura con valor (forma 1)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA: BEGIN OF ls_cliente3,
            nombre TYPE string VALUE 'Laura',
            id     TYPE i,
            edad   TYPE i VALUE 7,
          END OF LS_cliente3.

    "6. Declaración de estructura con valor (forma 2)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    ls_cliente = VALUE #( nombre = 'Carlos' edad = 21 telefono = '+34111223344' ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "ESTRUCTURAS ANIDADAS
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


    "1. Declaración de estructura anidada
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA: BEGIN OF ls_empleado_info,
    "1.1 Primer tipo
            BEGIN OF info,
              id     TYPE zde_id_dsf VALUE 01,
              nombre TYPE string VALUE 'daniel',
            END OF info,
    "1.2 Segundo tipo
            BEGIN OF direccion,

              ciudad TYPE string VALUE 'madrid',
              calle  TYPE string VALUE 'norfeo',
              pais   TYPE string VALUE 'españa',
            END OF direccion,
    "1.3 Tercer tipo
            BEGIN OF posicion,

              departamento TYPE string VALUE 'it',
              sueldo       TYPE p DECIMALS 2 VALUE '2000.55',
            END OF posicion,

          END OF ls_empleado_info.
    out->write( ls_empleado_info ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "EJERCICIO CLASE 13/05/26
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    TYPES:BEGIN OF ty_muebles_ejercicio,
            sofa    TYPE i,
            mesa    TYPE i,
            cama    TYPE i,
            lampara TYPE i,
          END OF ty_muebles_ejercicio.

    DATA ls_mueble TYPE ty_muebles_ejercicio.

    ls_mueble-sofa = 3.
    ls_mueble-mesa = 6.
    ls_mueble-cama = 0.
    ls_mueble-lampara = 8.

    out->write( ls_mueble ).

  ENDMETHOD.

ENDCLASS.
