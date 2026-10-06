using CatalogService as service from '../../srv/cat-service';
annotate service.PurchaseOrderSrv with @(
   UI.SelectionFields : [
    PO_ID,
    PARTNER.COMPANY_NAME,
    GROSS_AMOUNT,
    PARTNER.AD.COUNTRY
   ],

   UI.LineItem : [
    {
        $Type : 'UI.DataField',
        Value : PO_ID
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER.COMPANY_NAME
    },
    {
        $Type : 'UI.DataField',
        Value : GROSS_AMOUNT
    },
    {
        $Type : 'UI.DataField',
        Value : CURRENCY_code
    },
    {
        $Type : 'UI.DataField',
        Value : NET_AMOUNT
    },
    {
        $Type : 'UI.DataField',
        Value : TAX_AMOUNT
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER.AD.COUNTRY
    }
   ]
)

