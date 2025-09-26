codeunit 50102 "Zyn_RecurringExpenseProcessor"
{
    Subtype = Normal; 
    trigger OnRun()
    begin
        ProcessRecurringExpenses();
    end;
    local procedure ProcessRecurringExpenses()
    var
        RecExp: Record Zyn_RecurringExpenseTable;
        Exp: Record "Zyn_Expense Table";
    begin
        RecExp.Reset();
        if RecExp.FindSet() then
            repeat
                // Process if due or overdue
                if (RecExp."Next Cycle Date" <> 0D) and (RecExp."Next Cycle Date" <= WorkDate()) then begin
                    // Insert new Expense entry
                    Exp.Init();
                    Exp."Expense ID" := GetNextExpenseID();
                    Exp.Description := 'Recurring Expense - ' + RecExp.Category;
                    Exp.Amount := RecExp.Amount;
                    Exp.Category := RecExp.Category;
                    Exp.Date := RecExp."Next Cycle Date"; // use NextCycle instead of WorkDate
                    Exp.Insert(true);
                    // Update next cycle date
                    RecExp.CalcNextCycleDate(RecExp."Next Cycle Date", RecExp.Cycle);
                    RecExp.Modify(true);
                end;
            until RecExp.Next() = 0;
    end;
    //Get Next Expense ID 
    local procedure GetNextExpenseID(): Integer
    var
        Exp: Record "Zyn_Expense Table";
    begin
        if Exp.FindLast() then
            exit(Exp."Expense ID" + 1)
        else
            exit(1);
    end;
}
 
 