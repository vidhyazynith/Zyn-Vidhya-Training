page 50124 "Zyn_Income Category List"
{
    PageType = List;
    SourceTable = "Zyn_Income Category Table";
    ApplicationArea = ALL;
    Caption = 'Income Category List';
    CardPageID = "Zyn_Income Category Card";
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
            part(IncomeCategoryFactbox; "Zyn_Income Category FactBox")
            {
                SubPageLink = Name = field(Name); // Link FactBox to selected category
                ApplicationArea = All;
            }
        }
    }
}