using CatalogService as service from '../../srv/cat-service';
annotate service.PurchaseOrderSrv with @(
   UI.SelectionFields : [
    PO_ID,
    COMPANY_NAME,
    LSTEXT,
    OSTEXT,
    partnerCountryDesc,
    partnerCity

   ],

   UI.LineItem : [
    {
        $Type : 'UI.DataField',
        Value : PO_ID
    },
    {
        $Type : 'UI.DataField',
        Value : COMPANY_NAME
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
        Value : partnerCity
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'CatalogService.discountPrice',
        Label : 'Discount',
        Inline : true
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'CatalogService.EntityContainer/createPurchaseOrder',
        Label  : 'Create Order'
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'CatalogService.EntityContainer/updatePurchaseOrder',
        Label  : 'Update Order'
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'CatalogService.EntityContainer/deletePurchaseOrder',
        Label  : 'Delete Order'
    },

    /* {
        $Type : 'UI.DataFieldForAction',
        Action : 'CatalogService.EntityContainer/createEmployee',
        Label : 'Create Employee'
    }, */
    {
        $Type : 'UI.DataField',
        Value : LSTEXT,
        Criticality : LSC
    },
    {
        $Type : 'UI.DataField',
        Value : OSTEXT,
        Criticality : OSC
    },
    {
        $Type : 'UI.DataField',
        Value : partnerCountryDesc
    }
   ],

    UI.HeaderInfo : {
    TypeName : 'Purchase Order',
    TypeNamePlural : 'Purchase Orders',
    Title :{
        $Type : 'UI.DataField',
        Value : PO_ID
    },
    Description :{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME
    },
    ImageUrl : 'https://avatars.githubusercontent.com/u/76944583?s=280&v=4'
   } ,

    UI.HeaderFacets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Business Partner Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'General Information',
                    Target : '@UI.FieldGroup#BPInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Communication Information',
                    Target : '@UI.FieldGroup#BPCommInfo'
                }
            ]
            
        }
    ],

    
    UI.FieldGroup #BPInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : BP_ID
            },
            {
                $Type : 'UI.DataField',
                Value : COMPANY_NAME
            },
            {
                $Type : 'UI.DataField',
                Value : BP_ROLE
            }
        ]
    },

    UI.FieldGroup #BPCommInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : EMAIL
            },
            {
                $Type : 'UI.DataField',
                Value : MOBILE
            },
            {
                $Type : 'UI.DataField',
                Value : FAX
            }
        ]

    },

    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Other Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Price Information',
                    Target : '@UI.FieldGroup#PriceInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Address Information',
                    Target : '@UI.FieldGroup#AddrInfo'
                }
            ]
        },
        // { //chart
        //     $Type : 'UI.ReferenceFacet',
        //     Label : 'Status Overview',
        //     Target : '@UI.Chart'
        // },
         {
            $Type : 'UI.ReferenceFacet',
            ID    : 'ItemGrossChart',
            Label : 'Gross Amount per Item',
            Target: 'Items/@UI.Chart'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Pruchase Item Details',
            Target : 'Items/@UI.LineItem'
        }
    ], 

    UI.FieldGroup #AddrInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : COMPANY_NAME
            },
            {
                $Type : 'UI.DataField',
                Value : BUILDING
            },
            {
                $Type : 'UI.DataField',
                Value : STREET
            },
            {
                $Type : 'UI.DataField',
                Value : CITY
            },
            {
                $Type : 'UI.DataField',
                Value : POSTAL_CODE
            },
            {
                $Type : 'UI.DataField',
                Value : COMPANY_NAME
            }
        ]
    },

    UI.FieldGroup #PriceInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value :  TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value :  CURRENCY_code
            }
        ]

    },

);

annotate service.PurchaseItemSrv @(
    UI.SelectionFields : [
        PO_ITEMS_POS,
        PRDUCT_NODE_KEY
    ],

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRDUCT_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
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
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/createPurchaseItems',
            Label  : 'Create Items'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/updatePurchaseItems',
            Label  : 'Update Items'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.EntityContainer/deletePurchaseItems',
            Label  : 'Delete Items'
        }
    ],

    UI.HeaderInfo : {
        TypeName : 'Purchase Item',
        TypeNamePlural : 'Purchase Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS
        },
        Description : {
            $Type : 'UI.DataField',
            Value : PRDUCT.DESCRIPTION
        },
        ImageUrl : 'https://cdn-icons-png.flaticon.com/512/9710/9710858.png'
    },

    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Purchase Items Information',
                    Target : '@UI.FieldGroup#PurItemInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Details',
                    Target : '@UI.FieldGroup#ProdInfo'
                }
            ]
        }
    ],

    UI.FieldGroup #ProdInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.PRODUCT_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.DESCRIPTION
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.TYPE_CODE
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.WEIGHT_MEASURE
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.WEIGHT_UNIT
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.WIDTH
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.DEPTH
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.HEIGHT
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.PRICE
            },
            {
                $Type : 'UI.DataField',
                Value : PRDUCT.CURRENCY_code
            },
        ]
    },

    
    UI.FieldGroup #PurItemInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value :  TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            },
        ]

    },

);

