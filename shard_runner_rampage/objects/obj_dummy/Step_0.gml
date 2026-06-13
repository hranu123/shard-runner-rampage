// =====================================
// ENEMY HEALTH 
// =====================================

enemy_health_current = clamp(enemy_health_current, 0, enemy_health_max);


// Smooth delayed health bar
if (enemy_health_display > enemy_health_current)
{
    enemy_health_display -= enemy_health_display_speed;

    if (enemy_health_display < enemy_health_current)
    {
        enemy_health_display = enemy_health_current;
    }
}
else
{
    enemy_health_display = enemy_health_current;
}


// Damage flash timer
if (enemy_damage_flash_timer > 0)
{
    enemy_damage_flash_timer--;
}


// =====================================
// RIFLE BULLET DAMAGE
// =====================================

var hit_bullet = instance_place(x, y, obj_rifle_bullet);

if (hit_bullet != noone)
{
    enemy_health_current -= enemy_rifle_damage;
    enemy_damage_flash_timer = enemy_damage_flash_duration;

    with (hit_bullet)
    {
        instance_destroy();
    }
}

// =====================================
// PISTOL BULLET DAMAGE
// =====================================
var hit_bullet = instance_place(x, y, obj_pistol_bullet);

if (hit_bullet != noone)
{
    enemy_health_current -= enemy_pistol_damage;
    enemy_damage_flash_timer = enemy_damage_flash_duration;

    with (hit_bullet)
    {
        instance_destroy();
    }
}
// =====================================
// SHOTGUN BULLET DAMAGE
// =====================================
var hit_bullet = instance_place(x, y, obj_shotgun_bullet);

if (hit_bullet != noone)
{
    enemy_health_current -= enemy_shotgun_damage;
    enemy_damage_flash_timer = enemy_damage_flash_duration;

    with (hit_bullet)
    {
        instance_destroy();
    }
}
// =====================================
// ENEMY DEATH
// =====================================

if (enemy_health_current <= 0 && !enemy_is_dead)
{
    enemy_health_current = 0;
    enemy_is_dead = true;

    global.dummy_eliminated_message_text = "TEST DUMMY ELIMINATED";
    global.dummy_eliminated_message_timer = 90;
    global.dummy_eliminated_message_duration = 90;

    instance_destroy();
}
