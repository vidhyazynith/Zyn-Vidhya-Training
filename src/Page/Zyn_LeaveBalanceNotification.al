page 50178 Zyn_LeaveBalanceNotificaion
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "User Setup";
    layout
    {
        area(content)
        {
            group(Group)
            {
                field(UserID; UserId())
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    trigger OnOpenPage();
    var
        NotificationMgt: Codeunit "Zyn_Leave Notification Mgt";
    begin
        NotificationMgt.ShowLeaveBalanceNotification();
    end;
}