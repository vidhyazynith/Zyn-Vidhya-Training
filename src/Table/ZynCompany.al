table 50124 "Zyn_Company Table"
{
    DataPerCompany = false;
    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the unique company identifier. Once set, the Name cannot be changed.';
            trigger OnValidate()
            begin
                if xRec.Name <> '' then
                    Error(NameErr);
            end;
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
            ToolTip = 'Specifies whether the company is an evaluation company.';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
            ToolTip = 'Specifies the display name of the company.';
        }
        field(4; Id; Guid)
        {
            Caption = 'Id';
            ToolTip = 'Specifies the unique identifier (GUID) of the company.';
        }
        field(5; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
            ToolTip = 'Specifies the associated business profile identifier.';
        }
        field(6; "Is Master"; Boolean)
        {
            Caption = 'Is Master Company';
            ToolTip = 'Specifies whether this company is a master company.';
            trigger OnValidate()
            var
                SlaveCompany: Record "Zyn_Company Table";
            begin
                if "Is Master" then begin
                    MasterCheck.Reset();
                    MasterCheck.SetRange("Is Master", true);
                    if not MasterCheck.IsEmpty and (MasterCheck.Name <> Rec.Name) then
                        Error(MasterExistsErr);
                end else begin
                    // Warn if there are slaves linked to this master
                    SlaveCompany.Reset();
                    SlaveCompany.SetRange("Master Company Name", Rec.Name);
                    if not SlaveCompany.IsEmpty then
                        Message(DemotedWithSlavesMsg);
                end;
            end;
        }
        field(7; "Master Company Name"; Text[30])
        {
            Caption = 'Master Company Name';
            ToolTip = 'Specifies the master company that this company is linked to. Only companies marked as Master can be selected.';
            TableRelation = "Zyn_Company Table".Name WHERE("Is Master" = const(true));
            trigger OnValidate()
            begin
                if "Master Company Name" = Rec.Name then
                    Error(CannotReferenceItselfErr);
                if "Master Company Name" <> '' then begin
                    MasterCompany.Reset();
                    if not MasterCompany.Get("Master Company Name") then
                        Error(MasterNotExistErr);
                    if not MasterCompany."Is Master" then
                        Error(NotAMasterErr);
                end;
            end;
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
    var
        //Error Labels
        NameErr: Label 'Changing the Name of a company is not allowed.';
        MasterExistsErr: Label 'There can only be one master company per group.';
        MasterNotExistErr: Label 'The selected master company does not exist.';
        NotAMasterErr: Label 'The selected company is not marked as a master.';
        CannotReferenceItselfErr: Label 'A company cannot be set as its own master.';
        // Record Variables
        MasterCheck: Record "Zyn_Company Table";
        MasterCompany: Record "Zyn_Company Table";
        //Message
        DemotedWithSlavesMsg: Label 'This company has been demoted from master, but it still has slave companies linked. Please reassign their master company.';

}
