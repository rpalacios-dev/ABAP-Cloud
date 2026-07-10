CLASS zcx_rpc_no_agency DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .


    CONSTANTS:
      BEGIN OF zcx_mms_no_agency,
        msgid TYPE symsgid      VALUE 'ZC_MENSAJE_MMS',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'AGENCY_ID', "el atributo agency_id de la excepción rellenará el marcador &1 del mensaje.
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF zcx_mms_no_agency .

    DATA agency_id TYPE /dmo/agency_id READ-ONLY. "ajusta el tipo al de tu campo AGENCY_ID

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        agency_id TYPE /dmo/agency_id OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_rpc_no_agency IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->agency_id = agency_id.

    IF textid IS INITIAL.
*       if_t100_message~t100key = if_t100_message=>default_textid.
      if_t100_message~t100key = zcx_mms_no_agency.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
