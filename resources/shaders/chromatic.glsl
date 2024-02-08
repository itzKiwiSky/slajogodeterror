extern number distortion;
extern number aberration;

vec4 effect(vec4 color , Image texture, vec2 textureColor, vec2 pc)
{
    vec2 cc = textureColor - 0.5;
    float distance = dot(cc, cc) * distortion;
    textureColor = (textureColor + cc * (1.0 + distance) * distance);

    // fake shit aberration
    float sx = aberration / love_ScreenSize.x;
    float sy = aberration / love_ScreenSize.y;
    vec4 r = Texel(texture, vec2(textureColor.x + sx, textureColor.y - sy));
    vec4 g = Texel(texture, vec2(textureColor.x , textureColor.y + sy));
    vec4 b = Texel(texture, vec2(textureColor.x - sx, textureColor.y - sy));
    number a = (r.a + g.a + b.a) / 3.0;

    return vec4(r.r, g.g, b.b, a) * color;
}