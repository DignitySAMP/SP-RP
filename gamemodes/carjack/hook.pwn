Float: frandom(Float:min, Float:max, dp = 4) {
    new
        // Get the multiplication for storing fractional parts.
		Float:mul = floatpower(10.0, dp),
        imin = floatround(min * mul),
        imax = floatround(max * mul);
    // Get a random int between two bounds and convert it to a float.
    return float(random(imax - imin) + imin) / mul;
}
