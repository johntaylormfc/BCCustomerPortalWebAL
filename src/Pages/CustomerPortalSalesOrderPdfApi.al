page 70111 "CP Sales Order PDF API"
{
    PageType = API;
    Caption = 'Sales Order PDF';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesOrderPdf';
    EntitySetName = 'portalSalesOrderPdfs';

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
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }

                field(pdfBase64; PdfBase64)
                {
                    Caption = 'PDF (Base64)';
                }
            }
        }
    }

    var
        PdfBase64: Text;

    trigger OnAfterGetRecord()
    begin
        PdfBase64 := GetSalesOrderPdfAsBase64(Rec);
    end;

    local procedure GetSalesOrderPdfAsBase64(SalesHeader: Record "Sales Header"): Text
    var
        ReportSelections: Record "Report Selections";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        FilteredSalesHeader: Record "Sales Header";
        ReportId: Integer;
    begin
        if SalesHeader."No." = '' then
            exit('');

        FilteredSalesHeader.Reset();
        FilteredSalesHeader.SetRange("Document Type", SalesHeader."Document Type");
        FilteredSalesHeader.SetRange("No.", SalesHeader."No.");

        ReportSelections.Reset();
        ReportSelections.SetCurrentKey(Usage, Sequence);
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Order");

        if not ReportSelections.FindFirst() then
            Error('No report is configured in Report Selections for Sales Orders (Usage %1).', ReportSelections.Usage::"S.Order");

        ReportId := ReportSelections."Report ID";
        if ReportId = 0 then
            Error('Report Selections returned a blank Report ID for Usage %1.', ReportSelections.Usage::"S.Order");

        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportId, '', ReportFormat::Pdf, OutStr, FilteredSalesHeader);

        TempBlob.CreateInStream(InStr);
        exit(Base64Convert.ToBase64(InStr));
    end;
}
