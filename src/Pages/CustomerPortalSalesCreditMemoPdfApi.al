page 70113 "CP Sales Cr.Memo PDF API"
{
    PageType = API;
    Caption = 'Sales Credit Memo PDF';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'portalSalesCreditMemoPdf';
    EntitySetName = 'portalSalesCreditMemoPdfs';

    SourceTable = "Sales Cr.Memo Header";
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
        PdfBase64 := GetCreditMemoPdfAsBase64(Rec);
    end;

    local procedure GetCreditMemoPdfAsBase64(CrMemoHeader: Record "Sales Cr.Memo Header"): Text
    var
        ReportSelections: Record "Report Selections";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        FilteredCrMemoHeader: Record "Sales Cr.Memo Header";
        ReportId: Integer;
    begin
        if CrMemoHeader."No." = '' then
            exit('');

        FilteredCrMemoHeader.Reset();
        FilteredCrMemoHeader.SetRange("No.", CrMemoHeader."No.");

        ReportSelections.Reset();
        ReportSelections.SetCurrentKey(Usage, Sequence);
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"S.Cr.Memo");

        if not ReportSelections.FindFirst() then
            Error('No report is configured in Report Selections for Sales Credit Memos (Usage %1).', ReportSelections.Usage::"S.Cr.Memo");

        ReportId := ReportSelections."Report ID";
        if ReportId = 0 then
            Error('Report Selections returned a blank Report ID for Usage %1.', ReportSelections.Usage::"S.Cr.Memo");

        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportId, '', ReportFormat::Pdf, OutStr, FilteredCrMemoHeader);

        TempBlob.CreateInStream(InStr);
        exit(Base64Convert.ToBase64(InStr));
    end;
}
