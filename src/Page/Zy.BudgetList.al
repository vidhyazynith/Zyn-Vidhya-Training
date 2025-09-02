page 50127 "Budget List Page"
{
    PageType = List;
    SourceTable ="Budget table";
    ApplicationArea = ALL;
    Caption = 'Budget List';
    CardPageID = "Budget Card Page"; 
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
                { }
                field("From date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("Category";Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Amount";Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }

            }
        }
    }  
}