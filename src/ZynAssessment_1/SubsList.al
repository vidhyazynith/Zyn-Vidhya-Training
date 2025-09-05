page 50158 "Subscription List"
{
    PageType = List;
    SourceTable ="Subscription Table";
    ApplicationArea = ALL;
    Caption = 'Subscription List';
    CardPageID = "Subscription Card"; 
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
                
                }


            }

    }
}
