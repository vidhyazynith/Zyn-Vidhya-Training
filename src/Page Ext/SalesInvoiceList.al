pageextension 50114 Zyn_SalesInvoiceListExt extends "Sales Invoice List"
{
    actions
    {
        addlast(processing)
        {
            action("Bulk Posting")
            {
                ApplicationArea = All;
                Caption = 'Bulk Posting';
                RunObject = report Zyn_BatchPostedSalesInvoice;
            }
        }
    }
}