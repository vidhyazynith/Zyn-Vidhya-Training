page 50148 "Expense Card Page"
{
    PageType = Card;
    SourceTable ="Expense table";
    ApplicationArea = ALL;
    Caption = 'Expense Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                field("Expense ID"; Rec."Expense ID")
                {
                    ApplicationArea = All;
                }
                field("Description";Rec.Description)
                {
                    ApplicationArea = All;
                }
            
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Remaining Budget"; Rec."Remaining Budget")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
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
                    Page.Run(Page::"Category List Page");
                end;
            }
        }
        
    }
//     local procedure GetRemainingBudget(): Decimal;
// var
//     BudgetRec: Record "Budget Table";
//     StartDate: Date;
//     EndDate: Date;
//     CurMonth: Integer;
//     CurYear: Integer;
// begin
//     CurMonth := Date2DMY(WorkDate(), 2);
//     CurYear := Date2DMY(WorkDate(), 3);
//     // Get first and last day of the current WorkDate month
//     StartDate := DMY2Date(1, CurMonth, CurYear); 
//     EndDate := CalcDate('<CM>', StartDate);

//     BudgetRec.Reset();
//     BudgetRec.SetRange("Category", Rec."Category");
//     BudgetRec.SetRange("From Date", StartDate); // Ensure budget is for current month
//     BudgetRec.SetRange("To Date", EndDate);   // Some models use both fields

//     if BudgetRec.FindFirst() then begin
//         // Apply monthly filter for Total Expense flowfield
//         BudgetRec.SetRange("Date Filter", StartDate, EndDate);
//         BudgetRec.CalcFields("Total Expense");

//         // Return monthly Budget - monthly Expense
//         exit(BudgetRec."Budget Amount" - BudgetRec."Total Expense");
//     end else
//         exit(0); // no budget record found for this category/month
// end;
    

    
}