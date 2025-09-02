namespace DefaultPublisher.ALProject4;

using Microsoft.Foundation.Company;
pageextension 50120 CompaniesListExt extends Companies
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
                RunObject = page "UpdatePage";
            }
        }
        
    }
}
