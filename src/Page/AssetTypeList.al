page 50146 "Asset Type List"
{
    PageType = List;
    SourceTable ="Asset Type table";
    ApplicationArea = ALL;
    Caption = 'Asset Type List';
    CardPageID = "Asset Type Card"; 
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Asset Type Id"; Rec."Asset Type ID")
                { }
                field("Asset Category"; Rec."Asset Category")
                {
                    ApplicationArea = All;
                }
                field("Asset Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }

            }
        }
    }  
}