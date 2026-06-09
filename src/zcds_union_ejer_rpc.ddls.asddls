@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio de unión de tablas'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_Union_Ejer_RPC as select from zdb_emplea_rpc
{
    key correo as Correo,
    cast( nombre as zde_nombre_rpc) as Nombre
}

union select from ztb_alumnos{
    key cast( '' as abap.char(20)) as Correo,
        nombre as Nombre
}
