page 70122 "CP Sales Shipments API"
{
    PageType = API;
    Caption = 'Sales Shipments API';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesShipment';
    EntitySetName = 'portalSalesShipments';
    SourceTable = "Sales Shipment Header";
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    ODataKeyFields = "No.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(customerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Customer No.';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                part(lines; "CP Sales Shipment Lines API")
                {
                    Caption = 'Lines';
                    SubPageLink = "Document No." = Field("No.");
                }
            }
        }
    }

    [ServiceEnabled]
    procedure CreateReturnOrder(returnLinesJSON: Text): Text
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShptLine: Record "Sales Shipment Line";
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        LineNoToken: JsonToken;
        QtyToken: JsonToken;
        LineNo: Integer;
        QtyToReturn: Decimal;
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader.Validate("Sell-to Customer No.", Rec."Sell-to Customer No.");
        SalesHeader.Insert(true);

        if not JsonArray.ReadFrom(returnLinesJSON) then
            Error('Invalid JSON');

        foreach JsonToken in JsonArray do begin
            JsonObject := JsonToken.AsObject();
            if JsonObject.Get('lineNo', LineNoToken) and JsonObject.Get('quantity', QtyToken) then begin
                LineNo := LineNoToken.AsValue().AsInteger();
                QtyToReturn := QtyToken.AsValue().AsDecimal();

                if (QtyToReturn > 0) and SalesShptLine.Get(Rec."No.", LineNo) then begin
                    SalesLine.Init();
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := GetNextLineNo(SalesHeader."No.");
                    SalesLine.Validate(Type, SalesShptLine.Type);
                    SalesLine.Validate("No.", SalesShptLine."No.");
                    SalesLine.Validate(Quantity, QtyToReturn);
                    SalesLine.Insert(true);
                end;
            end;
        end;

        exit(SalesHeader."No.");
    end;

    local procedure GetNextLineNo(DocNo: Code[20]): Integer
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SetRange("Document No.", DocNo);
        if SalesLine.FindLast() then
            exit(SalesLine."Line No." + 10000);
        exit(10000);
    end;
}
