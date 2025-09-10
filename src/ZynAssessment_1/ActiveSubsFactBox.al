page 50220 "Customer Subscription FactBox"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = Customer;
    Caption = 'Active Subscriptions';

    layout
    {
        area(content)
        {
            group(SubscriptionInfo)
            {
                field("Active Subscriptions"; ActiveSubscriptions)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        ActiveSubscriptions: Integer;

    trigger OnAfterGetRecord()
    begin
        CalcActiveSubscriptions();
    end;

    local procedure CalcActiveSubscriptions()
    var
        SubRec: Record "ZYN_Subscription table";
    begin
        Clear(ActiveSubscriptions);
        if Rec."No." = '' then
            exit;

        SubRec.SetRange(CustomerId, Rec."No.");
        SubRec.SetRange("Subcrip. Status", SubRec."Subcrip. Status"::Active);
        ActiveSubscriptions := SubRec.Count;
    end;
}
