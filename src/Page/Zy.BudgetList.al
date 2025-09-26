page 50127 Zyn_BudgetList
{
    PageType = List;
    SourceTable = "Zyn_Budget Table";
    ApplicationArea = ALL;
    Caption = 'Budget List';
    CardPageID = "Zyn_Budget Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Budget ID"; Rec."Budget ID")
                {

                }
                field("From date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}