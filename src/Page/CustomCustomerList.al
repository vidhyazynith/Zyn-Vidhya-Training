page 50126 "Zyn_Custom Customer List"
{
    PageType = List;
    SourceTable = Customer;
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
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
            part("Sales Ord List Part"; Zyn_SalesOrderListPart)
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
            }
            part("Sales Inv List Part"; Zyn_SalesInvoiceListPart)
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
            }
            part("Sales Credit Memo List Part"; Zyn_SalesCreditMemoListPart)
            {
                SubPageLink = "Sell-to Customer No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
}