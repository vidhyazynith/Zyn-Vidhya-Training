enum 50112 "ZYN_Claim_Status"
{
    Extensible = true;
    value(0; " ")
    {
        Caption = '';
    }
    value(1; PendingApproval)
    {
        Caption = 'Pending Approval';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Rejected)
    {
        Caption = 'Rejected';
    }
    value(4; Cancelled)
    {
        Caption = 'Cancelled';
    }
}
