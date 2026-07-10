CLASS zcl_prueba_agency_rpc DEFINITION
    PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_mms_agency_model.  " Class Under Test

    CONSTANTS:
      cv_agency_existente   TYPE /dmo/agency_id VALUE '070010',
      cv_agency_inexistente TYPE /dmo/agency_id VALUE '000000'.

    METHODS:
      agencia_encontrada
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      agencia_no_encontrada
        IMPORTING out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.


CLASS zcl_prueba_agency_rpc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    cut = NEW zcl_mms_agency_model( ).

    agencia_encontrada( out ).
    out->write( '' ).
    agencia_no_encontrada( out ).
  ENDMETHOD.


  METHOD agencia_encontrada.

    out->write( |--- Test: agencia existente ({ cv_agency_existente }) ---| ).

    TRY.
        DATA(ls_agency) = cut->get_agency( i_agency_id = cv_agency_existente ).

        IF ls_agency IS NOT INITIAL.
          out->write( |OK: se encontró la agencia { cv_agency_existente }| ).
        ELSE.
          out->write( |FALLO: la estructura devuelta está vacía| ).
        ENDIF.

      CATCH zcx_mms_no_agency INTO DATA(lx_agency).
        out->write( |FALLO: se lanzó excepción para una agencia que sí existe: { lx_agency->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.


  METHOD agencia_no_encontrada.

    out->write( |--- Test: agencia inexistente ({ cv_agency_inexistente }) ---| ).

    TRY.
        cut->get_agency( i_agency_id = cv_agency_inexistente ).
        out->write( |FALLO: se esperaba la excepción ZCX_####_NO_AGENCY y no se lanzó| ).

      CATCH zcx_mms_no_agency INTO DATA(lx_agency).

        IF lx_agency->agency_id = cv_agency_inexistente.
          out->write( |OK: la excepción trae el ID de agencia correcto ({ lx_agency->agency_id })| ).
        ELSE.
          out->write( |FALLO: el ID de agencia en la excepción no coincide| ).
        ENDIF.

        DATA(lv_texto_esperado) = |Agencia { cv_agency_inexistente } no existe.|.
        IF lx_agency->get_text( ) = lv_texto_esperado.
          out->write( |OK: el texto del mensaje es correcto: "{ lx_agency->get_text( ) }"| ).
        ELSE.
          out->write( |FALLO: texto obtenido "{ lx_agency->get_text( ) }" distinto del esperado "{ lv_texto_esperado }"| ).
        ENDIF.

    ENDTRY.

  ENDMETHOD.

ENDCLASS.

