CLASS zcls_cds_rpc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcls_cds_rpc IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    SELECT FROM zi_cds_rpc AS Booking
*    FIELDS Booking~BookingId,
*    Booking~TravelId,
*    \_Travel-AgencyId,
*    \_Travel\_Agency-name AS AgencyName,
*    \_Travel\_Customer-customer_id AS CustomerId,
*    concat_with_space( \_Travel\_Customer-first_name, \_Travel\_Customer-last_name, 2 ) AS CustomerName
*    WHERE Booking~CarrierId = 'AA'
*    INTO TABLE @DATA(lt_resultado)
*    UP TO 5 ROWS.


    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    "EJERCICIO DE CLASE
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    SELECT FROM zi_cds_rpc AS Booking
    FIELDS Booking~BookingId,
    Booking~TravelId,
    Booking~CarrierId,
    \_Travel-AgencyId,
    \_Travel\_Agency-name AS AgencyName,
    \_Travel\_Customer-customer_id AS CustomerId,
    concat_with_space( \_Travel\_Customer-title, concat_with_space( \_Travel\_Customer-first_name, \_Travel\_Customer-last_name, 1 ), 1 ) AS CustomerName
    WHERE \_Travel\_Customer-last_name LIKE 'M%'
*    AND \_Travel\_Customer-city = \_Travel\_Agency-city
    ORDER BY \_Travel\_Customer-last_name ASCENDING, TravelId ASCENDING
    INTO TABLE @DATA(lt_resultado)
    UP TO 20 ROWS.

    IF sy-subrc = 0.
      out->write( lt_resultado ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
