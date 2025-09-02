page 50124 "Income Category List"
{
    PageType = List;
    SourceTable ="Income Category table";
    ApplicationArea = ALL;
    Caption = 'Income Category List';
    CardPageID = "Income Category Card";
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
                field("Description";Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(IncomeCategoryFactbox; "Income Category FactBox")
            {
                SubPageLink = Name = field(Name); // Link FactBox to selected category
                ApplicationArea = All;
            }
        }
    }
}