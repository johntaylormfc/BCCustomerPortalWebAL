page 70102 "CP Customer Portal API"
{
    PageType = API;
    Caption = 'Customer Portal API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'customerPortal';
    EntitySetName = 'customerPortals';

    SourceTable = Customer;
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
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(portalPassword; Rec."Portal Password")
                {
                    Caption = 'Portal Password';
                }
            }
        }
    }
}
