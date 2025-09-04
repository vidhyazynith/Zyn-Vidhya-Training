page 50151 "AssetList"
{
    PageType = List;
    SourceTable ="Assets Table";
    ApplicationArea = ALL;
    Caption = 'Asset List';
    CardPageID = "AssetCard"; 
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
                { ApplicationArea = All;}
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea =All;
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