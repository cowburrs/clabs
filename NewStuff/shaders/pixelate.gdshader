shader_type canvas_item;

uniform float block_size : hint_range(1.0, 200.0, 1.0) = 8.0;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment()
{
    vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;

    vec2 pixel = SCREEN_UV * screen_size;
    pixel = floor(pixel / block_size) * block_size;

    vec2 uv = pixel / screen_size;

    COLOR = texture(screen_texture, uv);
}