annotate service.PurchaseOrderSrv with { 
    COMPANY_NAME @(
        Common : {
            ValueList : {
                Label : 'Comapny Name',
                CollectionPath : 'BusinessPartnerSrv',
                SearchSupported : true,
                Parameters :[{
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'BP_ID',
                    ValueListProperty : 'BP_ID'
                }, {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'COMPANY_NAME',
                    ValueListProperty : 'COMPANY_NAME'
                }]
                
            },
        }
    );

    PO_ID @(
        Common: {
            ValueList : {
                Label : 'Purchase Order ID',
                CollectionPath: 'PurchaseOrderSrv',
                SearchSupported: true,
                Parameters: [{
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'PO_ID',
                    ValueListProperty : 'PO_ID'
                }]
            },
        }
    );

    partnerCountryDesc @(
        Common : {
            ValueList : {
                Label : 'Country Name',
                CollectionPath : 'CountrySrv',
                SearchSupported : true,
                Parameters :[{
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'partnerCountry',
                    ValueListProperty : 'code'
                }, {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'partnerCountryDesc',
                    ValueListProperty : 'description'
                }]
                
            },
        }
    );

    LSTEXT @(
         Common : {
            ValueList : {
                Label : 'Life Cycle Status',
                CollectionPath : 'LifeCycleStatusSrv',
                SearchSupported : true,
                  Parameters :[{
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'code',
                    ValueListProperty : 'code'
                }, {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'LSTEXT',
                    ValueListProperty : 'description'
                }]
                
            },
        }

    );

    OSTEXT @(
         Common : {
            ValueList : {
                Label : 'Overall Status',
                CollectionPath : 'OverallStatusSrv',
                SearchSupported : true,
                Parameters :[{
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'code',
                    ValueListProperty : 'code'
                }, {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'OSTEXT',
                    ValueListProperty : 'description'
                }]
                
            },
        }

    );

    partnerCity @(
        Common : {
            ValueList : {
                Label: 'City',
                CollectionPath : 'CitySrv',
                SearchSupported : true,
                Parameters : [{
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'partnerCityDesc',
                    ValueListProperty : 'Description'
                }
                ]
            }
        }
    );

};

//Chart
// annotate service.PurchaseOrderSrv with  @(UI.Chart  : {
//     Title  : 'Status of the order',
//     Description : 'Overall lifecycle status of the order',
//     ChartType : #Column,
//     Dimensions : [
//         LSC,
//         OSC
//     ],
//     Measures  : [PO_ID],
//     DimensionAttributes  : [
//         {
//             $Type : 'UI.ChartDimensionAttributeType',
//             Dimension : LSC,
//             Role  : #Category
//         },
//         {
//             $Type : 'UI.ChartDimensionAttributeType',
//             Dimension : OSC,
//             Role  : #Series
//         }
//     ],
//     MeasureAttributes  :[{
//             $Type : 'UI.ChartMeasureAttributeType',
//             Measure : PO_ID,
//             Role  : #Axis1
//     }]

// });

annotate CatalogService.PurchaseItemSrv with {

    GROSS_AMOUNT @Semantics.amount.currencyCode: 'CURRENCY_code';

    NET_AMOUNT   @Semantics.amount.currencyCode: 'CURRENCY_code';

    TAX_AMOUNT   @Semantics.amount.currencyCode: 'CURRENCY_code';

};
 
annotate service.PurchaseItemSrv with @(

    Aggregation.ApplySupported : {

        Transformations       : [

            'aggregate',

            'groupby',

            'filter',

            'orderby',

            'top',

            'skip'

        ],

        GroupableProperties   : [

            PO_ITEM_POS,

            PRODUCT_NODE_KEY,

            CURRENCY_code

        ],

        AggregatableProperties: [

            { Property: GROSS_AMOUNT }

        ]

    },
 
    Analytics.AggregatedProperty #sumGross : {

        Name                 : 'sumGross',

        AggregationMethod    : 'sum',

        AggregatableProperty : GROSS_AMOUNT,

        ![@Common.Label]     : 'Gross Amount'

    },
 
    UI.Chart : {

        Title              : 'Gross Amount per Item',

        ChartType          : #Column,

        Dimensions         : [ PO_ITEM_POS ],

        DimensionAttributes: [

            { Dimension: PO_ITEM_POS, Role: #Category }

        ],

        DynamicMeasures    : [ '@Analytics.AggregatedProperty#sumGross' ],

        MeasureAttributes  : [

            { DynamicMeasure: '@Analytics.AggregatedProperty#sumGross', Role: #Axis1 }

        ]

    }

);