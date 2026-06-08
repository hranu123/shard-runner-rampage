// =====================================
// RPG BULLET STEP EVENT
// Explosion on obj_square collision
// =====================================


// Destroy bullet if it leaves the room
if (x < 0 || x > room_width || y < 0 || y > room_height)
{
    instance_destroy();
    exit;
}


// Move bullet forward
x += lengthdir_x(rpg_speed, direction);
y += lengthdir_y(rpg_speed, direction);


// Check collision with obj_square
var hit_enemy = instance_place(x, y, explosion_target);

if (hit_enemy != noone)
{
    // Create explosion effect at collision position
    var explosion = instance_create_layer(x, y, layer, obj_explosion);
    explosion.sprite_index = explosion_sprite;
    explosion.image_index = 0;
    explosion.image_speed = 0.4;

    // Destroy the square
    with (hit_enemy)
    {
        instance_destroy();
    }

    // Destroy the RPG bullet
    instance_destroy();
    exit;
}


// Destroy bullet when it leaves the room
if (x < 0 || x > room_width || y < 0 || y > room_height)
{
    instance_destroy();
    exit;
}