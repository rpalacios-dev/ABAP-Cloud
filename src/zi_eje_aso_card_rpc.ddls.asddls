@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio de asociaciones y cardinalidades'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_EJE_ASO_CARD_RPC
  as select from /dmo/connection as Connection
  association [1..1] to /dmo/carrier as _Carrier          on  _Carrier.carrier_id = $projection.CarrierId
  association [1..1] to /dmo/airport as _DepartureAirport on  _DepartureAirport.airport_id = $projection.AirportFromId
  association [0..*] to /dmo/flight  as _Flight           on  _Flight.connection_id = $projection.ConnectionId
                                                          and _Flight.carrier_id    = $projection.CarrierId
{
  key carrier_id      as CarrierId,
  key connection_id   as ConnectionId,
      airport_from_id as AirportFromId,
      airport_to_id   as AirportToId,
      departure_time  as DepartureTime,
      
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      distance_unit   as DistanceUnit,
      _Carrier,
      _DepartureAirport,
      _Flight
}
