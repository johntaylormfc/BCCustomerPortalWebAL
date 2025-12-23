tableextension 70100 "CP Customer Ext" extends Customer
{
    fields
    {
        field(70100; "Portal Password"; Text[100])
        {
            Caption = 'Portal Password';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
    }
}
