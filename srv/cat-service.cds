using {demoex.db as database} from '../db/schema';
using {demoex.common as common } from '../db/common';

//Inserting mupltiple values
type createEmployeeIP : array of{
    CURRENCY_code: String(3);
    ID: UUID;
    accountNumber: common.String32;
    bankId: String(16);
    bankName: common.String64;
    email: common.Email;
    gender: common.Gender;
    language: String(2);
    loginName: String(16);
    nameFirst: common.String64;
    nameInitials: common.String64;
    nameLast: common.String64;
    nameMiddle: common.String64;
    phoneNumber: common.PhoneNumber;
    salaryAmount: common.AmountT
}


service CatalogService @(require: 'autenticated-user') {

//Master data which is in Master Context
/*@Capabilities : { 
        InsertRestrictions.Insertable : true,
        UpdateRestrictions.Updatable : true,
        DeleteRestrictions.Deletable : true,
        ReadRestrictions.Readable : false

 }*/
//entity EmployeeSrv as projection on database.master.Employees;

//entity ProductSrv as projection on database.master.Products;

entity BusinessPartnerSrv as projection on database.master.BusinessPartners;

entity AddressSrv as projection on database.master.Addresses;

entity CountrySrv as projection on database.Countries;

entity LifeCycleStatusSrv as projection on database.LifeCycleStatus;

entity OverallStatusSrv as projection on database.OverallStatus;

entity CitySrv as projection on database. Cities;

//Transactional data which is in Transactonal context
//entity PurchaseOrderSrv as projection on database.transaction.PurchaseOrders;

entity PurchaseItemSrv as projection on database.transaction.PurchaseItems;

/*action createEmployee(
        CURRENCY_code : String(3),
        ID : UUID,
        nameFirst : common.String64,
        nameLast : common.String64,
        nameInitials : common.String64,
        nameMiddle : common.String64,
        gender : common.Gender,
        language : String(2),
        loginName : String(16),
        phoneNumber : common.PhoneNumber,
        email : common.Email,
        salaryAmount : common.AmountT,
        accountNumber : common.String32,
        bankId : String(16),
        bankName : common.String64 ) returns array of EmployeeSrv;*/


action createAdress(
        NODE_KEY : common.Guid,
        ADDRESS_TYPE : common.String32,
        VAL_START : Date,
        VAL_END: Date,
        LATITUDE : Decimal,
        LONGITUDE : Decimal,
        STREET : common.String255,
        POSTAL_CODE : String(12),
        CITY : common.String255,
        COUNTRY : common.String255,
        BUILDING : common.String255 ) returns array of AddressSrv;

action updateEmployee(
        ID : UUID,
        nameInitials : common.String64,
        CURRENCY_code : String(3)
) returns String;

action updateAddress(
        NODE_KEY : UUID,
        CITY : common.String255,
        ADDRESS_TYPE : common.String32
) returns String;

action createProducts(
        NODE_KEY : UUID,
        PRODUCT_ID : common.String32,
        TYPE_CODE : String(2),
        CATEGORY : common.String32,
        DESCRIPTION : common.String255,
        TAX_TARIF_CODE : Integer,
        MEASURE_UNIT : String(2),
        WEIGHT_MEASURE : Decimal(5,2),
        WEIGHT_UNIT : String(2),
        PRICE : Decimal(15, 2),
        CURRENCY_code : String(5),
        WIDTH : Decimal(5, 2),
        DEPTH : Decimal(5, 2),
        HEIGHT : Decimal(5, 2),
        DIM_UNIT : String(2) ) returns array of ProductSrv;


action updateProducts(
        NODE_KEY : UUID,
        DESCRIPTION : common.String255,
        PRODUCT_ID : common.String32
) returns String;

action deleteEmployee(
        ID : UUID
) returns String;

//Custom Function Declaration
function getHighestSalariedEmployees() returns array of EmployeeSrv;

function getHeighestPricedProduct() returns array of ProductSrv;

entity ProductSrv as projection on database.master.Products{
      *
    } actions {
      action increasePrice() returns array of ProductSrv;
      function getTopProducts() returns array of ProductSrv;
    }

//for insterting multiple values
action createEmployee( CURRENCY_code : String(3) @(title: '{i18n>Currency Code}'),
        ID : UUID  @(title: '{i18n>ID}'),
        nameFirst : common.String64 @(title: '{i18n>First Name}'),
        nameLast : common.String64 @(title: '{i18n>Last Name}'),
        nameInitials : common.String64 @(title: '{i18n>Initial}'),
        nameMiddle : common.String64 @(title: '{i18n>Middle Name}'),
        gender : common.Gender @(title: '{i18n>Gender}'),
        language : String(2) @(title: '{i18n>Language}'),
        loginName : String(16) @(title: '{i18n>Login Name}'),
        phoneNumber : common.PhoneNumber @(title: '{i18n>Phone Number}'),
        email : common.Email @(title: '{i18n>Email}'),
        salaryAmount : common.AmountT @(title: '{i18n>Salary Amount}'),
        accountNumber : common.String32 @(title: '{i18n> Account Nmuber}'),
        bankId : String(16) @(title: '{i18n> Bank ID}'),
        bankName : common.String64 @(title: '{i18n>Bank Name}') ) returns String;

@Capabilities : { 
        DeleteRestrictions : {
            $Type : 'Capabilities.DeleteRestrictionsType',
            Deletable : false
        },
        UpdateRestrictions : {
            $Type : 'Capabilities.UpdateRestrictionsType',
            Updatable : false
        },
        InsertRestrictions : {
            $Type : 'Capabilities.InsertRestrictionsType',
            Insertable : false
        },
        
 }

entity PurchaseOrderSrv as select from database.transaction.PurchaseOrders as po
        inner join database.master.BusinessPartners as bp
                on bp.NODE_KEY = po.PARTNER.NODE_KEY
        inner join database.master.Addresses as addr
                on addr.NODE_KEY = bp.AD.NODE_KEY
        inner join database.Countries as country
                on addr.COUNTRY = country.code 
        inner join database.BPRoleFltr as role
                on bp.BP_ROLE = role.code
        inner join database.LifeCycleStatus as LST
                on po.LIFECYCLE_STATUS = LST.code
        inner join database.OverallStatus as OST
                on po.OVERALL_STATUS = OST.code
        inner join database.Cities as cs
                on addr.CITY=cs.Description
{

        key po.NODE_KEY,
        po.PO_ID,
        po.GROSS_AMOUNT,
        po.NET_AMOUNT,
        po.TAX_AMOUNT,
        po.CURRENCY,
        bp.COMPANY_NAME,
        bp.BP_ID,
        role.description as BP_ROLE,
        bp.MOBILE,
        bp.FAX,
        bp.EMAIL,
        bp.WEB,
        addr.ADDRESS_TYPE,
        addr.BUILDING,
        addr.CITY,
        addr.COUNTRY,
        addr.LATITUDE,
        addr.LONGITUDE,
        addr.STREET,
        addr.POSTAL_CODE,
        po.Items,
        bp.COMPANY_NAME  as partnerName,
        bp.BP_ROLE       as partnerId,
        addr.COUNTRY     as partnerCountry @(title : '{i18n>COUNTRY_Code}'),
        country.description as partnerCountryDesc @(title : '{i18n>COUNTRY}'),
        LST.description as LSTEXT  @(title : '{i18n>LIFECYCLE_STATUS}'),
        OST.description as OSTEXT @(title: '{i18n>OVERALL_STATUS}'),
        addr.CITY as partnerCity,
        cs.Description as partnerCityDesc @(title: '{i18n>CITY}'),

      case po.LIFECYCLE_STATUS
       when 'N' then 2
       when 'S' then 3
       when 'C' then 3
       else 1
       end as LSC : Integer,  
       case po.OVERALL_STATUS
       when 'R' then 1
       when 'P' then 3
       when 'D' then 3
       else 2
       end as OSC : Integer,  
//       case po.LIFECYCLE_STATUS
//        when 'N' then 'Not Started'
//        when 'S' then 'Started'
//        when 'C' then 'Completed'
//        else 'Cancelled'
//        end as LSTEXT : String(20) @(title: '{i18n>LIFECYCLE_STATUS}'),
//        case po.OVERALL_STATUS
//         when 'R' then 'Returned'
//         when 'P' then 'Processed'
//         when 'D' then 'Delivered'
//         else 'New'
//         end as OSTEXT : String(20) @(title: '{i18n>OVERALL_STATUS}')
    } actions{
      //Declare instance bounded action
      action discountPrice() returns array of PurchaseOrderSrv;
 
      //Declare instance bounded function
      function largestOrder() returns array of PurchaseOrderSrv;
    };

entity EmployeeSrv as projection on database.master.Employees{
      *
    } actions{
      //Declare instance bounded action
      action increasedSalary() returns array of EmployeeSrv;
 
      //Declare instance bounded function
      function highestPaid() returns array of EmployeeSrv;
    };


function getUtilities() returns String;


action createPurchaseOrder(
        NODE_KEY : common.Guid @(title: '{i18n>NODE_KEY}'),
        PO_ID : common.Guid @(title: '{i18n>PO_ID}'),
        PARTNER_NODE_KEY : common.Guid @(title: '{i18n>PARTNER_GUID}'),
        GROSS_AMOUNT : common.AmountT @(title: '{i18n>GROSS_AMOUNT}'),
        NET_AMOUNT : common.AmountT @(title: '{i18n>NET_AMOUNT}'),
        TAX_AMOUNT : common.AmountT @(title: '{i18n>TAX_AMOUNT}'),
        CURRENCY_code : String(3) @(title: '{i18n>Currency Code}'),
        LIFECYCLE_STATUS : String(1) @(title: '{i18n>LIFECYCLE_STATUS}'),
        OVERALL_STATUS : String(1) @(title: '{i18n>OVERALL_STATUS}') )returns String;

action updatePurchaseOrder(
        NODE_KEY : common.Guid @(title: '{i18n>NODE_KEY}'),
        PO_ID : common.Guid @(title: '{i18n>PO_ID}'),
        PARTNER_NODE_KEY : common.Guid @(title: '{i18n>PARTNER_GUID}'),
        GROSS_AMOUNT : common.AmountT @(title: '{i18n>GROSS_AMOUNT}'),
        NET_AMOUNT : common.AmountT @(title: '{i18n>NET_AMOUNT}'),
        TAX_AMOUNT : common.AmountT @(title: '{i18n>TAX_AMOUNT}'),
        CURRENCY_code : String(3) @(title: '{i18n>Currency Code}'),
        LIFECYCLE_STATUS : String(1) @(title: '{i18n>LIFECYCLE_STATUS}'),
        OVERALL_STATUS : String(1) @(title: '{i18n>OVERALL_STATUS}') )returns String;

action deletePurchaseOrder(
        NODE_KEY : common.Guid @(title: '{i18n>NODE_KEY}') )returns String;


action createPurchaseItems(
        NODE_KEY : common.Guid @(title: '{i18n>NODE_KEY}'),
        PARENT_NODE_KEY : common.Guid @(title: '{i18n>PARENT_KEY}'),
        PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}'),
        PRDUCT_NODE_KEY : common.Guid @(title: '{i18n>PRODUCT_GUID}'),
        GROSS_AMOUNT : common.AmountT @(title: '{i18n>GROSS_AMOUNT}'),
        NET_AMOUNT : common.AmountT @(title: '{i18n>NET_AMOUNT}'),
        TAX_AMOUNT : common.AmountT @(title: '{i18n>TAX_AMOUNT}'),
        CURRENCY_code : String(3) @(title: '{i18n>Currency Code}') )returns String;

action updatePurchaseItems(
        NODE_KEY : common.Guid @(title: '{i18n>NODE_KEY}'),
        PARENT_NODE_KEY : common.Guid @(title: '{i18n>PARENT_KEY}'),
        PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}'),
        PRDUCT_NODE_KEY : common.Guid @(title: '{i18n>PRODUCT_GUID}'),
        GROSS_AMOUNT : common.AmountT @(title: '{i18n>GROSS_AMOUNT}'),
        NET_AMOUNT : common.AmountT @(title: '{i18n>NET_AMOUNT}'),
        TAX_AMOUNT : common.AmountT @(title: '{i18n>TAX_AMOUNT}'),
        CURRENCY_code : String(3) @(title: '{i18n>Currency Code}') )returns String;

action deletePurchaseItems(
        NODE_KEY : common.Guid @(title: '{i18n>NODE_KEY}') )returns String;



}



