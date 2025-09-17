page 50162 "ZYN_Expense Claim Card"
{
    PageType = Card;
    SourceTable = "ZYN_Expense Claim Table";
    ApplicationArea = ALL;
    Caption = 'Expense Claim Card';
    layout
    {
        area(content)
        {
            group(general)
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
                    trigger OnDrillDown()
                    var
                        ClaimCategory: Record "ZYN_Expense Claim Category";
                    begin
                        if Page.RunModal(Page::"ZYN_Exp Claim Category List", ClaimCategory) = Action::LookupOK then begin
                            Rec.Category := ClaimCategory.CategoryName;   // fill category name
                            Rec."Sub Type" := ClaimCategory."Sub Type";   // fill sub type
                            //Recalculate available limit
                            Rec.CalcAvailableLimit();
                            CurrPage.Update();
                        end;
                    end;
                }
                field("Sub Type"; Rec."Sub Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.CalcAvailableLimit();
                        CurrPage.Update();
                    end;
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
                field("Rejection Reason"; Rec."Rejection Reason")
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
            action(UploadBill)
            {
                Caption = 'Upload Bill';
                ApplicationArea = All;
                trigger OnAction()
                var
                    BillMgt: Codeunit "ZYN_Bill File Management";
                begin
                    BillMgt.UploadBill(Rec);
                end;
            }
            action(CancelClaim)
            {
                Caption = 'Cancel Claim';
                ApplicationArea = All;
                Image = Cancel;
                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::PendingApproval then
                        Error('Only claims with status Pending Approval can be cancelled.');
                    Rec.Status := Rec.Status::Cancelled;
                    Rec.Modify(true);
                    Message('Claim %1 has been cancelled.', Rec."Claim ID");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcAvailableLimit();
    end;
}