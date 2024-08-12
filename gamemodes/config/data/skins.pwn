/*_______________________________________________________________________*\
|                                                                         |
|     Skin Tag Library                                                    |
| _______________________________________________________________________ |
|                                                                         |
|     Author: Crayder                                                     |
|     Date: 9/7/2016                                                      |
|     Version: 2.00                                                       |
| _______________________________________________________________________ |
|                                                                         |
|     Functions:                                                          |
|                                                                         |
|     - GetSkinName(skinid, output[], outlen = sizeof(output))            |
|     - GetSkinModelName(skinid, output[], outlen = sizeof(output))       |
|     - GetSkinSex(skinid)                                                |
|     - GetSkinGender(skinid)                                             |
|     - GetSkinGenderName(skinid, output[], outlen = sizeof(output))      |
|     - GetSkinRace(skinid)                                               |
|     - GetSkinRaceName(skinid, output[], outlen = sizeof(output))        |
|     - GetSkinGang(skinid)                                               |
|     - GetSkinGangName(skinid, output[], outlen = sizeof(output))        |
|     - GetSkinService(skinid)                                            |
|     - GetSkinServiceName(skinid, output[], outlen = sizeof(output))     |
|     - GetSkinType(skinid)                                               |
|     - GetSkinAnimGroup(skinid)                                          |
|     - GetSkinAnimGroupName(skinid, output[], outlen = sizeof(output))   |
|     - GetSkinGroup(skinid)                                              |
|     - GetSkinGroupName(skinid, output[], outlen = sizeof(output))       |
|     - GetSkinFear(skinid)                                               |
|     - GetSkinTemper(skinid)                                             |
|     - GetSkinLawfullness(skinid)                                        |
|     - GetSkinSexAppeal(skinid)                                          |
|     - GetSkinAppeal(skinid)                                             |
|     - GetSkinFOF(skinid)                                                |
|     - Float:GetSkinStrength(skinid)                                     |
|     - Float:GetSkinDefence(skinid)                                      |
|     - IsPlayerMale(playerid)                                            |
|     - IsPlayerFemale(playerid)                                          |
| _______________________________________________________________________ |
|                                                                         |
|     Definitions:                                                        |
|                                                                         |
|     - SKIN_RACE_WHITE                                                   |
|     - SKIN_GENDER_MALE                                                  |
|     - SKIN_GENDER_FEMALE                                                |
|                                                                         |
|     - SKIN_RACE_WHITE                                                   |
|     - SKIN_RACE_BLACK                                                   |
|     - SKIN_RACE_ASIAN                                                   |
|     - SKIN_RACE_LATIN                                                   |
|                                                                         |
|     - SKIN_GANG_NONE                                                    |
|     - SKIN_GANG_GROVE                                                   |
|     - SKIN_GANG_BALLA                                                   |
|     - SKIN_GANG_AZTECA                                                  |
|     - SKIN_GANG_VAGO                                                    |
|     - SKIN_GANG_DANANG                                                  |
|     - SKIN_GANG_RIFA                                                    |
|     - SKIN_GANG_TRIAD                                                   |
|     - SKIN_GANG_BIKER                                                   |
|     - SKIN_GANG_RUSSIAN                                                 |
|     - SKIN_GANG_ITALIAN                                                 |
|                                                                         |
|     - SKIN_SERVICE_NONE                                                 |
|     - SKIN_SERVICE_LAW                                                  |
|     - SKIN_SERVICE_POLICE                                               |
|     - SKIN_SERVICE_MIB                                                  |
|     - SKIN_SERVICE_SHERIFF                                              |
|     - SKIN_SERVICE_SWAT                                                 |
|     - SKIN_SERVICE_FBI                                                  |
|     - SKIN_SERVICE_ARMY                                                 |
|     - SKIN_SERVICE_FIRE                                                 |
|     - SKIN_SERVICE_MEDIC                                                |
|                                                                         |
|     - SKIN_TYPE_OTHER                                                   |
|     - SKIN_TYPE_BEACH                                                   |
|     - SKIN_TYPE_FARMER                                                  |
|     - SKIN_TYPE_WHORE                                                   |
|     - SKIN_TYPE_SPORT                                                   |
|     - SKIN_TYPE_HOMELESS                                                |
|     - SKIN_TYPE_DEALER                                                  |
|     - SKIN_TYPE_FOOD                                                    |
|     - SKIN_TYPE_SECURITY                                                |
|     - SKIN_TYPE_CONSTRUCTION                                            |
|     - SKIN_TYPE_LAW                                                     |
|     - SKIN_TYPE_MEDIC                                                   |
|     - SKIN_TYPE_FIRE                                                    |
|     - SKIN_TYPE_GANG                                                    |
|                                                                         |
|     - SKIN_GROUP_PLAYER                                                 |
|     - SKIN_GROUP_COP                                                    |
|     - SKIN_GROUP_MEDIC                                                  |
|     - SKIN_GROUP_FIREMAN                                                |
|     - SKIN_GROUP_GANG                                                   |
|     - SKIN_GROUP_STREET_GUY                                             |
|     - SKIN_GROUP_SUIT_GUY                                               |
|     - SKIN_GROUP_SENSIBLE_GUY                                           |
|     - SKIN_GROUP_GEEK_GUY                                               |
|     - SKIN_GROUP_OLD_GUY                                                |
|     - SKIN_GROUP_TOUGH_GUY                                              |
|     - SKIN_GROUP_STREET_GIRL                                            |
|     - SKIN_GROUP_SUIT_GIRL                                              |
|     - SKIN_GROUP_SENSIBLE_GIRL                                          |
|     - SKIN_GROUP_GEEK_GIRL                                              |
|     - SKIN_GROUP_OLD_GIRL                                               |
|     - SKIN_GROUP_TOUGH_GIRL                                             |
|     - SKIN_GROUP_TRAMP_MALE                                             |
|     - SKIN_GROUP_TRAMP_FEMALE                                           |
|     - SKIN_GROUP_TOURIST                                                |
|     - SKIN_GROUP_PROSTITUTE                                             |
|     - SKIN_GROUP_CRIMINAL                                               |
|     - SKIN_GROUP_BUSKER                                                 |
|     - SKIN_GROUP_TAXI_DRIVER                                             |
|     - SKIN_GROUP_PSYCHO                                                 |
|     - SKIN_GROUP_STEWARD                                                |
|     - SKIN_GROUP_SPORTSFAN                                              |
|     - SKIN_GROUP_SHOPPER                                                |
|     - SKIN_GROUP_OLDSHOPPER                                             |
|     - SKIN_GROUP_BEACH_GUY                                              |
|     - SKIN_GROUP_BEACH_GIRL                                             |
|     - SKIN_GROUP_SKATER                                                 |
|     - SKIN_GROUP_MISSION                                                |
|     - SKIN_GROUP_COWARD                                                 |
|                                                                         |
|     - SKIN_FOF_WEAK                                                     |
|     - SKIN_FOF_NORMAL                                                   |
|     - SKIN_FOF_TOUGH                                                    |
|                                                                         |
|     - SKIN_ANIM_BUSY_WOMAN                                              |
|     - SKIN_ANIM_FAT_MAN                                                 |
|     - SKIN_ANIM_GANG                                                    |
|     - SKIN_ANIM_JOGGER                                                  |
|     - SKIN_ANIM_JOG_WOMAN                                               |
|     - SKIN_ANIM_MAN                                                     |
|     - SKIN_ANIM_OLD_FAT_WOMAN                                           |
|     - SKIN_ANIM_OLD_MAN                                                 |
|     - SKIN_ANIM_OLD_WOMAN                                               |
|     - SKIN_ANIM_PLAYER                                                  |
|     - SKIN_ANIM_PROSTITUTE                                              |
|     - SKIN_ANIM_SEXY_WOMAN                                              |
|     - SKIN_ANIM_SKATER                                                  |
|     - SKIN_ANIM_SWAT                                                    |
|     - SKIN_ANIM_WOMAN                                                   |
| _______________________________________________________________________ |
\*                                                                       */

