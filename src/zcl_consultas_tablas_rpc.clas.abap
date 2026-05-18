CLASS zcl_consultas_tablas_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_consultas_tablas_rpc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " OPERACIONES CON TABLAS
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 1. OPERACIONES CON TABLAS (SQL) | ).


    "1. SELECT all fields - Como en ABAP o SQL
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT FROM /dmo/airport
    FIELDS *
    WHERE country = 'DE'
    INTO TABLE @DATA(lt_flights).

*  SELECT * FROM /dmo/airport
*  WHERE country = 'ES'
*  INTO TABLE @data(lt_flights).


    "2. Comprobación de que la operación ha sido exitosa
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 2. Comprobación del éxito de la operación | ).
    "La impresión de filas y operaciones deben ir dentro del IF
    "Por comodidad el resto de apartados no cuentan con dicha
    "comprobación.
    IF sy-subrc = 0.
      out->write( lt_flights ).
    ENDIF.


    "3. READ TABLE - Lectura de línea específica en tiempo de ejecución
    "Permite leer y recuperar datos de una tabla de manera eficiente
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 3. READ TABLE | ).
    IF sy-subrc = 0.
      READ TABLE lt_flights INTO DATA(ls_flights) INDEX 1.
      out->write( ls_flights ).
    ENDIF.

    "4. READ TABLE - Filtrado de campos
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 4. READ TABLE FILTRADO | ).
    IF sy-subrc = 0.
      READ TABLE lt_flights INTO DATA(ls_filtered_flights) INDEX 2
      TRANSPORTING airport_id city.
      out->write( ls_filtered_flights ).
    ENDIF.


    "5. READ TABLE - usando claves
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT * FROM /dmo/airport
    INTO TABLE @DATA(lt_flights_key).

    out->write( |  | ).
    out->write( | 5. READ TABLE CLAVES 1 | ).
    IF sy-subrc = 0.
      READ TABLE lt_flights_key INTO DATA(ls_flights_key) WITH KEY city = 'Berlin'.
      out->write( ls_flights_key ).
    ENDIF.

    out->write( |  | ).
    out->write( | 5. READ TABLE CLAVES 2 | ).
    "Forma moderna - Usar si es posible
    IF sy-subrc = 0.
      DATA(ls_flights_key_moderna) = lt_flights_key[ city = 'Berlin' ].
      out->write( ls_flights_key_moderna-airport_id ).
    ENDIF.

    "Forma moderna 2.0
*    IF sy-subrc = 0.
*    DATA(ls_flights_key_moderna) = lt_flights_key[ city = 'Berlin' ]-airport_id.
*    out->write( ls_flights_key_moderna ).
*    endif.



    "6. READ TABLE - PRIMARY KEY (sorted and hashed tables)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 6. READ TABLE - PRIMARY KEY (sorted tables)| ).
    DATA lt_flight_sort TYPE SORTED TABLE OF /dmo/airport WITH NON-UNIQUE KEY airport_id.

    SELECT * FROM /dmo/airport
    INTO TABLE @lt_flight_sort.

    READ TABLE lt_flight_sort INTO DATA(ls_flight) WITH TABLE KEY airport_id = 'LAS'.
    out->write( ls_flight ).

    "Forma moderna
*    out->write( |  | ).
*    out->write( | 6. READ TABLE - PRIMARY KEY Moderna (sorted tables)| ).
*    DATA(ls_flight) = lt_flight_sort[ key primary_key airport_id = 'LAS' ].
*    out->write( ls_flight ).


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "7. EJERCICIOS PRÁCTICOS
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "Para la BBDD /dmo/airport
    out->write( |  | ).
    out->write( | 7. EJERCICIOS PRÁCTICOS| ).


    "7.1. Extrae todos los registros del campo 'country = UK'.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 7.1 Registros UK| ).

    SELECT * FROM /dmo/airport
    WHERE country = 'UK'
    INTO TABLE @DATA(lt_ejer_flights).

    IF sy-subrc = 0.
      out->write( lt_ejer_flights ).
    ENDIF.


    "7.2. Extrae el nombre asociado a LGW del campo airport_id
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 7.2 Nombre asociado a LGW| ).

    SELECT * FROM /dmo/airport
    INTO TABLE @DATA(lt_ejer_flights2).

    IF sy-subrc = 0.
      DATA(ls_ejer_flights) = lt_ejer_flights2[ airport_id = 'LGW' ]-name.
      out->write( ls_ejer_flights ).
    ENDIF.


    "7.3. Extrae usando tablas sorted donde 'country = IT'
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 7.3 Tabla SORTED -> País = IT| ).

    DATA lt_ejer_sorted TYPE SORTED TABLE OF /dmo/airport WITH UNIQUE KEY airport_id.

    IF sy-subrc = 0.
      SELECT * FROM /dmo/airport
      WHERE country = 'IT'
      INTO TABLE @lt_ejer_sorted.
      out->write( lt_ejer_sorted ).
    ENDIF.


    "4.2. Comprobación de existencia de campo - TRANSPORTING
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    out->write( |  | ).
*    out->write( | 4.2. TRANSPORTING - Existencia de campo| ).
    DATA lt_flight_standard TYPE TABLE OF /dmo/flight.

    SELECT * FROM /dmo/flight
*    WHERE carrier_id = 'LH'
    INTO TABLE @lt_flight_standard.

*    IF sy-subrc = 0.
*        READ TABLE lt_flight_standard WITH KEY connection_id = '0403'
*        TRANSPORTING NO FIELDS.
*        out->write( |El vuelo existe en la BBDD| ).
*    ELSE.
*        out->write( |El vuelo NO existe en la BBDD| ).
*    ENDIF.


    "8. INDEX del puntero
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 8. INDEX del puntero| ).

    IF sy-subrc = 0.
      DATA(lv_index) = line_index( lt_flight_standard[ connection_id = '0403' ] ).
      out->write( lv_index ).
    ENDIF.


    "9. LOOP AT filtrado
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 9. LOOP AT filtrado| ).
    SELECT * FROM /dmo/flight
    INTO TABLE @DATA(lt_vuelos).

    LOOP AT lt_vuelos INTO DATA(ls_vuelos) WHERE connection_id = '0015'.
      out->write( ls_vuelos ).
    ENDLOOP.


    "10. ALIAS - SELECT de tabla interna
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    out->write( |  | ).
    out->write( | 10. ALIAS - SELECT de tabla interna| ).
    SELECT * FROM /dmo/flight
    WHERE carrier_id = 'LH'
    INTO TABLE @DATA(lt_vuelo).

    SELECT carrier_id , connection_id , flight_date
    FROM @lt_vuelo as vuelo
    INTO TABLE @DATA(lt_copia).

    out->write( |lt_vuelo:| ).
    out->write( lt_vuelo ).
    out->write( |lt_copia:| ).
    out->write( lt_copia ).









  ENDMETHOD.
ENDCLASS.
