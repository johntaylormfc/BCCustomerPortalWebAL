page 70109 "CP Sales Orders API"
{
    PageType = API;
    Caption = 'Sales Orders API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesOrder';
    EntitySetName = 'portalSalesOrders';

    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order));
    ODataKeyFields = "No.";

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(customerNumber; Rec."Sell-to Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(customerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date';
                }
                field(amountIncludingTax; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
            }
        }
    }
}
