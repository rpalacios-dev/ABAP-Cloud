@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Funciones de agregación'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_AGREGACION_RPC as select from /dmo/travel
{
    key travel_id as TravelID,
        agency_id as AgencyID,
        
        @Semantics.amount.currencyCode: 'Moneda'
        min( total_price ) as MinTotalPrecio,
        @Semantics.amount.currencyCode: 'Moneda'
        max( total_price ) as MaxTotalPrecio,
        @Semantics.amount.currencyCode: 'Moneda'
        sum( total_price ) as SumaTotalPrecio,
        
        count(distinct agency_id) as CountDistTotalPrice,
        count( * ) as CountTotalPrice,
        currency_code as Moneda
}

group by
travel_id,
agency_id,
currency_code;
