tableextension 50105 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50100; "Approval Status"; Enum "Approval Status pur")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
        }
    }
}