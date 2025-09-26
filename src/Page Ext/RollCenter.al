pageextension 50104 Zyn_RollCenterExt extends "Business Manager Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(NotificationPart; Zyn_LeaveBalanceNotificaion)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}