page 50136 "Income Category Card"
{
    PageType = Card;
    SourceTable = "Income Category Table";
    ApplicationArea = ALL;
    Caption = 'Income Category Card';
 
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Category ID"; Rec."Category ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}