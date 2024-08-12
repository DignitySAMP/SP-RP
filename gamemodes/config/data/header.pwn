// Fixing reparse warnings
forward bool:GetMapZoneName(MapZone:id, name[], size = sizeof(name)) ;
forward MapZone:GetMapZoneAtPoint2D(Float:x, Float:y) ;
forward Float:GetPointDistanceToPoint(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2 = FLOAT_NAN, Float:z2 = FLOAT_NAN);

#include "config/data/skins.pwn"
#include "config/data/streets.pwn"
#include "config/data/zones.pwn"
#include "config/data/area.pwn"
#include "config/data/calendar.pwn"


forward Float: frandom(Float:min, Float:max, dp = 4)  ;

enum {

    NAME_FULLNAME,
    NAME_FIRSTNAME,
    NAME_LASTNAME
} ;


// ELS
#define LS_GYM_EXT_X (2359.5649)
#define LS_GYM_EXT_Y (-1312.1975)
#define LS_GYM_EXT_Z (24.0063)

// Little Mexico
#define SF_GYM_EXT_X (1672.7020)
#define SF_GYM_EXT_Y (-1857.9373)
#define SF_GYM_EXT_Z (13.1857)

// EC Gym
#define LV_GYM_EXT_X (1976.6421)
#define LV_GYM_EXT_Y (-2022.9254)
#define LV_GYM_EXT_Z (13.5469)

// Non enterable

#define GANTON_GYM_EXT_X (2238.9714)
#define GANTON_GYM_EXT_Y (-1694.6267)
#define GANTON_GYM_EXT_Z (13.5250)

#define BEACH_GYM_EXT_X (666.3855)
#define BEACH_GYM_EXT_Y (-1879.8040)
#define BEACH_GYM_EXT_Z (5.1545)
