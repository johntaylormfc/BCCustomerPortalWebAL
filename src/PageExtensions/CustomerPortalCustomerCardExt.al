pageextension 70101 "CP Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Portal Password"; Rec."Portal Password")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the portal password for this customer.';
            }
        }
    }
}
