// =====================================
// RPG BULLET STEP EVENT
// Creates delayed explosion animation
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


// =====================================
// CHECK COLLISION WITH ANY ENEMY
// =====================================

var hit_enemy = noone;

for (var i = 0; i < array_length(explosion_targets); i++)
{
    var enemy_hit_check = instance_place(x, y, explosion_targets[i]);

    if (enemy_hit_check != noone)
    {
        hit_enemy = enemy_hit_check;
        break;
    }
}


// =====================================
// ON ENEMY HIT
// =====================================

if (hit_enemy != noone)
{
    // Create explosion effect
    var explosion = instance_create_layer(x, y, layer, obj_explosion);

    explosion.sprite_index = explosion_sprite;
    explosion.image_index = 0;
    explosion.image_speed = 0;

    // Delayed animation settings
    explosion.frame_timer = 0;
    explosion.frame_delay = 6;

    // Delay before explosion disappears
    explosion.end_timer = 0;
    explosion.end_delay = 18;

    // Destroy enemy that was hit
    with (hit_enemy)
    {
        instance_destroy();
    }

    // Destroy RPG bullet
    instance_destroy();
    exit;
}