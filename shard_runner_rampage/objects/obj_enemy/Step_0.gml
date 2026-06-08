// =====================================
// ENEMY DAMAGE TO PLAYER
// =====================================

var player = instance_place(x, y, obj_main_character);

if (player != noone)
{
    with (player)
    {
        if (!invincible && !is_dead)
        {
            global.health_current -= 10;

            health_damage_flash_timer = health_damage_flash_duration;

            invincible = true;
            invincible_timer = invincible_duration;

            health_regen_timer = 0;
        }
    }
}
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

    global.enemy_eliminated_message_text = "ENEMY ELIMINATED";
    global.enemy_eliminated_message_timer = 90;
    global.enemy_eliminated_message_duration = 90;

    instance_destroy();
}