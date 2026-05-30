// Only create inventory once
if (!variable_global_exists("weapon_inventory"))
{
    // Create 5 inventory slots
    global.weapon_inventory = [noone, noone, noone, noone, noone];

    // Put sword in slot 1 from the start of the game
    global.weapon_inventory[0] = "sword";

    // Select slot 1
    global.selected_weapon_slot = 0;

    // Equip sword by default
    global.equipped_weapon = "sword";
}