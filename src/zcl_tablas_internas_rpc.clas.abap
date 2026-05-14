CLASS zcl_tablas_internas_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas_internas_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " TABLAS INTERNAS SIMPLES
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA lv_numero TYPE i VALUE 19.


    "1. Creación de la tabla
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA lt_numeros TYPE TABLE OF i.


    "2. Añadir valores a la tabla con APPEND
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    APPEND 19 TO lt_numeros.
    APPEND lv_numero TO lt_numeros.
    APPEND 2 * lv_numero TO lt_numeros.


    "3. 'CLEAR <table-name>' elimina el contenido de una tabla
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


    "4. Extracción de un valor seleccionado
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA(lv_segunda_pos) = lt_numeros[ 2 ].


    "5. Lectura de la tabla con LOOP AT INTO
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT lt_numeros INTO DATA(lv_num).
      out->write( |{ lv_num } | ).
    ENDLOOP.


    "6. Usando 'sy-tabix' podemos saber el índice del elemento
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    LOOP AT lt_numeros INTO lv_num.
      out->write( |Fila { sy-tabix }: { lv_num } | ).
    ENDLOOP.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "APUNTES CLASE
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " TABLAS INTERNAS "

    TYPES:BEGIN OF ty_cliente,
            nombre   TYPE string,
            id       TYPE i,
            edad     TYPE i,
            telefono TYPE string,
            correo   TYPE string,
          END OF ty_cliente.

    DATA ls_cliente TYPE ty_cliente.
    DATA lt_cliente TYPE TABLE OF ty_cliente.

    ls_cliente-nombre = 'Rebeca'.
    ls_cliente-id = '009'.
    ls_cliente-edad = 23.
    ls_cliente-telefono = '123456789'.
    ls_cliente-correo = 'rebeca@gmail.com'.

    INSERT ls_cliente INTO lt_cliente INDEX 1.

    ls_cliente-nombre = 'María'.
    ls_cliente-id = '010'.
    ls_cliente-edad = 23.
    ls_cliente-telefono = '123456789'.
    ls_cliente-correo = 'maria@gmail.com'.

    INSERT ls_cliente INTO lt_cliente INDEX 2.

    INSERT VALUE #(
        nombre = 'Laura'
        edad = 51
        id = 003
        telefono = '987654321'
        correo = 'laura@gmail.com'
    ) INTO TABLE lt_cliente. "Podría añadir index

    "Linea en blanco: insert initial line into table lt_cliente
    "    out->write( lt_cliente ).

    "Copiado de tablas (no se suele hacer)
    DATA lt_cliente2 LIKE lt_cliente.

    "Duplicidad de contenido
    "    insert lines of lt_cliente into table lt_cliente2.

    "Duplicidad hasta X registro
    "    insert lines of lt_cliente to 1 into table lt_cliente2.

    "Duplicidad de X registros
    INSERT LINES OF lt_cliente FROM 1 TO 2 INTO TABLE lt_cliente2.

    out->write( lt_cliente2 ).



  ENDMETHOD.
ENDCLASS.
