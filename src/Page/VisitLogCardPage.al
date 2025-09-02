namespace DefaultPublisher.ALProject4;


using Microsoft.Sales.Customer;

page 50103 "Customer Visit Log Card"
{
    PageType = Card;
    SourceTable = "Customer Visit Log";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry Number"; Rec."Entry Number")
                {
                    ApplicationArea = All;
                }
                field("Customer Number"; Rec."Customer Number")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
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