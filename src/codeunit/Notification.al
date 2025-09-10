    // codeunit 50103 "Leave Request Notifications"
    // {
    //     [EventSubscriber(ObjectType::Table, Database::"Leave Request Table", 'OnAfterModifyEvent', '', true, true)]
    //     procedure NotifyLeaveStatus(var Rec: Record "Leave Request Table"; RunTrigger: Boolean)
    //     var
    //         LeaveReq: Record "Leave Request Table";
    //         Notification: Notification;
    //     begin
    //         // Refetch the record to ensure we get the latest values
    //         if LeaveReq.Get(Rec."Leave Req ID") then begin
    //             if (LeaveReq.Status = Enum::"Leave Approval Status"::Approved) or
    //    (LeaveReq.Status = Enum::"Leave Approval Status"::Rejected) then
    //                 begin
    //                 Notification.Message :=
    //                   StrSubstNo(
    //                     'Leave Request %1 for Employee %2 has been %3.',
    //                     LeaveReq."Leave Req ID",
    //                     LeaveReq."Employee Name",
    //                     Format(LeaveReq.Status)
    //                   );

    //                 // Use global scope so it appears in Role Center (blue info area)
    //                 Notification.Scope := NotificationScope::GlobalScope;
    //                 Notification.Send();
    //             end;
    //         end;
    //     end;
    // }
codeunit 50171 "My Notification Mgt."
{
    Subtype = Normal;
 
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        // Emprec: Record "Employee Table";
        leaverec : Record "Leave Request Table";
    begin
        LeaveRec.SetCurrentKey(SystemModifiedAt);
        LeaveRec.Ascending := true;
        
    if LeaveRec.FindLast()then begin
        Notification.Message := StrSubstNo(
             'Leave Request %1 for Employee %2 has been %3.',
                        LeaveRec."Leave Req ID",
                        LeaveRec."Employee Name",
                        Format(LeaveRec.Status)
                      );
        Notification.Scope := NotificationScope::LocalScope;
        Notification.Send();
    end;
    end;

}
 
    
    page 50178 "My Notification Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "User Setup"; // any lightweight table
 
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
        NotificationMgt: Codeunit "My Notification Mgt.";
    begin
        NotificationMgt.ShowLeaveBalanceNotification();
    end;
}
    
    
    pageextension 50104 "My RollCenter Ext" extends "Business Manager Role Center"
    {
        layout
        {
            addfirst(rolecenter)
            {
                part(NotificationPart; "My Notification Part")
                {
                    ApplicationArea = All;
                    Visible = false; 
                }
                
            }
        }
    }
    
    
    