// Destroy bullet if it leaves the room
if (x < 0 || x > room_width || y < 0 || y > room_height)
{
    instance_destroy();
}
// Move bullet forward
x += lengthdir_x(12, direction);
y += lengthdir_y(12, direction);

// Destroy bullet when it leaves the room
if (x < 0 || x > room_width || y < 0 || y > room_height)
{
    instance_destroy();
}