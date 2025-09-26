page 50125 "Zyn_Employee List"
{
    PageType = List;
    SourceTable = "Zyn_Employee Table";
    ApplicationArea = ALL;
    Caption = 'Employee List';
    CardPageID = "Zyn_Employee Card";
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
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Emp. Name")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec.Department)
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
            part(AssignedAssets; "Zyn_AssignedAssetsFactbox") { ApplicationArea = All; SubPageLink = "Employee ID" = field("Employee ID"); }
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
                RunObject = page "Zyn_Leave Request List";
            }
        }
    }

}