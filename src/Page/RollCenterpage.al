namespace DefaultPublisher.ALProject4;
using Microsoft.Sales.Customer;

page 50106 "New Roll Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    SourceTable = "Customer Visit Log";

    layout
    {
        area(rolecenter)
        {
            part(Cues; "Customer Cue Card")
            {
                ApplicationArea = All;

            }
        }
    }
    actions
    {
        area(Sections)
        {
            group(customer)
            {
                Caption = 'Customer';

                action("Customers")
                {
                    ApplicationArea = All;
                    Caption = 'Customer List';
                    RunObject = page "Customer List";
                }

                action("CustomerContact")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Contact';
                }
            }
            group(Technician)
            {
                Caption = 'Technician';

                action("TechnicianList")
                {
                    ApplicationArea = All;
                    Caption = 'Technician List';
                    RunObject = page "Technician List";
                }
            }


        }
    }
}
