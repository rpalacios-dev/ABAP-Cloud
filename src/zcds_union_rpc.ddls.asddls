@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Union de CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_UNION_RPC as select from /dmo/travel
{
    key travel_id as TravelID,
        cast( '' as abap.numc(4)) as BookingID
}

union select distinct from /dmo/booking
{
    key travel_id as TravelID,
        booking_id as BookingID
}
