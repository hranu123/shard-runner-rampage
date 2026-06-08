// =====================================
// ENEMY HEALTH SYSTEM
// =====================================
enemy_health_max = 100;
enemy_health_current = enemy_health_max;

// Smooth delayed health bar
enemy_health_display = enemy_health_current;
enemy_health_display_speed = 1.2;

// Damage feedback
enemy_damage_flash_timer = 0;
enemy_damage_flash_duration = 10;

// Bullet damage
enemy_rifle_damage = 20;
enemy_pistol_damage = 10;
// Health bar settings
enemy_health_bar_width = 70;
enemy_health_bar_height = 8;
enemy_health_bar_y_offset = -45;

// Death
enemy_is_dead = false;
// Elimination message
global.enemy_eliminated_message_text = "";
global.enemy_eliminated_message_timer = 0;
global.enemy_eliminated_message_duration = 90;