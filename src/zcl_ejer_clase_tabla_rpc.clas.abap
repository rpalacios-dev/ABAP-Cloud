CLASS zcl_ejer_clase_tabla_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer_clase_tabla_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "EJERCICIO PRÁCTICO
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*    1. Crear una nueva tabla e introducir datos de la forma 'moderna'
*    en lt_tabla1
*
*    lt_empleado = value #(
*    ( nombre = 'Ana' edad = 24 correo = 'ana@gmail.com')
*    ( nombre = 'Nerea' edad = 24 correo = 'nerea@gmail.com')
*    ( nombre = 'Francisco' edad = 24 correo = 'francisco@gmail.com')
*    ( nombre = 'Carlos' edad = 24 correo = 'carlos@gmail.com')
*    ).

    out->write( |EJERCICIO PRACTICO| ).

    TYPES: BEGIN OF ty_empleado,
             nombre TYPE string,
             edad   TYPE i,
             correo TYPE string,
           END OF ty_empleado.

    DATA lt_empleado TYPE TABLE OF ty_empleado.

    lt_empleado = VALUE #(
    ( nombre = 'Ana' edad = 24 correo = 'ana@gmail.com' )
    ( nombre = 'Nerea' edad = 56 correo = 'nerea@gmail.com' )
    ( nombre = 'Francisco' edad = 19 correo = 'francisco@gmail.com' )
    ( nombre = 'Carlos' edad = 38 correo = 'carlos@gmail.com' )
    ).


*    2. Crear una segunda tabla que copie los tipos directamemte de la
*    tabla original 'lt_tabla1', a la nueva tabla 'lt_tabla2'
    out->write( |  | ).
    out->write( |Ejercicio 2 - LIKE| ).

    DATA lt_tabla1 LIKE lt_empleado.
    DATA lt_tabla2 LIKE lt_empleado.

    out->write( |  | ).
    out->write( | TABLA 2 | ).
    out->write( lt_tabla2 ).

    INSERT LINES OF lt_empleado INTO TABLE lt_tabla2.

*    3. En lt_tabla2 introduce en la línea 2 una línea en blanco
    out->write( |  | ).
    out->write( |Ejercicio 3 - INSERT INITAL LINE| ).

    INSERT INITIAL LINE INTO lt_tabla2 INDEX 2.

    out->write( |  | ).
    out->write( | TABLA 2 | ).
    out->write( lt_tabla2 ).

*    4. Usando APPEND, añade una nueva línea a la tabla lt_tabla2
    out->write( |  | ).
    out->write( |Ejercicio 4 - APPEND| ).

    APPEND VALUE #( nombre = 'Javier' edad = 31 correo = 'javier@gmail.com' ) TO lt_tabla2.

    out->write( |  | ).
    out->write( | TABLA 2 | ).
    out->write( lt_tabla2 ).

*    5. Detecta el tamaño máximo de registros y asigna ese número a la
*    función 'random' para ejecutarla 2 veces y extraer 2 números que
*    serán el mínimo y máximo de líneas que tendremos que extraer de la
*    tabla lt_tabla2 para posteriormente pegarlas o añadirlas usando INSERT
*    INDEX en las primeras filas de la tabla lt_tabla1
    out->write( |  | ).
    out->write( |Ejercicio 5 - RANDOM| ).

    DATA(lv_registros) = lines( lt_tabla2 ).
    DATA lv_contador TYPE i VALUE 0.

    "random se trata de una función que al llamarla 2 veces
    "los valores serán diferentes
    DATA(lv_random) = cl_abap_random_int=>create(
                    seed = cl_abap_random=>seed( )
                    min  = 1
                    max  = lv_registros ).

    DATA(lv_min) = lv_random->get_next( ).
    DATA(lv_max) = lv_random->get_next( ).

    "Comprobación de mínimo y máximo

    IF lv_min > lv_max.
      DATA(lv_aux) = lv_min.
      lv_min = lv_max.
      lv_max = lv_aux.
    ENDIF.

    "Copiado de filas

    INSERT LINES OF lt_tabla2 FROM lv_min TO lv_max INTO TABLE lt_tabla1.

    out->write( |  | ).
    out->write( | TABLA 1 | ).
    out->write( lt_tabla1 ).


  ENDMETHOD.
ENDCLASS.
