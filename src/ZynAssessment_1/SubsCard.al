page 50159 "ZYN_Subscription Card"
{
    PageType = Card;
    SourceTable ="ZYN_Subscription Table";
    ApplicationArea = ALL;
    Caption = 'Subscription Card';
  

    layout
    {
        area(content)
        {
            group(General)
            {
                field("SubId"; Rec."Sub ID")
                {
                    ApplicationArea =All;
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
