pageextension 50115 CustomerListExt extends "Customer List"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Cust Fact box";"Cust Fact box")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
}