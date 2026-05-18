CLASS zcl_funcion_procesamiento_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FUNCION_PROCESAMIENTO_RPC IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "FUNCIONES DE PROCESAMIENTO
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*    DATA lv_var TYPE string VALUE 'Hola, este es el curso de ABAP'.
*
*    "length -> longitud de una cadena de texto
*    out->write( | { lv_var } - Longitud -> { strlen( lv_var ) } | ).
*
*    "to_upper -> texto a mayúsculas
*    out->write( | { lv_var } - Mayusculas -> { to_upper( lv_var ) } | ).
*
*    "to_lower -> texto a minúsculas
*    out->write( | { lv_var } - Minúsculas -> { to_lower( lv_var ) } | ).
*
*    "reverse -> del revés
*    out->write( | { lv_var } - Reverso -> { reverse( lv_var ) } | ).
*
*    "shift_left -> eliminar espacios a la izquierda
*    out->write( | { lv_var } - Shift left -> { shift_left( val = lv_var places = 5 ) } | ).
*
*    "shift_right -> eliminar espacios a la derecha
*    out->write( | { lv_var } - Shift right -> { shift_right( val = lv_var places = 5 ) } | ).
*
*    "substring -> extraer cadenas de texto
*    out->write( | { lv_var } - Subcadena -> { substring( val = lv_var off = 9 len = 6 ) } | ).
*
*    "search -> buscar una cadena de texto
*    "out->write( | { lv_var } - Buscar -> { search( val = lv_var sub = 'ABAP' ) } | ).
*
*    "substring_from -> extraer una cadena de texto a partir de un texto
*    out->write( | { lv_var } - Substring from -> { substring_from( val = lv_var sub = 'el' ) } | ).
*
*    "substring_before -> extraer una cadena de texto a partir de un texto
*    out->write( | { lv_var } - Substring after -> { substring_before( val = lv_var sub = 'el' ) } | ).
*
*
*    "substring_after -> extraer una cadena de texto a partir de un texto
*    out->write( | { lv_var } - Substring after -> { substring_after( val = lv_var sub = 'el' ) } | ).
*
*    "condense -> eliminar espacios en blanco
*    out->write( | { lv_var } - Condense -> { condense( lv_var ) } | ).



    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "FUNCIONES DE CONTENIDO - Usadas sobre todo en ABAP antiguo
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    DATA: lv_text     TYPE string,
          lv_pattern  TYPE string,
          lv_pattern2 TYPE string.

    lv_text = 'the employees number and mail are 123-456-7890 and name-surname@gmail.com '.
    "Patrón tlf
    lv_pattern = `\d{3}-\d{3}-\d{4}`.
    "Patrón mail
    lv_pattern2 = `\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{ 2, }\b`.

    "Filtro para buscar siguiendo un patrón, siendo "occ" la selección de la primera coincidencia
    DATA(lv_number) = match( val = lv_text pcre = lv_pattern occ = 1 ).
    DATA(lv_correo) = match( val = lv_text pcre = lv_pattern2 occ = 1 ).

    IF contains( val = lv_text pcre = lv_pattern2 ).
      DATA(lv_count) = count( val = lv_text pcre = lv_pattern2 ).
      out->write( | Contiene { lv_count } dirección/es de correo -> { lv_correo }| ).

    ELSE.
      out->write( | { lv_text } - No contiene -> { lv_correo } | ).

    ENDIF.



  ENDMETHOD.
ENDCLASS.
