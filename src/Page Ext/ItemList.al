pageextension 50132 Zyn_ItemListExt extends "Item list"
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