#include <a_samp>

#define IsValidSkin(%0) \
    (%0 != 74 && (0 <= %0 <= 311))

#define SKIN_FLAG_GENDER         (0b00000000000000000000000000000001)
#define SKIN_GENDER_FEMALE       (0b00000000000000000000000000000000)
#define SKIN_GENDER_MALE         (0b00000000000000000000000000000001)

#define SKIN_FLAG_RACE           (0b00000000000000000000000000000110)
#define SKIN_RACE_WHITE          (0b00000000000000000000000000000000)
#define SKIN_RACE_BLACK          (0b00000000000000000000000000000010)
#define SKIN_RACE_ASIAN          (0b00000000000000000000000000000100)
#define SKIN_RACE_LATIN          (0b00000000000000000000000000000110)

#define SKIN_FLAG_GANG           (0b00000000000000000000000001111000)
#define SKIN_GANG_NONE           (0b00000000000000000000000000000000)
#define SKIN_GANG_GROVE          (0b00000000000000000000000000001000)
#define SKIN_GANG_BALLA          (0b00000000000000000000000000010000)
#define SKIN_GANG_AZTECA         (0b00000000000000000000000000011000)
#define SKIN_GANG_VAGO           (0b00000000000000000000000000100000)
#define SKIN_GANG_DANANG         (0b00000000000000000000000000101000)
#define SKIN_GANG_RIFA           (0b00000000000000000000000000110000)
#define SKIN_GANG_TRIAD          (0b00000000000000000000000000111000)
#define SKIN_GANG_BIKER          (0b00000000000000000000000001000000)
#define SKIN_GANG_RUSSIAN        (0b00000000000000000000000001001000)
#define SKIN_GANG_ITALIAN        (0b00000000000000000000000001010000)

#define SKIN_FLAG_SERVICE        (0b00000000000000000000111110000000)
#define SKIN_SERVICE_NONE        (0b00000000000000000000000000000000)
#define SKIN_SERVICE_LAW         (0b00000000000000000000001110000000)
#define SKIN_SERVICE_POLICE      (0b00000000000000000000000010000000)
#define SKIN_SERVICE_MIB         (0b00000000000000000000000100000000)
#define SKIN_SERVICE_SHERIFF     (0b00000000000000000000000110000000)
#define SKIN_SERVICE_SWAT        (0b00000000000000000000001000000000)
#define SKIN_SERVICE_FBI         (0b00000000000000000000001010000000)
#define SKIN_SERVICE_ARMY        (0b00000000000000000000001110000000)
#define SKIN_SERVICE_FIRE        (0b00000000000000000000010000000000)
#define SKIN_SERVICE_MEDIC       (0b00000000000000000000100000000000)

#define SKIN_FLAG_TYPE           (0b00000000000000001111111111111000)
#define SKIN_TYPE_OTHER          (0b00000000000000000000000000000000)
#define SKIN_TYPE_BEACH          (0b00000000000000000001000000000000)
#define SKIN_TYPE_FARMER         (0b00000000000000000010000000000000)
#define SKIN_TYPE_WHORE          (0b00000000000000000011000000000000)
#define SKIN_TYPE_SPORT          (0b00000000000000000100000000000000)
#define SKIN_TYPE_HOMELESS       (0b00000000000000000101000000000000)
#define SKIN_TYPE_DEALER         (0b00000000000000000110000000000000)
#define SKIN_TYPE_FOOD           (0b00000000000000000111000000000000)
#define SKIN_TYPE_SECURITY       (0b00000000000000001000000000000000)
#define SKIN_TYPE_CONSTRUCTION   (0b00000000000000001001000000000000)

#define SKIN_TYPE_LAW            (SKIN_SERVICE_LAW)
#define SKIN_TYPE_MEDIC          (SKIN_SERVICE_MEDIC)
#define SKIN_TYPE_FIRE           (SKIN_SERVICE_FIRE)
#define SKIN_TYPE_GANG           (SKIN_FLAG_GANG)

