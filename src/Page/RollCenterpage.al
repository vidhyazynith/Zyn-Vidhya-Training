page 50106 Zyn_RollCenter
{
    PageType = RoleCenter;
    ApplicationArea = All;
    SourceTable = "Zyn_Customer VisitLog Table";
    layout
    {
        area(rolecenter)
        {
            part(Cues; "Zyn_Customer Cue Card")
            {
                ApplicationArea = All;
            }
            part(SubscriptionCues; "Zyn_Subscription Cue Page")
            {
                ApplicationArea = All;
            }
            part(SubscriptionReminder; "Zyn_Reminder Notification")
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
                    RunObject = page "Zyn_Technician list";
                }
            }
            group("Assets")
            {
                Caption = 'Assets';
                action("Asset Type List")
                {
                    Caption = 'Asset Type List';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Asset Type List";
                }
                action("Asset List")
                {
                    Caption = 'Asset List';
                    ApplicationArea = All;
                    RunObject = page Zyn_AssetList;
                }
                action("Employee List")
                {
                    Caption = 'Employee List';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Employee List";
                }
                action("Employee Assets")
                {
                    Caption = 'Employee Assets';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Employee Asset list";
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                action("Leave Category")
                {
                    Caption = 'Leave Category';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Leave Category List";
                }
                action("Leave Request")
                {
                    Caption = 'Leave Request';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Leave Request List";
                }
            }
            group("Expenses")
            {
                Caption = 'Expenses';
                action("Expense Category")
                {
                    Caption = 'Expense Category';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Category List";
                }
                action("Expense List")
                {
                    Caption = 'Expense List';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Expense List";
                }
                action("Recurring Expense")
                {
                    Caption = 'Recurring Expense';
                    ApplicationArea = All;
                    RunObject = page Zyn_RecurringExpenseList;
                }
            }
            group("Budget~Income")
            {
                Caption = 'Budget~Income';
                action("Budget List")
                {
                    Caption = 'Budget List';
                    ApplicationArea = All;
                    RunObject = page Zyn_BudgetList;
                }
                action("Income Category")
                {
                    Caption = 'Income Category';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Income Category List";
                }
                action("Income List")
                {
                    Caption = 'Income List';
                    ApplicationArea = All;
                    RunObject = page "Zyn_Income List";
                }
            }
        }
    }
}
