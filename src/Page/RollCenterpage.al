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
            part(SubscriptionCues; "ZYN_Subscription Cue Page")
            {
                ApplicationArea = All;
            }
             part(SubscriptionReminder; "ZYN_Reminder Notification")
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

             group("Assets")
            {
                Caption = 'Assets';
                 action("Asset Type List")
                {
                    Caption = 'Asset Type List';
                    ApplicationArea = All;
                    RunObject = page "Asset Type List";
                }

                action("Asset List")
                {
                    Caption = 'Asset List';
                    ApplicationArea = All;
                    RunObject = page AssetList;
                }
                action("Employee List")
                {
                    Caption = 'Employee List';
                    ApplicationArea = All;
                    RunObject = page "Employee List page";
                }
 
                action("Employee Assets")
                {
                    Caption = 'Employee Assets';
                    ApplicationArea = All;
                    RunObject = page EmpAssetList;
                }
            }
            group("Leave Management")
            {
                Caption='Leave Management';
                action("Leave Category")
                {
                    Caption = 'Leave Category';
                    ApplicationArea = All;
                    RunObject = page "Leave Cat. List Page";
                }
                action("Leave Request")
                {
                    Caption = 'Leave Request';
                    ApplicationArea = All;
                    RunObject = page "Leave Req List Page";
                }
            }
            group("Expenses")
            {
                Caption='Expenses';
                action("Expense Category")
                {
                    Caption = 'Expense Category';
                    ApplicationArea = All;
                    RunObject = page "Category List Page";
                }
                action("Expense List")
                {
                    Caption = 'Expense List';
                    ApplicationArea = All;
                    RunObject = page "Expense List Page";
                }
                action("Recurring Expense")
                {
                    Caption='Recurring Expense';
                    ApplicationArea=All;
                    RunObject=page "Recurr Exp List";
                }
            }
            group("Budget~Income")
            {
                Caption='Budget~Income';
                action("Budget List")
                {
                    Caption = 'Budget List';
                    ApplicationArea = All;
                    RunObject = page "Budget List Page";
                }
                action("Income Category")
                {
                    Caption = 'Income Category';
                    ApplicationArea = All;
                    RunObject = page "Income Category List";
                }
                action("Income List")
                {
                    Caption = 'Income List';
                    ApplicationArea = All;
                    RunObject = page "Income List Page";
                }
            }
        }
    }
}
