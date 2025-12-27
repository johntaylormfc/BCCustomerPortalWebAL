page 70110 "CP Company Info API"
{
    PageType = API;
    Caption = 'Company Info API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'companyInfo';
    EntitySetName = 'companyInfos';

    SourceTable = "Company Information";
    ODataKeyFields = "SystemId";

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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
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
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(email; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                }
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(pictureBase64; PictureBase64)
                {
                    Caption = 'Picture Base64';
                }
            }
        }
    }

    var
        PictureBase64: Text;

    trigger OnAfterGetRecord()
    var
        InStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Rec.CalcFields(Picture);
        if Rec.Picture.HasValue then begin
            Rec.Picture.CreateInStream(InStream);
            PictureBase64 := Base64Convert.ToBase64(InStream);
        end else
            PictureBase64 := '';
    end;
}
