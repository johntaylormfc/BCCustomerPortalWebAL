page 70105 "CP Customer Details API"
{
    PageType = API;
    Caption = 'Customer Details API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalCustomer';
    EntitySetName = 'portalCustomers';

    SourceTable = Customer;
    ODataKeyFields = "No.";

    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(displayName; Rec.Name)
                {
                    Caption = 'Name';
                }

                field(phoneNumber; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }

                field(email; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }

                field(addressLine1; Rec.Address)
                {
                    Caption = 'Address';
                }

                field(addressLine2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }

                field(city; Rec.City)
                {
                    Caption = 'City';
                }

                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }

                field(country; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }

                field(balance; Rec."Balance (LCY)")
                {
                    Caption = 'Balance (LCY)';
                }

                field(balanceDue; Rec."Balance Due (LCY)")
                {
                    Caption = 'Balance Due (LCY)';
                }

                field(salesYTD; Rec."Sales (LCY)")
                {
                    Caption = 'Sales (LCY)';
                }

                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
            }
        }
    }
}
