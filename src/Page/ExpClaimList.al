page 50161 "ZYN_Exp Claim List"
{
    PageType = List;
    SourceTable = "ZYN_Expense Claim Table";
    ApplicationArea = ALL;
    Caption = 'Expense Claim List';
    CardPageID = "ZYN_Expense Claim Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim Id"; Rec."Claim ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Sub Type"; Rec."Sub Type")
                {
                    ApplicationArea = All;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                }
                field("Available Limit"; Rec."Available Limit")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Bill"; Rec.Bill)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        BillMgt: Codeunit "ZYN_Bill File Management";
                    begin
                        BillMgt.ViewBill(Rec);
                    end;
                }
                field("Bill Date"; Rec."Bill date")
                {
                    ApplicationArea = All;
                }
                field("Remarks"; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcAvailableLimit();
    end;
}
