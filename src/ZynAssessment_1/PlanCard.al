page 50157 "Zyn_Plan Card"
{
    PageType = Card;
    SourceTable = "Zyn_Plan Table";
    ApplicationArea = ALL;
    Caption = 'Plan Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Plan ID"; Rec."Plan Id")
                {
                    ApplicationArea = All;
                }
                field("Fee"; Rec.Fee)
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.PlanName)
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SetInactive)
            {
                Caption = 'Set Plan Inactive';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.Validate(Status, Rec.Status::Inactive);
                    Rec.Modify(true);
                    Message('Plan %1 has been set to Inactive and all related subscriptions are now inactive.', Rec."PlanName");
                end;
            }
        }
    }
}
