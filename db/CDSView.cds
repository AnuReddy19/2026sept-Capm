namespace demoex.cdsview;
using { demoex.db as database } from './schema';

define view ![POWorkList] as
    select from database.transaction.PurchaseOrders {
        key PO_ID as ![PurchaseOrderID],
        key Items.PO_ITEMS_POS as ![ItemsPosition],
        PARTNER.BP_ID as ![BusinessPartnerID],
        PARTNER.COMPANY_NAME as ![CompanyName],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        CURRENCY as ![Currency],
        LIFECYCLE_STATUS as ![LifeCycleStatus],
        OVERALL_STATUS as ![OverallStatus],
        Items.PRDUCT.PRODUCT_ID as ![ProductID],
        Items.PRDUCT.DESCRIPTION as ![Description],
        PARTNER.AD.CITY as ![City],
        PARTNER.AD.COUNTRY as ![Country]
    };

    define view ![ItemView] as select from database.transaction.PurchaseItems {
        PARENT.PARTNER.NODE_KEY as ![CustomerKey],
        PRDUCT.NODE_KEY as ![ProductKey],
        CURRENCY as ![Currency],
        GROSS_AMOUNT as ![GrossAmount],
        NET_AMOUNT as ![NetAmount],
        TAX_AMOUNT as ![TaxAmount],
        PARENT.OVERALL_STATUS as ![OverallStatus]
    };

    define view ProductView as select from database.master.Products
    mixin {
        PO_ORDER : Association[*] to ItemView on PO_ORDER.ProductKey = $projection.ProductKey
    } into {
        NODE_KEY as ![ProductKey],
        DESCRIPTION as ![Description],
        CATEGORY as ![ProductCategory],
        PRICE as ![Price],
        SUPPLIERS.BP_ID as ![SupplierID],
        SUPPLIERS.COMPANY_NAME as ![CompanyName],
        SUPPLIERS.AD.CITY as ![City],
        SUPPLIERS.AD.COUNTRY as ![Country],
        PO_ORDER as ![ToItems]
    };

    define view ![SupplierView] as select from database.master.BusinessPartners{
    key NODE_KEY as ![SupplierKey],
    BP_ROLE as ![SupplierRole],
    EMAIL as ![SupplierEmail],
    MOBILE as ![SupplierMobile],
    FAX as ![SupplierFax],
    WEB as ![SupplierWeb],
    BP_ID as ![SupplierID],
    COMPANY_NAME as ![SupplierCompany],
    AD.STREET as ![SupplierStreet],
    AD.CITY as ![SupplierCity],
    AD.POSTAL_CODE as ![SupplierPostalCode],
    AD.COUNTRY as ![SupplierCountry]
    };

    define view ![OrderView] as select from database.transaction.PurchaseOrders
    mixin {
        SUPPLIER : Association[*] to SupplierView on SUPPLIER.SupplierID = $projection.SupplierID
    } into {
        key NODE_KEY as ![OrderID],
        key PO_ID as ![ProductID],
        PARTNER.BP_ID as ![SupplierID],
        Items.GROSS_AMOUNT as ![GrossAmount],
        Items.TAX_AMOUNT as ![TaxAmount],
        Items.CURRENCY as![Currency]
    };
