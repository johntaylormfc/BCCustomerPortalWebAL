page 70104 "CP Open Cust. Ledger API"
{
    PageType = API;
    Caption = 'Open Customer Ledger Entries';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'openCustomerLedgerEntry';
    EntitySetName = 'openCustomerLedgerEntries';

    SourceTable = "Cust. Ledger Entry";
    SourceTableView = where(Open = const(true));

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

                field(customerNumber; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }

                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }

                field(documentNumber; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }

                field(externalDocumentNumber; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field(amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }

                field(remainingAmount; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                }

                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }

                field(open; Rec.Open)
                {
                    Caption = 'Open';
                }
            }
        }
    }
}
