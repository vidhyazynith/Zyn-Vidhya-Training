page 50160 "ZYN_Reminder Notification"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "ZYN_Subscription table";
 
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
        NotificationMgt: Codeunit "ZYN_Subscription Reminder";
    begin
        NotificationMgt.ProcessReminders();
    end;
}