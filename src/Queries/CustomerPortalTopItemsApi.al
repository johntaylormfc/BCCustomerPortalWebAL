query 70120 "CP Top Items API"
{
    QueryType = API;
    APIPublisher = 'cp';
    APIGroup = 'portal';
    APIVersion = 'v1.0';
    EntityName = 'topItem';
    EntitySetName = 'topItems';
    OrderBy = descending(lineAmount);

    elements
    {
        dataitem(SalesInvoiceLine; "Sales Invoice Line")
        {
            DataItemTableFilter = Type = const(Item);
            column(itemNo; "No.")
            {
            }
            column(description; Description)
            {
            }
            column(lineAmount; "Line Amount")
            {
                Method = Sum;
            }
            column(quantity; Quantity)
            {
                Method = Sum;
            }

            dataitem(SalesInvoiceHeader; "Sales Invoice Header")
            {
                DataItemLink = "No." = SalesInvoiceLine."Document No.";
                SqlJoinType = InnerJoin;
                column(customerNo; "Sell-to Customer No.")
                {
                }
                filter(postingDate; "Posting Date")
                {
                }
            }
        }
    }
}
