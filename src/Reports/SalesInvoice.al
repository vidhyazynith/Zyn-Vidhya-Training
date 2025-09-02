report 50102 "Batch Posted Sales Invoice"
{
    Caption = 'Batch Posting';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("SalesInvoice";"Sales Header")
        {
            DataItemTableView = where("Document Type" = const(Invoice));
        }
    }

    trigger OnPostReport()
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        if "SalesInvoice".FindSet() then
            repeat
                SalesPost.Run("SalesInvoice");
            until "SalesInvoice".Next() = 0;
    end;
}