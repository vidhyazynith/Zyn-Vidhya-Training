page 50150 "Asset Type Card"
{
    PageType = Card;
    SourceTable ="Asset Type Table";
    ApplicationArea = ALL;
    Caption = 'Asset Type Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                // field("Asset Type ID"; Rec."Asset Type ID")
                // {
                //     ApplicationArea = All;
                // }
                field("Asset Category";Rec."Asset Category")
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