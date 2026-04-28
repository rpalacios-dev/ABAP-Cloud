CLASS zcl_clase_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_clase_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " TIPOS DE VARIABLES "
    " TIPOS COMPLETOS "

    "Fechas "AAAAA-MM-DD"
    DATA lv_d TYPE d VALUE 20260428.

    "Tiempo hhmmss"
    DATA lv_t TYPE t VALUE 095513.

    "i almacena hasta 4 bytes de información
    "f equivale a float
    "String tipo para cadena de caracteres, es dinámico

    " TIPOS INCOMPLETOS (uso de length)"

    " C tipo para cadena de caracteres (longitud: 1 - 65535)
    " N tipo de cadena de caracteres numerica (longitud: 1 - 65535)
    " X tipo para cadena hexadecimal
    " P tipo para números empaquetado 1 a 16 bytes

    DATA lv_p TYPE p LENGTH 8 DECIMALS 2 value '202501.10'.
    DATA lv_decimal TYPE p LENGTH 3 DECIMALS 2.
    DATA lv_c TYPE c LENGTH 20 VALUE 'Experis'.

  ENDMETHOD.

ENDCLASS.
