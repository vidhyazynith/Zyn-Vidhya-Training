page 50158 "Zyn_Subscription List"
{
    PageType = List;
    SourceTable = "Zyn_Subscription table";
    ApplicationArea = ALL;
    Caption = 'Subscription List';
    CardPageID = "Zyn_Subscription Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SubId"; Rec."Sub ID")
                {
                    ApplicationArea = All;
                }
                field("CustId"; Rec.CustomerId)
                {
                    ApplicationArea = All;
                }
                field("PlanId"; Rec."Plan Id")
                {
                    ApplicationArea = All;
                }
                field("StartDate"; Rec."Start date")
                {
                    ApplicationArea = All;
                }
                field("Duration"; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("EndDate"; Rec."End date")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Subcrip. Status")
                {
                    ApplicationArea = All;
                }
                field("Next Biling date"; Rec."Next Billing Date")
                {
                    ApplicationArea = All;
                }
                field("Next Renewal Date"; Rec."Next Renewal Date")
                {
                    ApplicationArea = All;
                }
                field("Reminder Sent"; Rec."Reminder Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
