page 50152 Zyn_AssetCard
{
    PageType = Card;
    SourceTable = "Zyn_Assets Table";
    ApplicationArea = ALL;
    Caption = 'Asset Card';
    layout
    {
        area(content)
        {
            group(General)
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