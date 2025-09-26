namespace DefaultPublisher.ALProject4;

using Microsoft.Foundation.Company;
pageextension 50120 Zyn_CompaniesListExt extends Companies
{
    actions
    {
        addlast(processing)
        {
            action(CompanyAction)
            {
                ApplicationArea = All;
                Caption = 'Update Field';
                Image = Edit;
                RunObject = page Zyn_UpdateField;
            }
        }
    }
}
