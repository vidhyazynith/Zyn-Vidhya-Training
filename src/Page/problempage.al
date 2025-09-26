page 50100 Zyn_CompliantCard
{
    PageType = Card;
    SourceTable = "Zyn_Complaint Table";
    ApplicationArea = All;
    Caption = 'Compliant Card';
    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Problem"; Rec.Problem)
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                }
                field("Technician id"; Rec."Technician ID")
                {
                    ApplicationArea = All;
                }
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}