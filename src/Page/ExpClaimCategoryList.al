page 50163 "ZYN_Exp Claim Category List"
{
    PageType = List;
    SourceTable = "ZYN_Expense Claim Category";
    ApplicationArea = ALL;
    Caption = 'Claim Category List';
    UsageCategory = "Lists";
    Editable = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Id"; Rec."Claim Category ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.CategoryName)
                {
                    ApplicationArea = All;
                }
                field("Sub Type"; Rec."Sub Type")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Limit"; Rec.Limit)
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}
