namespace DefaultPublisher.ALProject4;


using Microsoft.Sales.Customer;
page 50102 "Customer Visit Log List"
{
    PageType = List;
    SourceTable = "Customer Visit Log";
    CardPageId = "Customer Visit Log Card";
    ApplicationArea = All;
    InsertAllowed = false;
    Editable = False;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry Number"; Rec."Entry Number")
                {
                    ApplicationArea = All;
                }
                field("Customer Number"; Rec."Customer Number")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field("Purpose"; Rec."Purpose")
                {
                    ApplicationArea = All;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
