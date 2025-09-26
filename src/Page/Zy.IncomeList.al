page 50138 "Zyn_Income List"
{
    PageType = List;
    SourceTable = "Zyn_Income Table";
    ApplicationArea = ALL;
    Caption = 'Income List';
    CardPageID = "Zyn_Income Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Income ID"; Rec."Income ID")
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
                field("Category name"; Rec."Category Name")
                {
                }
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
                    Page.Run(Page::"Zyn_Income Category List");
                end;
            }
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Income Expenses to Excel';
                Image = Export;
                trigger OnAction()
                begin
                    Report.RunModal(Report::"Zyn_Income Export Report", true, true);
                end;
            }
        }
    }
}