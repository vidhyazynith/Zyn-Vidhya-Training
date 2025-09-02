namespace microsoft.purchase.document;
enum 50100 "Approval Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Pending)
    {
        Caption = 'Pending';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Escalated)
    {
        Caption = 'Escalated';
    }
}
