page 50147 "Zyn_Category List"
{
    PageType = List;
    SourceTable = "Zyn_Category Table";
    ApplicationArea = ALL;
    Caption = 'Category List';
    CardPageID = "Zyn_Category Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
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
        area(factboxes)
        {
            part(CategoryExpenseFactbox; Zyn_ExpenseCategoryFactBox)
            {
                SubPageLink = Name = field(Name); // Link FactBox to selected category
                ApplicationArea = All;
            }
            part(CategoryBudgetFactbox; Zyn_BudgetCategoryFactBox)
            {
                SubPageLink = Category = field(Name); // Link FactBox to selected category
                ApplicationArea = All;
            }
        }
    }
}