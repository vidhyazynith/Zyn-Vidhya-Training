codeunit 50103 "Zyn_Subscription Reminder"
{
    Subtype = Normal;
    procedure ProcessReminders()
    var
        SubRec: Record "Zyn_Subscription table";
        Notification: Notification;
        Customer: Record Customer;
    begin
        SubRec.Reset();
        SubRec.SetRange("Subcrip. Status", SubRec."Subcrip. Status"::Active);
        SubRec.SetRange("Reminder Sent", false); // Only pending reminders
        if SubRec.FindSet() then
            repeat
                if (SubRec."End Date" = CalcDate('<+15D>', WorkDate())) then begin
                    // Get customer details
                    if Customer.Get(SubRec.CustomerId) then begin
                        Notification.Id := CreateGuid();
                        Notification.Scope := NotificationScope::LocalScope;
                        Notification.Message :=
                          StrSubstNo('Reminder: Subscription %1 for customer %2 is expiring on %3.',
                            SubRec."Sub ID", Customer.Name, Format(SubRec."End Date"));
                        Notification.Send();
                    end;
                    // Mark reminder as sent
                    SubRec.Validate("Reminder Sent", true);
                    SubRec.Modify(true);
                end;
            until SubRec.Next() = 0;
    end;
}
