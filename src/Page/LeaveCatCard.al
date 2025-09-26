page 50133 "Zyn_Leave Card Page"
{
    PageType = Card;
    SourceTable = "Zyn_Leave Category Table";
    ApplicationArea = ALL;
    Caption = 'Leave Category Card';
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Category ID"; Rec."Leave Cat. ID")
                {
                    ApplicationArea = All;
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. of Days Allowed"; Rec."Allowed Days")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}