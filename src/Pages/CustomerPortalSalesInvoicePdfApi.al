page 70107 "CP Sales Invoice PDF API"
{
    PageType = API;
    Caption = 'Sales Invoice PDF';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'postedSalesInvoicePdf';
    EntitySetName = 'postedSalesInvoicePdfs';

    SourceTable = "Sales Invoice Header";
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
        PdfBase64 := GetPostedSalesInvoicePdfAsBase64(Rec);
    end;

    local procedure GetPostedSalesInvoicePdfAsBase64(SalesInvHeader: Record "Sales Invoice Header"): Text
    var
        ReportSelections: Record "Report Selections";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        FilteredSalesInvHeader: Record "Sales Invoice Header";
        ReportId: Integer;
    begin
        if SalesInvHeader."No." = '' then
            exit('');

        // Many standard invoice reports require at least one filter, otherwise they
        // refuse to run to avoid accidentally printing all documents.
        FilteredSalesInvHeader.Reset();
        FilteredSalesInvHeader.SetRange("No.", SalesInvHeader."No.");

        ReportSelections.Reset();
        ReportSelections.SetCurrentKey(Usage, Sequence);
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Invoice");

        if not ReportSelections.FindFirst() then
            Error('No report is configured in Report Selections for Sales Invoices (Usage %1).', ReportSelections.Usage::"S.Invoice");

        ReportId := ReportSelections."Report ID";
        if ReportId = 0 then
            Error('Report Selections returned a blank Report ID for Usage %1.', ReportSelections.Usage::"S.Invoice");

        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportId, '', ReportFormat::Pdf, OutStr, FilteredSalesInvHeader);

        TempBlob.CreateInStream(InStr);
        exit(Base64Convert.ToBase64(InStr));
    end;
}
