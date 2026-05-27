CLASS zcl_tabla_rangos_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tabla_rangos_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "1. Elementos a usar
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "sign -> dice si la condición es incluir (I) o excluir (E).
    "I = lo quiero
    "E = no lo quiero
    " option -> Dice el tipo de comparación
    "NE = Diferente a X
    "GT = Mayor que X
    "LT = Menor que X
    "BT = Entre X y Z
    "CP = patrón (similar a un LIKE)
    "low -> Es el valor mínimo o exacto
    "high -> Es el valor máximo (solo se usa con un entre)


    "2. Ejemplo visual
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Imagina una lista de coches de la que quieres extraer los rojos
    "y los azules, pero no los amarillos

    "sing       option      low     high
    " I           eq        rojo
    " I           eq        azul
    " E           eq        amarillo

    DATA lr_asientos TYPE RANGE OF /dmo/plane_seats_occupied.
*    out->write( |TABLA ORIGINAL| ).
*    out->write( lr_asientos ).
*    out->write( | | ).


    "3. Casos prácticos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "3.1 Asientos entre 50 - 100
    APPEND VALUE #( sign = 'I' option = 'BT' low = 50 high = 100 ) TO lr_asientos.

    "3.2 Asientos con exactamente 150 asientos
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 150 ) TO lr_asientos.

    "3.3 No incluir vuelos con menos de 10 asientos
    APPEND VALUE #( sign = 'E' option = 'LT' low = 10 ) TO lr_asientos.

    "3.4 Inserción en una nueva tabla
    DATA lt_vuelos TYPE TABLE OF /dmo/flight.

    SELECT * FROM /dmo/flight
    WHERE seats_occupied IN @lr_asientos
    INTO TABLE @lt_vuelos.

    "3.5 Impresión de los datos
*    out->write( |TABLA FILTRADA| ).
*    LOOP AT lt_vuelos INTO DATA(ls_vuelos).
*      out->write( ls_vuelos-carrier_id ).
*      out->write( ls_vuelos-seats_occupied ).
*
*    ENDLOOP.
*    out->write( | | ).


    "3.5 Ejercicio tabla de rangos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*   Contexto
*
*   Trabajas para una agencia de viajes que necesita filtrar vuelos
*   según distintos criterios comerciales. Vas a construir varias tablas
*   de rangos y usarlas para consultar /DMO/FLIGHT.
*
*   Tareas
*   Tarea 1 — Compañías concretas (I + EQ) Crea una range table que
*   seleccione únicamente los vuelos de las compañías AA, LH y SQ.
*
    DATA lr_company TYPE RANGE OF /dmo/flight-carrier_id.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'AA' ) TO lr_company.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'LH' ) TO lr_company.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 'SQ' ) TO lr_company.

    SELECT * FROM /dmo/flight
    WHERE carrier_id IN @lr_company
    INTO TABLE @DATA(lt_resultado).

*   Tarea 2 — Rango de fechas (I + BT) Crea una range table que
*   seleccione los vuelos cuya fecha esté entre el 01.01.2025 y el 30.06.2026 (ambos incluidos).
*
    DATA lr_date TYPE RANGE OF /dmo/flight-flight_date.
    APPEND VALUE #( sign = 'I' option = 'BT' low = '20250101' high = '20260630' ) TO lr_date.

    SELECT * FROM /dmo/flight
    WHERE flight_date IN @lr_date
    INTO TABLE @lt_resultado.

*   Tarea 3 — Patrón de conexión (I + CP) Crea una range table que
*   seleccione las conexiones cuyo número empiece por 1 (es decir, 1xxx).
*
    DATA lr_pattern TYPE RANGE OF /dmo/flight-connection_id.
    APPEND VALUE #( sign = 'I' option = 'CP' low = '1*' ) TO lr_pattern.

    SELECT * FROM /dmo/flight
    WHERE connection_id IN @lr_pattern
    INTO TABLE @lt_resultado.


*   Tarea 4 — Exclusión (E + EQ) Crea una range table que seleccione
*   todas las compañías excepto UA.
*
    DATA lr_exclusion TYPE RANGE OF /dmo/flight-carrier_id.
    APPEND VALUE #( sign = 'E' option = 'EQ' low = 'UA' ) TO lr_exclusion.

    SELECT * FROM /dmo/flight
    WHERE carrier_id IN @lr_exclusion
    INTO TABLE @lt_resultado.

*   Tarea 5 — Precio (I + GT y I + LE) Crea una range table que seleccione
*   los vuelos con precio mayor que 100 y, en una segunda línea, los de
*   precio menor o igual a 50 (dos tramos en la misma tabla).
*
    DATA lr_price TYPE RANGE OF /dmo/flight-price.
    APPEND VALUE #( sign = 'I' option = 'GT' low = 100 ) TO lr_price.
    APPEND VALUE #( sign = 'I' option = 'LE' low = 50 ) TO lr_price.

    SELECT * FROM /dmo/flight
    WHERE price IN @lr_price
    INTO TABLE @lt_resultado.

*   Tarea 6 — Consulta combinada Lanza una SELECT sobre /DMO/FLIGHT que
*   use simultáneamente los rangos de las Tareas 1, 2 y 4, y muestra
*   cuántas líneas devuelve.
*
    SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, flight_date, price
    WHERE carrier_id IN @lr_company AND flight_date IN @lr_date AND carrier_id IN @lr_exclusion
    INTO TABLE @DATA(lt_consulta_combinada).

    DATA(lv_lineas) = lines( lt_consulta_combinada ).

    out->write( | | ).
    out->write( |RESULTADOS EJERCICIOS 1-5 | ).
    out->write( lt_resultado ).
    out->write( | | ).
    out->write( |RESULTADO EJERCICIO 6 | ).
    out->write( lt_consulta_combinada ).
    out->write( |Lineas totales: { lv_lineas }| ).


  ENDMETHOD.
ENDCLASS.
