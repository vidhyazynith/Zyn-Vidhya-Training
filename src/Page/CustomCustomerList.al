page 50126 "Custom Customer List"
{
    PageType = List;
    SourceTable = Customer;
    ApplicationArea = All;
    Editable = false;
    InsertAllowed= false;
    Caption = 'Custom Customer List';
    UsageCategory = "Lists";

    layout
    {
        area(Content)
        {
            group(CustomerDetails)
            {
                Caption = 'Customer Details';
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Address"; Rec.Address)
                {
                    ApplicationArea = All;
                }

                field("City"; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Pin Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
            }
            }

            part("Sales Ord List Part"; "Sales Ord List Part")
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
                Caption = 'Sales Order';
            }
            part("Sales Inv List Part"; "Sales Inv List Part")
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
                Caption = 'Sales Invoice';
            }
            part("Sales Credit Memo List Part"; "Sales Credit Memo List Part")
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
                Caption = 'Sales Credit Memo';
            }
            
        }
    }
}