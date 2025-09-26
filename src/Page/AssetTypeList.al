page 50146 "Zyn_Asset Type List"
{
    PageType = List;
    SourceTable = "Zyn_Asset Type table";
    ApplicationArea = ALL;
    Caption = 'Asset Type List';
    CardPageID = "Zyn_Asset Type Card";
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
                {

                }
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