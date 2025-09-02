page 50135 "Leave Req List Page"
{
    PageType = List;
    SourceTable = "Leave Request Table";
    ApplicationArea = ALL;
    Caption = 'Leave Request List';
    CardPageID = "Leave Request Card Page"; 
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false; 

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Req. ID"; Rec."Leave Req ID")
                { 
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Leave category";Rec."Leave Category")
                {
                    ApplicationArea = All;
                }
                field("Reason"; Rec.Reason)
                {
                    ApplicationArea = All;
                }   
                field("Start date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Remaining Leave"; Rec."Remaining Leave")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }

            }
        }
    } 
}