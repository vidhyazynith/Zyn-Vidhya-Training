page 50153 "Zyn_Employee Asset list"
{
    PageType = List;
    SourceTable = "Zyn_Employee Asset Table";
    ApplicationArea = ALL;
    Caption = 'Employee Asset List';
    CardPageID = "Zyn_Employee Asset Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Assigned Date"; Rec."Assigned date")
                {
                    ApplicationArea = All;
                }
                field("Returned date"; Rec."Returned date")
                {
                    ApplicationArea = All;
                }
                field("Lost date"; Rec."Lost date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(AssetHis; Zyn_AssetHistoryFactbox)
            {
                ApplicationArea = All;
            }
        }
    }
}
