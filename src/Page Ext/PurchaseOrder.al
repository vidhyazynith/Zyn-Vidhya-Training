pageextension 50101 PurchaseOrderCardExt extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = All;
            }
        }
    }
}