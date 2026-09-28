using {demoex.db as database} from '../db/schema';
using {demoex.common as common } from '../db/common';

//Inserting mupltiple values
type createEmployeeIP : array of{
  Currency_code: String(3);
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


service CatalogService {

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

//Transactional data which is in Transactonal context
//entity PurchaseOrderSrv as projection on database.transaction.PurchaseOrders;

entity PurchaseItemSrv as projection on database.transaction.PurchaseItems;

/*action createEmployee(
        Currency_Code : String(3),
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
        Currency_Code : String(3)
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
        CURRENCY_CODE : String(5),
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
action createEmployee( input: createEmployeeIP
    ) returns String;


entity PurchaseOrderSrv as projection on database.transaction.PurchaseOrders{
      *
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

}



