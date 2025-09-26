page 50151 Zyn_AssetList
{
    PageType = List;
    SourceTable = "Zyn_Assets Table";
    ApplicationArea = ALL;
    Caption = 'Asset List';
    CardPageID = Zyn_AssetCard;
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Asset Id"; Rec."Asset ID")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Procured date"; Rec."Procured Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor"; Rec.Vendor)
                {
                    ApplicationArea = All;
                }
                field("Available"; Rec.Available)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.UpdateAvailability();
    end;
}