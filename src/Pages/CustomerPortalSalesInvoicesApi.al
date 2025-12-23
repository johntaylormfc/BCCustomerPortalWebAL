page 70106 "CP Sales Invoices API"
{
    PageType = API;
    Caption = 'Sales Invoices API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesInvoice';
    EntitySetName = 'portalSalesInvoices';

    SourceTable = "Sales Invoice Header";
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

                field(totalAmountIncludingTax; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }

                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }

                field(remainingAmount; RemainingAmount)
                {
                    Caption = 'Remaining Amount';
                }

                field(isPaid; IsPaid)
                {
                    Caption = 'Is Paid';
                }
            }
        }
    }

    var
        RemainingAmount: Decimal;
        IsPaid: Boolean;

    trigger OnAfterGetRecord()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        RemainingAmount := 0;
        IsPaid := true;

        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", Rec."No.");
        if CustLedgerEntry.FindFirst() then begin
            CustLedgerEntry.CalcFields("Remaining Amount");
            RemainingAmount := CustLedgerEntry."Remaining Amount";
            IsPaid := not CustLedgerEntry.Open;
        end;
    end;
}
