new PlayerText: house_info_box[MAX_PLAYERS] = PlayerText: INVALID_TEXT_DRAW ; //  CROSS REFERENCED --- managed in property/func/gui.pwn

enum _:PROPERTY_ENTER_TYPES {
	PROPERTY_NEAR_ENTER,
	PROPERTY_NEAR_EXIT,
	PROPERTY_NEAR_ANYWHERE
}

#include "property/data/header.pwn"
#include "property/func/header.pwn"
#include "property/utils/header.pwn"