CLASS zcl_ejer_tabla_strd_apun_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer_tabla_strd_apun_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "TAREA 1: Calcular los números
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  En su propio paquete, cree una nueva clase global. Defina una
*  constante para el número de iteraciones y una tabla interna para
*  los números de Fibonacci. A continuación, calcule los números de
*  Fibonacci en una iteración y almacénelos en la tabla interna.
*    1. Cree una nueva clase global que implemente la interfaz IF_OO_ADT_CLASSRUN (nombre
*sugerido: ZCL_##_ITERATE, donde ## representa su número de grupo).
*    2. En el método IF_OO_ADT_CLASSRUN~MAIN, defina una constante para el número de
*iteraciones (nombre sugerido: recuento) con un valor pequeño, por ejemplo, 20.
*    3. Declare una tabla interna simple para almacenar los números de Fibonacci (nombre
*sugerido: números).
*    4. Implemente una iteración que se ejecute max_count veces.
*    5. Dentro de la iteración, implemente una distinción CASE basada en el contador de
*iteraciones integrado: en la primera iteración, añada el valor 0 a los números de tabla
*interna. En la segunda iteración, añada el valor 1 al final de los números de tabla interna.
*    6. Añada una rama que se ejecute para todos los demás valores. En esta rama, calcule la
*nueva entrada como la suma de las dos entradas anteriores en números

    out->write( |Ejercicio 1: Calcular los números de Fibonacci| ).

    CONSTANTS lc_recuento TYPE i VALUE 20.
    DATA lt_numeros TYPE TABLE OF i.

    DO lc_recuento TIMES.
      CASE sy-index.
        WHEN 1.
          APPEND 0 TO lt_numeros.
        WHEN 2.
          APPEND 1 TO lt_numeros.
        WHEN OTHERS.
          DATA(lv_nuevo_numero) = lt_numeros[ sy-index - 1 ] + lt_numeros[ sy-index - 2 ].
          APPEND lv_nuevo_numero TO lt_numeros.
      ENDCASE.
    ENDDO.

    out->write( lt_numeros ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "TAREA 2: Preparar una salida formateada
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*En un loop sobre la tabla interna, prepare una salida formateada que enumere cada número
*de Fibonacci con su respectivo número secuencial. Prepare la salida en otra tabla interna del
*tipo de fila string.
*1. Al principio del método if_oo_adt_classrun~main, declare una tabla interna del tipo
*de fila string (nombre sugerido: salida).
*2. Implemente un loop sobre los números de tabla interna para leer los números de
*Fibonacci uno por uno en un número variable.
*3. Declare una variable entera (nombre sugerido: contador), que fije en cero antes del bucle
*y aumente en 1 en cada iteración.
*4. En cada iteración, añada una nueva fila a la salida de la tabla interna que contenga el
*contenido del contador (l4 caracteres de ancho, alineados a la izquierda), dos puntos (;)
*y el contenido del número (10 caracteres de ancho, justificado a la derecha).

    out->write( |Ejercicio 2: salida formateada| ).

    DATA lt_salida TYPE TABLE OF string.
    DATA lv_contador TYPE i value 0.

    LOOP AT lt_numeros INTO DATA(lv_num).
        lv_contador += 1.
        APPEND |{ lv_contador WIDTH = 4 ALIGN = LEFT } { lv_num WIDTH = 10 ALIGN = RIGHT }| TO lt_salida.
    ENDLOOP.

    out->write( lt_salida ).


  ENDMETHOD.
ENDCLASS.
