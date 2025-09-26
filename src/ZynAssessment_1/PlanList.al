page 50155 "Zyn_Plan List"
{
    PageType = List;
    SourceTable = "Zyn_Plan Table";
    ApplicationArea = ALL;
    Caption = 'Plan List';
    CardPageID = "Zyn_Plan Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Plan ID"; Rec."Plan Id")
                {
                    ApplicationArea = All;
                }
                field("Fee"; Rec.Fee)
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.PlanName)
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
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
