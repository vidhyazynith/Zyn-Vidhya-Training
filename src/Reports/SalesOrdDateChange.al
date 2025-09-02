report 50133 "Sales order date change"
{
    Caption = 'Posting date change';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    AdditionalSearchTerms = 'Posting date change';
    ProcessingOnly = true;

    dataset
    {
        dataitem(SalesHeader;"Sales Header")
        {
            DataItemTableView = where(Status = const(Open), "Document Type" = const(Order));
            trigger OnAfterGetRecord()
            begin
                if SalesHeader."Posting Date" <> NewPostingDate then begin
                    SalesHeader."Posting Date" := NewPostingDate;
                    SalesHeader.Modify(true);
                    UpdatedCount += 1;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field(NewPostingDate; NewPostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'New Posting Date';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        clear(UpdatedCount);
    end;
    var
        NewPostingDate: Date;
        UpdatedCount: Integer;

    trigger OnPostReport()
    begin
        if UpdatedCount > 0 then
            Message('Posting dates changed in %1 order(s).', UpdatedCount)
        else
            Message('No Sales Orders were updated.');
    end;
}