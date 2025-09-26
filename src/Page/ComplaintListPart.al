page 50109 "Zyn_Complaint ListPart"
{
    PageType = ListPart;
    SourceTable = "Zyn_Complaint Table";
    ApplicationArea = All;
    Caption = 'Complaint List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer ID"; rec."Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Problem"; rec."Problem")
                {
                    ApplicationArea = All;
                }
                field("Problem Description"; rec."Problem Description")
                {
                    ApplicationArea = All;
                }
                field("Date"; rec."Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}