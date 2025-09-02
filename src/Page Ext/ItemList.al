pageextension 50132 ItemCardExt extends "Item list"
{
    layout
    {
        addafter(Type)
        {
            field("Current Inventory"; rec."current inventory")
            {
                ApplicationArea = All;
 
            }
        }
    }
}