#define SKIN_GROUP_PLAYER        ( 0)
#define SKIN_GROUP_COP           ( 1)
#define SKIN_GROUP_MEDIC         ( 2)
#define SKIN_GROUP_FIREMAN       ( 3)
#define SKIN_GROUP_GANG          ( 4)
#define SKIN_GROUP_STREET_GUY    ( 5)
#define SKIN_GROUP_SUIT_GUY      ( 6)
#define SKIN_GROUP_SENSIBLE_GUY  ( 7)
#define SKIN_GROUP_GEEK_GUY      ( 8)
#define SKIN_GROUP_OLD_GUY       ( 9)
#define SKIN_GROUP_TOUGH_GUY     (10)
#define SKIN_GROUP_STREET_GIRL   (11)
#define SKIN_GROUP_SUIT_GIRL     (12)
#define SKIN_GROUP_SENSIBLE_GIRL (13)
#define SKIN_GROUP_GEEK_GIRL     (14)
#define SKIN_GROUP_OLD_GIRL      (15)
#define SKIN_GROUP_TOUGH_GIRL    (16)
#define SKIN_GROUP_TRAMP_MALE    (17)
#define SKIN_GROUP_TRAMP_FEMALE  (18)
#define SKIN_GROUP_TOURIST       (19)
#define SKIN_GROUP_PROSTITUTE    (20)
#define SKIN_GROUP_CRIMINAL      (21)
#define SKIN_GROUP_BUSKER        (22)
#define SKIN_GROUP_TAXI_DRIVER   (23)
#define SKIN_GROUP_PSYCHO        (24)
#define SKIN_GROUP_STEWARD       (25)
#define SKIN_GROUP_SPORTS_FAN    (26)
#define SKIN_GROUP_SHOPPER       (27)
#define SKIN_GROUP_OLD_SHOPPER   (28)
#define SKIN_GROUP_BEACH_GUY     (29)
#define SKIN_GROUP_BEACH_GIRL    (30)
#define SKIN_GROUP_SKATER        (31)
#define SKIN_GROUP_MISSION       (32)
#define SKIN_GROUP_COWARD        (33)

#define SKIN_FOF_WEAK            (1)
#define SKIN_FOF_NORMAL          (2)
#define SKIN_FOF_TOUGH           (3)

#define SKIN_ANIM_BUSY_WOMAN     ( 0)
#define SKIN_ANIM_FAT_MAN        ( 1)
#define SKIN_ANIM_GANG           ( 2)
#define SKIN_ANIM_JOGGER         ( 3)
#define SKIN_ANIM_JOG_WOMAN      ( 4)
#define SKIN_ANIM_MAN            ( 5)
#define SKIN_ANIM_OLD_FAT_WOMAN  ( 6)
#define SKIN_ANIM_OLD_MAN        ( 7)
#define SKIN_ANIM_OLD_WOMAN      ( 8)
#define SKIN_ANIM_PLAYER         ( 9)
#define SKIN_ANIM_PROSTITUTE     (10)
#define SKIN_ANIM_SEXY_WOMAN     (11)
#define SKIN_ANIM_SKATER         (12)
#define SKIN_ANIM_SWAT           (13)
#define SKIN_ANIM_WOMAN          (14)

static const s_GangNames[][18 char] = {
    !"Grove Street",             // SKIN_GANG_GROVE
    !"Ballas",                   // SKIN_GANG_BALLA
    !"Los Aztecas",              // SKIN_GANG_AZTECA
    !"Los Santos Vagos",         // SKIN_GANG_VAGO
    !"Da Nang Boys",             // SKIN_GANG_DANANG
    !"San Fierro Rifa",          // SKIN_GANG_RIFA
    !"Triads",                   // SKIN_GANG_TRIAD
    !"Bikers",                   // SKIN_GANG_BIKER
    !"The Russian Mafia",        // SKIN_GANG_RUSSIAN
    !"The Italian Mafia"         // SKIN_GANG_ITALIAN
};

static const s_ServiceNames[][13 char] = {
    !"Policeman",                // SKIN_SERVICE_POLICE
    !"M.I.B.",                   // SKIN_SERVICE_MIB
    !"Sheriff",                  // SKIN_SERVICE_SHERIFF
    !"S.W.A.T.",                 // SKIN_SERVICE_SWAT
    !"F.B.I. agent",             // SKIN_SERVICE_FBI
    !"Army",                     // SKIN_SERVICE_ARMY
    !"Fireman",                  // SKIN_SERVICE_FIRE
    !"Paramedic"                 // SKIN_SERVICE_MEDIC
};

static const s_AnimGroupNames[][14 char] = {
    !"Busy Woman",               // SKIN_ANIM_BUSY_WOMAN   
    !"Fat Man",                  // SKIN_ANIM_FAT_MAN      
    !"Gang",                     // SKIN_ANIM_GANG         
    !"Jogger",                   // SKIN_ANIM_JOGGER       
    !"Jogger",                   // SKIN_ANIM_JOG_WOMAN    
    !"Man",                      // SKIN_ANIM_MAN          
    !"Old Fat Woman",            // SKIN_ANIM_OLD_FAT_WOMAN
    !"Old Man",                  // SKIN_ANIM_OLD_MAN      
    !"Old Woman",                // SKIN_ANIM_OLD_WOMAN    
    !"Player",                   // SKIN_ANIM_PLAYER       
    !"Prostitute",               // SKIN_ANIM_PROSTITUTE   
    !"Sexy Woman",               // SKIN_ANIM_SEXY_WOMAN   
    !"Skater",                   // SKIN_ANIM_SKATER       
    !"S.W.A.T.",                 // SKIN_ANIM_SWAT         
    !"Woman"                     // SKIN_ANIM_WOMAN        
};

