page 50150 "Zyn_Asset Type Card"
{
    PageType = Card;
    SourceTable = "Zyn_Asset Type Table";
    ApplicationArea = ALL;
    Caption = 'Asset Type Card';
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Asset Category"; Rec."Asset Category")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}