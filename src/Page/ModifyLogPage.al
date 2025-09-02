namespace DefaultPublisher.ALProject4;


using Microsoft.Sales.Customer;
page 50108 "Customer Modify Log List"
{
    PageType = List;
    SourceTable = "Customer Modify Log";
    ApplicationArea = All;
    InsertAllowed = false;
    Editable = False;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Customer Number"; Rec."Customer Number")
                {
                    ApplicationArea = All;
                }

                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
