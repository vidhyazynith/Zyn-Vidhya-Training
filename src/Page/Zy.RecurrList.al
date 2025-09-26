page 50122 Zyn_RecurringExpenseList
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Zyn_RecurringExpenseTable;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    CardPageId = Zyn_RecurringExpenseCard;
    Caption = 'Recurring Expense List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category"; rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Cycle; Rec.Cycle)
                {
                    ApplicationArea = All;
                }
                field("Next Cycle Date"; Rec."Next Cycle Date")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

