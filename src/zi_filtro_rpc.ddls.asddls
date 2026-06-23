@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Path Expression'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_FILTRO_RPC
  as select from /dmo/travel
  association [0..*] to I_CurrencyText as _Currency on _Currency.Currency = $projection.Currency
{
  key travel_id     as TravelId,
      @Semantics.amount.currencyCode: 'Currency'
      total_price   as Price,
      currency_code as Currency,
      _Currency[Language = $session.system_language].CurrencyName
}
