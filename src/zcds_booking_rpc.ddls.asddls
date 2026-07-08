@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio - CDS de reservas con campos calculados'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_BOOKING_RPC
  as select from /dmo/booking
{
  key travel_id     as TravelId,
  key booking_id    as BookingId,
  key customer_id   as CustomerId,
      booking_date  as BookingDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price  as FlightPrice,
      currency_code as CurrencyCode,

      cast(
              cast(flight_price as abap.dec(15,2)) *
              cast('1.1' as abap.dec(15,2))
              as abap.dec(15,2)
            )       as Recargo,

      case
      when flight_price < 500 then 'Economy'
      when flight_price >= 500 and flight_price <= 1500 then 'Business'
      else 'First Class'
      end           as CategoriaReserva,

      case
      when booking_date > '20200101' then 'Reciente'
      else 'Histórica'
      end           as EstadoAntiguedad
}
