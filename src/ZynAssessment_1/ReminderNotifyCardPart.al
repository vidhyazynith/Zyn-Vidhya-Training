page 50160 "Zyn_Reminder Notification"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Zyn_Subscription table";
    layout
    {
        area(content)
        {
            group(Group)
            {
            }
        }
    }
    trigger OnOpenPage();
    var
        NotificationMgt: Codeunit "Zyn_Subscription Reminder";
    begin
        NotificationMgt.ProcessReminders();
    end;
}