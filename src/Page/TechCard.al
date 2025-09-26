page 50107 "Zyn_Technician Log Card"
{
    PageType = Card;
    SourceTable = "Zyn_Technician Log Table";
    ApplicationArea = All;
    Editable = true;
    Caption = 'Technician Log Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("ID"; Rec."Technician ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Technician Name")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}