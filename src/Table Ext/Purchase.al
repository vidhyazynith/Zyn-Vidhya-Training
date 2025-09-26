tableextension 50105 Zyn_PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50100; "Approval Status"; Enum "Zyn_Purchase Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
        }
    }
}