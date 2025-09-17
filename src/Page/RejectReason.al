page 50165 "ZYN_Reject Claim Reason"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Enter Rejection Reason';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Reason"; Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                }
            }
        }
    }
    var
        Reason: Text[250];

    procedure GetReason(): Text[250]
    begin
        exit(Reason);
    end;
}
