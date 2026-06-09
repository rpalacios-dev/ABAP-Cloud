@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Joins'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_JOIN_RPC 
as select from /dmo/travel as viaje
inner join /dmo/booking as reserva on reserva.travel_id = viaje.travel_id
{
    key viaje.travel_id as TravelID,
    key reserva.booking_id as BookingID,
        viaje.agency_id as AgencyID,
        viaje.begin_date as BeginDate,
        viaje.end_date as EndDate,
        reserva.booking_date as BookingDate,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        viaje.total_price as TotalPrice,
        @Semantics.amount.currencyCode: 'CurrencyCode'
        reserva.flight_price as BookingPrice,
        reserva.currency_code as CurrencyCode
}
