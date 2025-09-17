page 50164 "ZYN_Claim Approval Request"
{
    PageType = List;
    SourceTable = "ZYN_Expense Claim Table";
    ApplicationArea = ALL;
    Caption = 'Claim Approval Request';
    UsageCategory = "Lists";
    SourceTableView = where(Status = const("PendingApproval"));
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
    actions
    {
        area(processing)
        {
            action(ApproveClaim)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                trigger OnAction()
                var
                    ClaimCategory: Record "ZYN_Expense Claim Category";
                    DupCheck: Record "ZYN_Expense Claim Table";
                    ThreeMonthsAgo: Date;
                begin
                    // 1. Status check
                    if Rec.Status <> Rec.Status::"PendingApproval" then
                        Error('Only claims with Pending Approval status can be approved.');
                    // 2. Amount <= limit
                    ClaimCategory.SetRange("CategoryName", Rec.Category);    // filter by Category name
                    ClaimCategory.SetRange("Sub Type", Rec."Sub Type");      // filter by Sub Type
                    if ClaimCategory.FindFirst() then begin
                        if Rec.Amount > Rec."Available Limit" then
                            Error('Amount %1 exceeds available limit %2 for category %3.',
                                  Rec.Amount, Rec."Available Limit", ClaimCategory.CategoryName);
                    end;
                    // 3. Bill date within 3 months
                    ThreeMonthsAgo := CalcDate('<-3M>', WorkDate());
                    if Rec."Bill Date" < ThreeMonthsAgo then
                        Error('Bill date %1 is older than 3 months from work date %2.',
                              Rec."Bill Date", WorkDate());
                    // 4. Duplicate check
                    DupCheck.Reset();
                    DupCheck.SetRange(Category, Rec.Category);
                    DupCheck.SetRange("Employee ID", Rec."Employee ID");
                    DupCheck.SetRange("Sub Type", Rec."Sub Type");
                    DupCheck.SetRange("Bill Date", Rec."Bill Date");
                    DupCheck.SetFilter("Claim ID", '<>%1', Rec."Claim ID"); // exclude self
                    if DupCheck.FindFirst() then
                        Error('Duplicate claim exists with same Category, Employee, Sub Type, and Bill Date.');
                    //All validations passed
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify(true);
                    Message('Claim %1 has been approved.', Rec."Claim ID");
                end;
            }

            action(RejectClaim)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;
                trigger OnAction()
                begin
                    // 1. Status must be Pending Approval
                    if Rec.Status <> Rec.Status::"PendingApproval" then
                        Error('Only claims with Pending Approval status can be rejected.');
                    // 2. Bill must be uploaded
                    if not Rec.Bill.HasValue then
                        Error('Bill must be uploaded before rejecting the claim.');
                    //Passed all validations
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify(true);
                    Message('Claim %1 has been rejected.', Rec."Claim ID");
                end;
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcAvailableLimit();
    end;
}