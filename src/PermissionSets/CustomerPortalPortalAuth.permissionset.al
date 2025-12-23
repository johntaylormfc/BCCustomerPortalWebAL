permissionset 70103 "CP Portal Auth"
{
    Assignable = true;

    Permissions =
        tabledata Customer = R,
    tabledata "Cust. Ledger Entry" = R,
    tabledata "Sales Invoice Header" = R,
    tabledata "Report Selections" = R,
    page "CP Open Cust. Ledger API" = X,
    page "CP Customer Details API" = X,
    page "CP Sales Invoices API" = X,
    page "CP Sales Invoice PDF API" = X,
    page "CP Statement PDF API" = X,
        page "CP Customer Portal API" = X;
}
