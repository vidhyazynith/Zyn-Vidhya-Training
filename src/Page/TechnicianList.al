page 50104 "Zyn_Technician list"
{
    PageType = List;
    SourceTable = "Zyn_Technician Log Table";
    ApplicationArea = All;
    Caption = 'Technician List';
    UsageCategory = Lists;
    Editable = true;
    CardPageID = "Zyn_Technician Log Card";
    layout
    {
        area(Content)
        {
            group(main)
            {
                repeater(Group)
                {
                    field("ID"; Rec."Technician ID")
                    {
                        ApplicationArea = All;
                    }
                    field("Name"; Rec."Technician Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Department"; rec."Department")
                    {
                        ApplicationArea = All;
                    }
                    field("Phone No."; rec."Phone No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Prob Count"; rec."Prob Count")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
            part("Complaint ListPart"; "Zyn_Complaint ListPart")
            {
                SubPageLink = "Technician ID" = field("Technician ID");
                ApplicationArea = All;
            }
        }
    }
}