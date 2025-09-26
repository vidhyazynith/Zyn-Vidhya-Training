pageextension 50115 Zyn_CustomerListExt extends "Customer List"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Cust Fact box"; Zyn_CustomerFactBox)
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(CustomerSubscriptions; Zyn_CustomerSubscripFactBox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}