// =====================================
// ENEMY DAMAGE TEST - STEP EVENT
// Put this in obj_enemy
// =====================================

var player = instance_place(x, y, obj_main_character);

if (player != noone)
{
    with (player)
    {
        if (!invincible && !is_dead)
        {
            health_current -= 10;

            health_damage_flash_timer = health_damage_flash_duration;

            invincible = true;
            invincible_timer = invincible_duration;

            health_regen_timer = 0;
        }
    }
}
