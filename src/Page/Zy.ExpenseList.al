page 50131 "Zyn_Expense List"
{
    PageType = List;
    SourceTable = "Zyn_Expense Table";
    ApplicationArea = ALL;
    Caption = 'Expense List';
    CardPageID = "Zyn_Expense Card";
    UsageCategory = "Lists";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense ID"; Rec."Expense ID")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(BudgetFactBox; Zyn_BudgetCategoryFactBox)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(SelectCategory)
            {
                ApplicationArea = All;
                Caption = 'Category Selection';
                Image = New;
                trigger OnAction()
                begin
                    Page.Run(Page::"Zyn_Category List");
                end;
            }
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Export Expenses to Excel';
                Image = Export;
                trigger OnAction()
                begin
                    Report.RunModal(Report::"Zyn_Expense Export Report", true, true);
                end;
            }
        }
    }
}