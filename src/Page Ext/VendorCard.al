pageextension 50105 Zyn_VendorCardExt extends "Vendor Card"
{
    actions
    {
        addlast(Processing)
        {
            action(SendToSlave)
            {
                Caption = 'Send To Slave Company';
                ApplicationArea = All;
                Image = SendTo;
                trigger OnAction()
                var
                    CurrentCompanyRec: Record "Zyn_Company Table";
                    SlaveCompanyRec: Record "Zyn_Company Table";
                    MirrorMgt: Codeunit Zyn_SendFromMasterToSlaveMgt;
                begin
                    if not CurrentCompanyRec.Get(CompanyName()) then
                        exit;
                    // Ensure current is Master company
                    if (not CurrentCompanyRec."Is Master") and (CurrentCompanyRec."Master Company Name" <> '') then
                        Error('You can send vendors only from a Master company.');
                    // Apply filter before opening the lookup page
                    SlaveCompanyRec.Reset();
                    SlaveCompanyRec.SetRange("Is Master", false);
                    SlaveCompanyRec.SetRange("Master Company Name", CurrentCompanyRec.Name);
                    // Open the lookup page with filtered records
                    if Page.RunModal(Page::"Zyn_Company List", SlaveCompanyRec) = Action::LookupOK then begin
                        if SlaveCompanyRec.FindSet() then begin
                            repeat
                                MirrorMgt.MirrorVendorToSlave(Rec."No.", SlaveCompanyRec.Name);
                            until SlaveCompanyRec.Next() = 0;
                            Message('Vendor %1 sent to %2 slave companies.', Rec."No.", SlaveCompanyRec.Count);
                        end else
                            Message('No slave companies were selected.');
                    end;
                end;
            }
        }
    }
}