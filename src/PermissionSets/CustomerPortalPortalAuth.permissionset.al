permissionset 70103 "CP Portal Auth"
{
    Assignable = true;

    Permissions =
        tabledata Customer = R,
    tabledata "Cust. Ledger Entry" = R,
    tabledata "Sales Invoice Header" = R,
    tabledata "Sales Cr.Memo Header" = R,
    tabledata "Report Selections" = R,
    page "CP Open Cust. Ledger API" = X,
    page "CP Customer Details API" = X,
    page "CP Sales Invoices API" = X,
    page "CP Sales Invoice PDF API" = X,
    page "CP Sales Credit Memos API" = X,
    page "CP Sales Cr.Memo PDF API" = X,
    page "CP Statement PDF API" = X,
    page "CP Sales Orders API" = X,
    page "CP Sales Order PDF API" = X,
    page "CP Company Info API" = X,
    page "CP Sales Shipments API" = X,
    page "CP Sales Shipment Lines API" = X,
    page "CP Sales Return Orders API" = X,
    query "CP Top Items API" = X,
        page "CP Customer Portal API" = X;
}
