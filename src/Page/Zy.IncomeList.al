page 50138 "Income List Page"
{
    PageType = List;
    SourceTable ="Income table";
    ApplicationArea = ALL;
    Caption = 'Income List';
    CardPageID = "Income Card Page"; 
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
                field("Amount";Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Category";Rec.Category)
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
                    Page.Run(Page::"Income Category List");
                end;
            }

            action(ExportToExcel)
            {
            ApplicationArea = All;
            Caption = 'Income Expenses to Excel';
            Image = Export;

            trigger OnAction()
            begin
                Report.RunModal(Report::"Income Export Report", true, true);
            end;
        }

        }
    
    }
    
    
}