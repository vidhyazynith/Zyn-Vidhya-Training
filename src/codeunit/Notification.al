codeunit 50171 "Zyn_Leave Notification Mgt"
{
    Subtype = Normal;
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        // Emprec: Record "Employee Table";
        leaverec : Record "Zyn_Leave Request Table";
    begin
        LeaveRec.SetCurrentKey(SystemModifiedAt);
        LeaveRec.Ascending := true;
    if LeaveRec.FindLast()then begin
        Notification.Message := StrSubstNo(
            'Leave Request %1 for Employee %2 has been %3.',
            LeaveRec."Leave Req ID",
            LeaveRec."Employee Name",
            Format(LeaveRec.Status));
        Notification.Scope := NotificationScope::LocalScope;
        Notification.Send();
    end;
    end;

} 
    
    
    