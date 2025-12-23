page 70108 "CP Statement PDF API"
{
    PageType = API;
    Caption = 'Statement PDF';
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'statementPdf';
    EntitySetName = 'statementPdfs';

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
        PdfBase64 := GetStatementPdfAsBase64(Rec);
    end;

    local procedure GetStatementPdfAsBase64(Cust: Record Customer): Text
    var
        ReportSelections: Record "Report Selections";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        FilteredCust: Record Customer;
        ReportId: Integer;
        Parameters: Text;
        StartDate: Date;
        EndDate: Date;
    begin
        if Cust."No." = '' then
            exit('');

        FilteredCust.Reset();
        FilteredCust.SetRange("No.", Cust."No.");

        StartDate := CalcDate('<-CY>', WorkDate());
        EndDate := WorkDate();
        FilteredCust.SetRange("Date Filter", StartDate, EndDate);

        ReportSelections.Reset();
        ReportSelections.SetCurrentKey(Usage, Sequence);
        ReportSelections.SetRange(Usage, ReportSelections.Usage::"C.Statement");

        if not ReportSelections.FindFirst() then
            Error('No report is configured in Report Selections for Customer Statement (Usage %1).', ReportSelections.Usage::"C.Statement");

        ReportId := ReportSelections."Report ID";
        if ReportId = 0 then
            Error('Report Selections returned a blank Report ID for Usage %1.', ReportSelections.Usage::"C.Statement");

        // Construct Parameters to pass StartDate/EndDate to the report request page
        // Note: We cannot use Report.RunRequestPage in an API context to get defaults as it might trigger UI.
        // We construct a minimal XML parameter string that works for standard Statement reports (e.g. 1316).
        Parameters := '<?xml version="1.0" standalone="yes"?><ReportParameters name="Report" id="' + Format(ReportId) + '"><Options>';
        Parameters += '<Field name="StartDate">' + Format(StartDate, 0, 9) + '</Field>';
        Parameters += '<Field name="EndDate">' + Format(EndDate, 0, 9) + '</Field>';
        Parameters += '</Options><DataItems></DataItems></ReportParameters>';

        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(ReportId, Parameters, ReportFormat::Pdf, OutStr, FilteredCust);

        TempBlob.CreateInStream(InStr);
        exit(Base64Convert.ToBase64(InStr));
    end;
}
