page 70112 "CP Sales Credit Memos API"
{
    PageType = API;
    Caption = 'Sales Credit Memos API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesCreditMemo';
    EntitySetName = 'portalSalesCreditMemos';

    SourceTable = "Sales Cr.Memo Header";
    ODataKeyFields = SystemId;

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
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }

                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                }

                field(customerNumber; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }

                field(customerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }

                field(externalDocumentNumber; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }

                field(totalAmountIncludingTax; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }

                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }

                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }
            }
        }
    }
}
