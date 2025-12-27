page 70123 "CP Sales Return Orders API"
{
    PageType = API;
    Caption = 'Sales Return Orders API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesReturnOrder';
    EntitySetName = 'portalSalesReturnOrders';

    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const("Return Order"));
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
