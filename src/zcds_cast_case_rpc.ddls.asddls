@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Usos de CAST y CASE'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_CAST_CASE_RPC as select from /dmo/customer
{
    key customer_id as ClientID,
 
 case country_code
 //Juntar distintos elementos en uno único//
    when 'US' then concat( 'United Stated - ', concat_with_space( last_name, first_name, 2 ) )
    when 'DE' then concat('Germany - ', last_name )
    when 'ES' then concat('Spain - ', last_name )
    else 'Another Country Code'
 end as Case1,
    
    case
        when country_code = 'US' or country_code = 'ES' then case title
                                                        when 'Mr.' then 'US/ES - Mr.'
                                                        when 'Mrs.' then 'US/ES - Mrs.'
                                                        else 'US/ES - Different Title'
                                                        end
        when title = 'Mr.' then last_name
        //Funcion de sistema para comprobar el día//
        when cast( '20300101' as abap.dats ) < dats_add_days( $session.system_date, - 30, 'NULL') then 'lowe'
            else 'No condition applied'
        end as Case2   
}
