// =====================================
// ENEMY COLLISION WITH PLAYER
// =====================================

if (!other.invincible && !other.is_dead)
{
    global.health_current -= 10;

    other.health_damage_flash_timer = other.health_damage_flash_duration;

    other.invincible = true;
    other.invincible_timer = other.invincible_duration;

    other.health_regen_timer = 0;

    is_attacking_player = true;
    attack_sprite_timer = attack_sprite_duration;
    image_index = 0;
}