enum e_PEDGRP_INFO {
    e_GRP_NAME[14 char],
    e_FEAR,                      //Fear                     (0-100) 100 = Scared of everything
    e_TEMPER,                    //Temper                   (0-100) 100 = Bad Tempered
    e_LAWFUL,                    //Lawfullness              (0-100) 100 = Boy Scout
    e_APPEAL,                    //Sexiness                 (0-100)
    Float:e_STRENGTH,            //Attack strength          (float multiplier to attack damages)
    Float:e_DEFENCE,             //Defend weakness          (float multiplier to received damages)
    e_FOF                        //Default Decision Maker   (FOF = Fight or Flight) (0: group member, 1:cop, 2:rand_norm 3:rand_tough 4:rand_weak)
}
static const pedGroups[][e_PEDGRP_INFO] = {
    {!"Player"       , 50 , 50 , 50 , 50 , 3.0, 0.4, SKIN_FOF_NORMAL},
    {!"Cop"          , 10 , 30 , 100, 50 , 1.0, 1.0, SKIN_FOF_TOUGH}, // FOF is actually "cop", tough for simplification
    {!"Medic"        , 70 , 30 , 60 , 40 , 0.8, 1.4, SKIN_FOF_NORMAL},
    {!"Fireman"      , 10 , 20 , 60 , 80 , 1.2, 0.8, SKIN_FOF_TOUGH}, // FOF is actually "fireman", tough for simplification
    {!"Gang"         , 20 , 65 , 10 , 40 , 1.0, 1.0, SKIN_FOF_TOUGH},
    {!"Street Guy"   , 45 , 30 , 30 , 60 , 1.0, 1.0, SKIN_FOF_NORMAL},
    {!"Suit Guy"     , 35 , 60 , 60 , 30 , 0.8, 1.2, SKIN_FOF_NORMAL},
    {!"Sensible Guy" , 65 , 30 , 70 , 20 , 0.7, 1.1, SKIN_FOF_WEAK},
    {!"Geek Guy"     , 56 , 10 , 40 , 5  , 0.5, 1.7, SKIN_FOF_WEAK},
    {!"Old Guy"      , 40 , 10 , 40 , 5  , 0.4, 2.5, SKIN_FOF_NORMAL},
    {!"Tough Guy"    , 30 , 70 , 50 , 60 , 1.1, 1.5, SKIN_FOF_TOUGH},
    {!"Street Girl"  , 45 , 30 , 30 , 60 , 0.9, 1.0, SKIN_FOF_NORMAL},
    {!"Suit Girl"    , 30 , 60 , 60 , 30 , 0.6, 1.6, SKIN_FOF_NORMAL},
    {!"Sensible Girl", 65 , 30 , 70 , 20 , 0.5, 1.1, SKIN_FOF_WEAK},
    {!"Geek Girl"    , 80 , 10 , 40 , 5  , 0.4, 1.9, SKIN_FOF_WEAK},
    {!"Old Girl"     , 80 , 10 , 40 , 5  , 0.3, 3.0, SKIN_FOF_NORMAL},
    {!"Tough Girl"   , 30 , 70 , 50 , 60 , 1.1, 1.5, SKIN_FOF_TOUGH},
    {!"Male Tramp"   , 60 , 50 , 20 , 10 , 0.9, 1.6, SKIN_FOF_TOUGH},
    {!"Female Tramp" , 30 , 30 , 20 , 10 , 0.9, 1.6, SKIN_FOF_TOUGH},
    {!"Tourist"      , 100, 20 , 70 , 30 , 0.8, 1.8, SKIN_FOF_NORMAL},
    {!"Prostitute"   , 40 , 20 , 40 , 100, 0.7, 1.0, SKIN_FOF_TOUGH},
    {!"Criminal"     , 30 , 55 , 10 , 60 , 1.2, 1.3, SKIN_FOF_TOUGH},
    {!"Busker"       , 49 , 20 , 40 , 90 , 1.0, 1.0, SKIN_FOF_TOUGH},
    {!"Taxi Driver"  , 16 , 80 , 30 , 30 , 0.8, 1.5, SKIN_FOF_TOUGH},
    {!"Psycho"       , 0  , 100, 0  , 50 , 1.0, 1.0, SKIN_FOF_TOUGH},
    {!"Steward"      , 40 , 30 , 70 , 20 , 0.7, 1.1, SKIN_FOF_WEAK},
    {!"Sportsfan"    , 40 , 50 , 70 , 20 , 0.7, 1.1, SKIN_FOF_TOUGH},
    {!"Shopper"      , 30 , 75 , 50 , 40 , 1.5, 1.5, SKIN_FOF_WEAK},
    {!"Old Shopper"  , 45 , 65 , 70 , 20 , 1.0, 2.5, SKIN_FOF_WEAK},
    {!"Beach Guy"    , 52 , 60 , 60 , 30 , 0.8, 1.2, SKIN_FOF_NORMAL},
    {!"Beach Girl"   , 59 , 30 , 30 , 60 , 0.9, 1.0, SKIN_FOF_NORMAL},
    {!"Skater"       , 40 , 40 , 60 , 80 , 0.7, 1.0, SKIN_FOF_WEAK},
    {!"Special"      , 50 , 50 , 50 , 50 , 1.0, 1.0, SKIN_FOF_TOUGH},
    {!"Coward"       , 65 , 30 , 70 , 20 , 0.7, 1.1, SKIN_FOF_WEAK}
};

