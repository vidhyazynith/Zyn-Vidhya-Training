page 50125 "Employee List Page"
{
    PageType = List;
    SourceTable = "Employee Table";
    ApplicationArea = ALL;
    Caption = 'Employee List';
    CardPageID = "Employee Card Page"; 
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee ID"; Rec."Employee ID")
                { ApplicationArea = All;}
                field("Employee Name"; Rec."Emp. Name")
                {
                    ApplicationArea = All;
                }
                field("Department";Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Role"; Rec."Role")
                {
                ApplicationArea = All;
                }   

            }
        }
        area(FactBoxes)
        {
            part(AssignedAssets; "Assigned Assets Factbox") { ApplicationArea = All; SubPageLink = "Employee ID" = field("Employee ID");}
        }
    } 
    actions
    {
        area(processing)
        {
            action(LeaveRequest)
            {
                ApplicationArea = All;
                Caption = 'Leave Request';
                RunObject = page "Leave Req List Page";
            }
        }
    } 

}