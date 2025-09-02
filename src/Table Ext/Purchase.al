tableextension 50105 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50100; "Approval Status"; Enum Microsoft.Purchase.Document."Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
        }
    }
}