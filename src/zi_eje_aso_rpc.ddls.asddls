@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio de asociación'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_EJE_ASO_RPC 
as select from /dmo/booking as Booking
association [1..1] to /dmo/carrier as _Carrier on _Carrier.carrier_id = $projection.CarrierId
{
    key Booking.booking_id as BookingId,
    Booking.carrier_id as CarrierId,
    Booking.flight_date as FlightDate,
    concat_with_space(_Carrier.carrier_id, _Carrier.name, 2) as CarrierInfo
}
