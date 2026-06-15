// =====================================
// EXPLOSION DELAYED ANIMATION
// =====================================

frame_timer++;

// Move through frames slowly
if (image_index < image_number - 1)
{
    if (frame_timer >= frame_delay)
    {
        frame_timer = 0;
        image_index++;
    }
}
else
{
    // Stay on final frame before disappearing
    end_timer++;

    if (end_timer >= end_delay)
    {
        instance_destroy();
    }
}