enum e_SKIN_INFO {
    e_SKIN_MODEL_NAME[8 char],
    e_SKIN_NAME[52 char],
    e_SKIN_PEDGRP,
    e_SKIN_ANIMGRP,
    e_SKIN_FLAGS
}
static const skinInfoList[][e_SKIN_INFO] = {
    {!"cj"     , !"Carl \"CJ\" Johnson (Main Character)"               , SKIN_GROUP_PLAYER      , SKIN_ANIM_PLAYER       , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"truth"  , !"The Truth"                                          , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"maccer" , !"Maccer"                                             , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"andre"  , !"Andre"                                              , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bbthin" , !"Barry \"Big Bear\" Thorne [Thin]"                   , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bb"     , !"Barry \"Big Bear\" Thorne [Big]"                    , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"emmet"  , !"Emmet"                                              , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"male01" , !"Taxi Driver/Train Driver"                           , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"janitor", !"Janitor"                                            , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"bfori"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"bfost"  , !"Old Woman"                                          , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_OLD_FAT_WOMAN, SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"vbfycrp", !"Casino croupier"                                    , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"bfyri"  , !"Rich Woman"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"bfyst"  , !"Street Girl"                                        , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"bmori"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmost"  , !"Mr.Whittaker (RS Haul Owner)"                       , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmyap"  , !"Airport Ground Worker"                              , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_CONSTRUCTION},
    {!"bmybu"  , !"Businessman"                                        , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmybe"  , !"Beach Visitor"                                      , SKIN_GROUP_BEACH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_BEACH},
    {!"bmydj"  , !"DJ"                                                 , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmyri"  , !"Rich Guy (Madd Dogg's Manager)"                     , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmycr"  , !"Normal Ped"                                         , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmyst"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wmybmx" , !"BMXer"                                              , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"wbdyg1" , !"Madd Dogg Bodyguard"                                , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wbdyg2" , !"Madd Dogg Bodyguard"                                , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wmybp"  , !"Backpacker"                                         , SKIN_GROUP_GEEK_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"wmycon" , !"Construction Worker"                                , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_CONSTRUCTION},
    {!"bmydrug", !"Drug Dealer"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wmydrug", !"Drug Dealer"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"hmydrug", !"Drug Dealer"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"dwfolc" , !"Farm-Town inhabitant"                               , SKIN_GROUP_OLD_GIRL    , SKIN_ANIM_OLD_FAT_WOMAN, SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dwmolc1", !"Farm-Town inhabitant"                               , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dwmolc2", !"Farm-Town inhabitant"                               , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dwmylc1", !"Farm-Town inhabitant"                               , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"hmogar" , !"Gardener"                                           , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"wmygol1", !"Golfer"                                             , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_TYPE_SPORT},
    {!"wmygol2", !"Golfer"                                             , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"hfori"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE   | SKIN_RACE_WHITE},
    {!"hfost"  , !"Normal Ped"                                         , SKIN_GROUP_OLD_GIRL    , SKIN_ANIM_OLD_FAT_WOMAN, SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"hfyri"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"hfyst"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_LATIN},
    {!"jethro" , !"Jethro"                                             , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"hmori"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"hmost"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"hmybe"  , !"Beach Visitor"                                      , SKIN_GROUP_BEACH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"hmyri"  , !"Normal Ped"                                         , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"hmycr"  , !"Normal Ped"                                         , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"hmyst"  , !"Normal Ped"                                         , SKIN_GROUP_TOURIST     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"omokung", !"Snakehead (Da Nang)"                                , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"wmymech", !"Mechanic"                                           , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bmymoun", !"Mountain Biker"                                     , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_SPORT},
    {!"wmymoun", !"Mountain Biker"                                     , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"ofori"  , !"Unknown"                                            , SKIN_GROUP_OLD_GIRL    , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"ofost"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"ofyri"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"ofyst"  , !"Normal Ped"                                         , SKIN_GROUP_TOURIST     , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"omori"  , !"Oriental Ped"                                       , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"omost"  , !"Oriental Ped"                                       , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"omyri"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"omyst"  , !"Normal Ped"                                         , SKIN_GROUP_TOURIST     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmyplt" , !"Pilot"                                              , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmopj"  , !"Colonel Fuhrberger"                                 , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bfypro" , !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"hfypro" , !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"kendl"  , !"Kendl Johnson"                                      , SKIN_GROUP_MISSION     , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"bmypol1", !"Pool Player"                                        , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmypol2", !"Pool Player"                                        , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wmoprea", !"Priest/Preacher"                                    , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"sbfyst" , !"Normal Ped"                                         , SKIN_GROUP_TOURIST     , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"wmosci" , !"Scientist"                                          , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmysgrd", !"Security Guard"                                     , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SECURITY},
    {!"swmyhp1", !"Hippy"                                              , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"swmyhp2", !"Hippy"                                              , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"-"      , !"-"                                                  , 0                     , 0                      , 0}, // Nothing here!
    {!"swfopro", !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"wfystew", !"Stewardess"                                         , SKIN_GROUP_GEEK_GIRL   , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"swmotr1", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"wmotr1" , !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"bmotr1" , !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"vbmybox", !"Boxer"                                              , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_SPORT},
    {!"vwmybox", !"Boxer"                                              , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"vhmyelv", !"Black Elvis"                                        , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vbmyelv", !"White Elvis"                                        , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vimyelv", !"Blue Elvis"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vwfypro", !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"ryder3" , !"Ryder with robbery mask"                            , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vwfyst1", !"Stripper"                                           , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"wfori"  , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wfost"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_OLD_FAT_WOMAN, SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wfyjg"  , !"Jogger"                                             , SKIN_GROUP_COWARD      , SKIN_ANIM_JOG_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"wfyri"  , !"Rich Woman"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wfyro"  , !"Rollerskater"                                       , SKIN_GROUP_SKATER      , SKIN_ANIM_SKATER       , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"wfyst"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wmori"  , !"Normal Ped"                                         , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmost"  , !"Normal Ped, Works at or owns Dillimore Gas Station" , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmyjg"  , !"Jogger"                                             , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_JOGGER       , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"wmylg"  , !"Lifeguard"                                          , SKIN_GROUP_GEEK_GUY    , SKIN_ANIM_JOGGER       , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"wmyri"  , !"Normal Ped"                                         , SKIN_GROUP_SHOPPER     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"wmyro"  , !"Rollerskater"                                       , SKIN_GROUP_SKATER      , SKIN_ANIM_SKATER       , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"wmycr"  , !"Biker"                                              , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmyst"  , !"Normal Ped"                                         , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"ballas1", !"Balla"                                              , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_GANG_BALLA},
    {!"ballas2", !"Balla"                                              , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_GANG_BALLA},
    {!"ballas3", !"Balla"                                              , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_GANG_BALLA},
    {!"fam1"   , !"Grove Street Families"                              , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_GANG_GROVE},
    {!"fam2"   , !"Grove Street Families"                              , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_GANG_GROVE},
    {!"fam3"   , !"Grove Street Families"                              , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_GANG_GROVE},
    {!"lsv1"   , !"Los Santos Vagos"                                   , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_VAGO},
    {!"lsv2"   , !"Los Santos Vagos"                                   , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_VAGO},
    {!"lsv3"   , !"Los Santos Vagos"                                   , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_VAGO},
    {!"maffa"  , !"The Russian Mafia"                                  , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_RUSSIAN},
    {!"maffb"  , !"The Russian Mafia"                                  , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_RUSSIAN},
    {!"mafboss", !"The Russian Mafia"                                  , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_RUSSIAN},
    {!"vla1"   , !"Varios Los Aztecas"                                 , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_AZTECA},
    {!"vla2"   , !"Varios Los Aztecas"                                 , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_AZTECA},
    {!"vla3"   , !"Varios Los Aztecas"                                 , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_AZTECA},
    {!"triada" , !"Triad"                                              , SKIN_GROUP_GANG        , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN | SKIN_GANG_TRIAD},
    {!"triadb" , !"Triad"                                              , SKIN_GROUP_GANG        , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN | SKIN_GANG_TRIAD},
    {!"sindaco", !"Johhny Sindacco"                                    , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"triboss", !"Triad Boss"                                         , SKIN_GROUP_GANG        , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN | SKIN_GANG_TRIAD},
    {!"dnb1"   , !"Da Nang Boy"                                        , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN | SKIN_GANG_DANANG},
    {!"dnb2"   , !"Da Nang Boy"                                        , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN | SKIN_GANG_DANANG},
    {!"dnb3"   , !"Da Nang Boy"                                        , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN | SKIN_GANG_DANANG},
    {!"vmaff1" , !"The Mafia"                                          , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_ITALIAN},
    {!"vmaff2" , !"The Mafia"                                          , SKIN_GROUP_GANG        , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_ITALIAN},
    {!"vmaff3" , !"The Mafia"                                          , SKIN_GROUP_GANG        , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_ITALIAN},
    {!"vmaff4" , !"The Mafia"                                          , SKIN_GROUP_GANG        , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_ITALIAN},
    {!"dnmylc" , !"Farm Inhabitant"                                    , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dnfolc1", !"Farm Inhabitant"                                    , SKIN_GROUP_COWARD      , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dnfolc2", !"Farm Inhabitant"                                    , SKIN_GROUP_COWARD      , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dnfylc" , !"Farm Inhabitant"                                    , SKIN_GROUP_COWARD      , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dnmolc1", !"Farm Inhabitant"                                    , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dnmolc2", !"Farm Inhabitant"                                    , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"sbmotr2", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_HOMELESS},
    {!"swmotr2", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"sbmytr3", !"Normal Ped"                                         , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"swmotr3", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"wfybe"  , !"Beach Visitor"                                      , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"bfybe"  , !"Beach Visitor"                                      , SKIN_GROUP_BEACH_GIRL  , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_BEACH},
    {!"hfybe"  , !"Beach Visitor"                                      , SKIN_GROUP_BEACH_GIRL  , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"sofybu" , !"Businesswoman"                                      , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_BUSY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"sbmyst" , !"Taxi Driver"                                        , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"sbmycr" , !"Crack Maker"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bmycg"  , !"Crack Maker"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wfycrk" , !"Crack Maker"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"hmycm"  , !"Crack Maker"                                        , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"wmybu"  , !"Businessman"                                        , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bfybu"  , !"Businesswoman"                                      , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_BUSY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"smokev" , !"Big Smoke Armored"                                  , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wfybu"  , !"Businesswoman"                                      , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_BUSY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"dwfylc1", !"Normal Ped"                                         , SKIN_GROUP_TOUGH_GIRL  , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wfypro" , !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"wmyconb", !"Construction Worker"                                , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_CONSTRUCTION},
    {!"wmybe"  , !"Beach Visitor"                                      , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"wmypizz", !"Well Stacked Pizza Worker"                          , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FOOD},
    {!"bmobar" , !"Barber"                                             , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"cwfyhb" , !"Hillbilly"                                          , SKIN_GROUP_TOUGH_GIRL  , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwmofr" , !"Farmer"                                             , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwmohb1", !"Hillbilly"                                          , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwmohb2", !"Hillbilly"                                          , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwmyfr" , !"Farmer"                                             , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwmyhb1", !"Hillbilly"                                          , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"bmyboun", !"Black Bouncer"                                      , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_SECURITY},
    {!"wmyboun", !"White Bouncer"                                      , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SECURITY},
    {!"wmomib" , !"White MIB agent"                                    , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_MIB},
    {!"bmymib" , !"Black MIB agent"                                    , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_SERVICE_MIB},
    {!"wmybell", !"Cluckin' Bell Worker"                               , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FOOD},
    {!"bmochil", !"Hotdog/Chilli Dog Vendor"                           , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_FOOD},
    {!"sofyri" , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_ASIAN},
    {!"somyst" , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"vwmybjd", !"Blackjack Dealer"                                   , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"vwfycrp", !"Casino croupier"                                    , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_BUSY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"sfr1"   , !"San Fierro Rifa"                                    , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_RIFA},
    {!"sfr2"   , !"San Fierro Rifa"                                    , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_RIFA},
    {!"sfr3"   , !"San Fierro Rifa"                                    , SKIN_GROUP_GANG        , SKIN_ANIM_GANG         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_GANG_RIFA},
    {!"bmybar" , !"Barber"                                             , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wmybar" , !"Barber"                                             , SKIN_GROUP_SENSIBLE_GUY, SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wfysex" , !"Whore"                                              , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"wmyammo", !"Ammunation Salesman"                                , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bmytatt", !"Tattoo Artist"                                      , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vwmycr" , !"Punk"                                               , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"vbmocd" , !"Cab Driver"                                         , SKIN_GROUP_TAXI_DRIVER  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vbmycr" , !"Normal Ped"                                         , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vhmycr" , !"Normal Ped"                                         , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"sbmyri" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"somyri" , !"Normal Ped"                                         , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"somybu" , !"Businessman"                                        , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"swmyst" , !"Normal Ped"                                         , SKIN_GROUP_TOURIST     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmyva"  , !"Valet"                                              , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"copgrl3", !"Barbara Schternvart"                                , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_BUSY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"gungrl3", !"Helena Wankstein"                                   , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"mecgrl3", !"Michelle Cannes"                                    , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"nurgrl3", !"Katie Zhan"                                         , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"crogrl3", !"Millie Perkins"                                     , SKIN_GROUP_SUIT_GIRL   , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"gangrl3", !"Denise Robinson"                                    , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"cwfofr" , !"Farm-Town inhabitant"                               , SKIN_GROUP_COWARD      , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwfohb" , !"Hillbilly"                                          , SKIN_GROUP_OLD_GIRL    , SKIN_ANIM_OLD_WOMAN    , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwfyfr1", !"Farm-Town inhabitant"                               , SKIN_GROUP_TOUGH_GIRL  , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwfyfr2", !"Farm-Town inhabitant"                               , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"cwmyhb2", !"Hillbilly"                                          , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dwfylc2", !"Farmer"                                             , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"dwmylc2", !"Farmer"                                             , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FARMER},
    {!"omykara", !"Karate Teacher"                                     , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wmykara", !"Karate Teacher"                                     , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wfyburg", !"Burger Shot Cashier"                                , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_FOOD},
    {!"vwmycd" , !"Cab Driver"                                         , SKIN_GROUP_TAXI_DRIVER  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"vhfypro", !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"suzie"  , !"Su Xi Mu (Suzie)"                                   , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"omonood", !"Oriental Noodle stand vendor"                       , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_FOOD},
    {!"omoboat", !"Oriental Boating School Instructor"                 , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_OLD_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"wfyclot", !"Clothes shop staff"                                 , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_SECURITY},
    {!"vwmotr1", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"vwmotr2", !"Weird old man"                                      , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"vwfywai", !"Waitress (Maria Latore)"                            , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"sbfori" , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"swfyri" , !"Normal Ped"                                         , SKIN_GROUP_SHOPPER     , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wmyclot", !"Clothes shop staff"                                 , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SECURITY},
    {!"sbfost" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"sbfyri" , !"Rich Woman"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"sbmocd" , !"Cab Driver"                                         , SKIN_GROUP_TAXI_DRIVER  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"sbmori" , !"Normal Ped"                                         , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"sbmost" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"shmycr" , !"Normal Ped"                                         , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"sofori" , !"Normal Ped"                                         , SKIN_GROUP_OLD_GIRL    , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_ASIAN},
    {!"sofost" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_ASIAN},
    {!"sofyst" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"somobu" , !"Oriental Businessman"                               , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"somori" , !"Oriental Ped"                                       , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"somost" , !"Oriental Ped"                                       , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"swmotr5", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"swfori" , !"Normal Ped"                                         , SKIN_GROUP_COWARD      , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"swfost" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"swfyst" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"swmocd" , !"Cab Driver"                                         , SKIN_GROUP_TAXI_DRIVER  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"swmori" , !"Normal Ped"                                         , SKIN_GROUP_SUIT_GUY    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"swmost" , !"Normal Ped"                                         , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"shfypro", !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"sbfypro", !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"swmotr4", !"Homeless"                                           , SKIN_GROUP_TRAMP_MALE  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_HOMELESS},
    {!"swmyri" , !"The D.A"                                            , SKIN_GROUP_COWARD      , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"smyst"  , !"Afro-American"                                      , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"smyst2" , !"Mexican"                                            , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"sfypro" , !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"vbfyst2", !"Stripper"                                           , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"vbfypro", !"Prostitute"                                         , SKIN_GROUP_PROSTITUTE  , SKIN_ANIM_PROSTITUTE   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"vhfyst3", !"Stripper"                                           , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"bikera" , !"Biker"                                              , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_BIKER},
    {!"bikerb" , !"Biker"                                              , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_BIKER},
    {!"bmypimp", !"Pimp"                                               , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"swmycr" , !"Normal Ped"                                         , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wfylg"  , !"Lifeguard"                                          , SKIN_GROUP_BEACH_GIRL  , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_BEACH},
    {!"wmyva2" , !"Naked Valet"                                        , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bmosec" , !"Bus Driver"                                         , SKIN_GROUP_OLD_GUY     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"bikdrug", !"Biker Drug Dealer"                                  , SKIN_GROUP_CRIMINAL    , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_GANG_BIKER},
    {!"wmych"  , !"Chauffeur (Limo Driver)"                            , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"sbfystr", !"Stripper"                                           , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK | SKIN_TYPE_WHORE},
    {!"swfystr", !"Stripper"                                           , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE | SKIN_TYPE_WHORE},
    {!"heck1"  , !"Heckler"                                            , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"heck2"  , !"Heckler"                                            , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_TYPE_SPORT},
    {!"bmycon" , !"Construction Worker"                                , SKIN_GROUP_TOUGH_GUY   , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_TYPE_CONSTRUCTION},
    {!"wmycd1" , !"Cab driver"                                         , SKIN_GROUP_TAXI_DRIVER  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"bmocd"  , !"Cab driver"                                         , SKIN_GROUP_TAXI_DRIVER  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"vwfywa2", !"Normal Ped"                                         , SKIN_GROUP_STREET_GIRL , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_ASIAN},
    {!"wmoice" , !"Clown (Ice-cream Van Driver)"                       , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"tenpen" , !"Officer Frank Tenpenny (Corrupt Cop)"               , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"pulaski", !"Officer Eddie Pulaski (Corrupt Cop)"                , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"hern"   , !"Officer Jimmy Hernandez"                            , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"dwayne" , !"Dwaine/Dwayne"                                      , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"smoke"  , !"Melvin \"Big Smoke\" Harris (Mission)"              , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"sweet"  , !"Sean 'Sweet' Johnson"                               , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"ryder"  , !"Lance 'Ryder' Wilson"                               , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"forelli", !"Mafia Boss"                                         , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"tbone"  , !"T-Bone Mendez"                                      , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"laemt1" , !"Paramedic (Emergency Medical Technician)"           , SKIN_GROUP_MEDIC       , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_SERVICE_MEDIC},
    {!"lvemt1" , !"Paramedic (Emergency Medical Technician)"           , SKIN_GROUP_MEDIC       , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_LATIN | SKIN_SERVICE_MEDIC},
    {!"sfemt1" , !"Paramedic (Emergency Medical Technician)"           , SKIN_GROUP_MEDIC       , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_MEDIC},
    {!"lafd1"  , !"Firefighter"                                        , SKIN_GROUP_FIREMAN     , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_FIRE},
    {!"lvfd1"  , !"Firefighter"                                        , SKIN_GROUP_FIREMAN     , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_SERVICE_FIRE},
    {!"sffd1"  , !"Firefighter"                                        , SKIN_GROUP_FIREMAN     , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_FIRE},
    {!"lapd1"  , !"Los Santos Police Officer"                          , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_POLICE},
    {!"sfpd1"  , !"San Fierro Police Officer"                          , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_POLICE},
    {!"lvpd1"  , !"Las Venturas Police Officer"                        , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_POLICE},
    {!"csher"  , !"County Sheriff"                                     , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_SHERIFF},
    {!"lapdm1" , !"LSPD Motorbike Cop"                                 , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_BLACK | SKIN_SERVICE_POLICE},
    {!"swat"   , !"S.W.A.T Special Forces"                             , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_SWAT},
    {!"fbi"    , !"Federal Agent"                                      , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_FBI},
    {!"army"   , !"San Andreas Army"                                   , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_ARMY},
    {!"dsher"  , !"Desert Sheriff"                                     , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE | SKIN_SERVICE_SHERIFF},
    {!"zero"   , !"Zero"                                               , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"rose"   , !"Ken Rosenberg"                                      , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"paul"   , !"Kent Paul"                                          , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"cesar"  , !"Cesar Vialpando"                                    , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_LATIN},
    {!"ogloc"  , !"Jeffery \"OG Loc\" Martin/Cross"                    , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"wuzimu" , !"Wu Zi Mu (Woozie)"                                  , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_ASIAN},
    {!"torino" , !"Michael Toreno"                                     , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"jizzy"  , !"Jizzy B."                                           , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"maddogg", !"Madd Dogg"                                          , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_MALE   | SKIN_RACE_BLACK},
    {!"cat"    , !"Catalina"                                           , SKIN_GROUP_MISSION     , SKIN_ANIM_MAN          , SKIN_GENDER_FEMALE | SKIN_RACE_LATIN},
    {!"claude" , !"Claude Speed"                                       , SKIN_GROUP_MISSION     , SKIN_ANIM_FAT_MAN      , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"lapdna" , !"Los Santos Police Officer (Without gun holster)"    , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"sfpdna" , !"San Fierro Police Officer (Without gun holster)"    , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"lvpdna" , !"Las Venturas Police Officer (Without gun holster)"  , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"lapdpc" , !"Los Santos Police Officer (Without uniform)"        , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"lapdpd" , !"Los Santos Police Officer (Without uniform)"        , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"lvpdpc" , !"Las Venturas Police Officer (Without uniform)"      , SKIN_GROUP_STREET_GUY  , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"wfyclpd", !"Los Santos Police Officer"                          , SKIN_GROUP_COP         , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"vbfycpd", !"San Fierro Police Officer"                          , SKIN_GROUP_COP         , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_BLACK},
    {!"wfyclem", !"San Fierro Paramedic (Emergency Medical Technician)", SKIN_GROUP_MEDIC       , SKIN_ANIM_SEXY_WOMAN   , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"wfycllv", !"Las Venturas Police Officer"                        , SKIN_GROUP_COP         , SKIN_ANIM_WOMAN        , SKIN_GENDER_FEMALE | SKIN_RACE_WHITE},
    {!"csherna", !"Country Sheriff (Without hat)"                      , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE},
    {!"dsherna", !"Desert Sheriff (Without hat)"                       , SKIN_GROUP_COP         , SKIN_ANIM_SWAT         , SKIN_GENDER_MALE   | SKIN_RACE_WHITE}
};
 
stock GetSkinName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    strunpack(output, skinInfoList[skinid][e_SKIN_NAME], outlen);
    
    return 1;
}

stock GetSkinModelName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    strunpack(output, skinInfoList[skinid][e_SKIN_MODEL_NAME], outlen);
    
    return 1;
}

#define IsPlayerFemale !IsPlayerMale
#define IsPlayerMale(%0) (GetSkinGender(GetPlayerSkin(%0)) == SKIN_GENDER_MALE)
#define GetSkinSex GetSkinGender
stock GetSkinGender(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return (skinInfoList[skinid][e_SKIN_FLAGS] & SKIN_FLAG_GENDER);
}

stock GetSkinGenderName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    output[0] = '\0';
    strcat(output, GetSkinGender(skinid) ? ("male") : ("female"), outlen);
    
    return 1;
}

stock GetSkinRace(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return ((skinInfoList[skinid][e_SKIN_FLAGS] & SKIN_FLAG_RACE));
}

stock GetSkinRaceName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    output[0] = '\0';
    switch(GetSkinRace(skinid) >> 1) {
        case SKIN_RACE_WHITE:
            strcat(output, "caucasian", outlen);
        case SKIN_RACE_BLACK:
            strcat(output, "black", outlen);
        case SKIN_RACE_ASIAN:
            strcat(output, "asian", outlen);
        case SKIN_RACE_LATIN:
            strcat(output, "latino", outlen);
    }
    
    return 1;
}

stock GetSkinGang(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return ((skinInfoList[skinid][e_SKIN_FLAGS] & SKIN_FLAG_GANG));
}

stock GetSkinGangName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    strunpack(output, s_GangNames[GetSkinGang(skinid) >> 3], outlen);
    
    return 1;
}

stock GetSkinService(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return ((skinInfoList[skinid][e_SKIN_FLAGS] & SKIN_FLAG_SERVICE));
}

stock GetSkinServiceName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    strunpack(output, s_ServiceNames[GetSkinService(skinid) >> 7], outlen);
    
    return 1;
}

stock GetSkinType(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    new type = skinInfoList[skinid][e_SKIN_FLAGS] & SKIN_FLAG_TYPE;

    if(type & SKIN_SERVICE_LAW)
        type = SKIN_SERVICE_LAW;
    else if(type & SKIN_SERVICE_MEDIC)
        type = SKIN_SERVICE_MEDIC;
    else if(type & SKIN_SERVICE_FIRE)
        type = SKIN_SERVICE_FIRE;
    else if(type & SKIN_FLAG_GANG)
        type = SKIN_FLAG_GANG;

    return type;
}

stock GetSkinAnimGroup(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return skinInfoList[skinid][e_SKIN_ANIMGRP];
}

stock GetSkinAnimGroupName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    strunpack(output, s_AnimGroupNames[skinInfoList[skinid][e_SKIN_ANIMGRP]], outlen);
    
    return 1;
}

stock GetSkinGroup(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return skinInfoList[skinid][e_SKIN_PEDGRP];
}

stock GetSkinGroupName(skinid, output[], outlen = sizeof(output)) {
    if(!IsValidSkin(skinid))
        return 0;
    
    strunpack(output, pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_GRP_NAME], outlen);
    
    return 1;
}

stock GetSkinFear(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_FEAR];
}

stock GetSkinTemper(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_TEMPER];
}

stock GetSkinLawfullness(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_LAWFUL];
}

#define GetSkinSexAppeal GetSkinAppeal
stock GetSkinAppeal(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_APPEAL];
}

stock GetSkinFOF(skinid) {
    if(!IsValidSkin(skinid))
        return -1;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_FOF];
}

stock Float:GetSkinStrength(skinid) {
    if(!IsValidSkin(skinid))
        return -1.0;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_STRENGTH];
}

stock Float:GetSkinDefence(skinid) {
    if(!IsValidSkin(skinid))
        return -1.0;
    
    return pedGroups[skinInfoList[skinid][e_SKIN_PEDGRP]][e_DEFENCE];
}

#undef SKIN_FLAG_GENDER
#undef SKIN_FLAG_RACE
#undef SKIN_FLAG_GANG
#undef SKIN_FLAG_SERVICE
#undef SKIN_FLAG_TYPE