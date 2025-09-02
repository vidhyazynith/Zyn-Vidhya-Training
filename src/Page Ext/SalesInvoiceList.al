pageextension 50114 SalesInvListExt extends "Sales Invoice List"
{
    actions
    {
        addlast(processing)
        {
            action("Bulk Posting")
            {
                ApplicationArea = All;
                Caption = 'Bulk Posting';
                // trigger OnAction()
                // begin
                //     Report.RunModal(Report::"Batch Posted Sales Invoice", true, true);
                // end;
                RunObject = report "Batch Posted Sales Invoice";
            }
        }
        
    }
}