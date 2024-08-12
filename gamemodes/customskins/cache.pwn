
#define MAX_PLAYER_SKINS    3
#define MAX_CUSTOM_SKINS    150
enum E_CUSTOM_SKIN_DATA {
    E_CUSTOM_SKIN_CHARACTERID,
    E_CUSTOM_SKIN_BASEID,
    E_CUSTOM_SKIN_DFF[256],
    E_CUSTOM_SKIN_TXD[256],
    E_CUSTOM_SKIN_DIR[256], // folder where everything is saved
    E_CUSTOM_SKIN_SLOT,
    E_CUSTOM_SKIN_ID,
    E_CUSTOM_SKIN_ACTIVE
};
new CustomSkin[MAX_CUSTOM_SKINS][E_CUSTOM_SKIN_DATA];
new Iterator: CustomSkins<MAX_CUSTOM_SKINS>;

IsSkinCached(const directory[], const dff[], const txd[]) {
    // Untested. This function is supposed to check if a skin is already loaded, for live additions.
    foreach(new i: CustomSkins) {

        if(!strcmp(CustomSkin[i][E_CUSTOM_SKIN_DIR], directory, true)) {

            if(!strcmp(CustomSkin[i][E_CUSTOM_SKIN_DFF], sprintf("%s.dff", dff), true) && !strcmp(CustomSkin[i][E_CUSTOM_SKIN_TXD], sprintf("%s.txd", txd), true)) {
                return true;
            }
        }
    }

    return false;
}

AddNewPlayerSkin(characterid, baseid, slot, const dff[], const txd[], const directory[]) {


    if(IsSkinCached(directory, dff, txd)) {
        printf("[CUSTOM SKIN SKIPPED]: Skin %s.dff|%s.txd in %s is already cached.", dff, txd, directory);
        return false;
    }

    new index = Iter_Free(CustomSkins);
    if(index == -1) {
        //SendAdminMessage(sprintf("[SCRIPT ERROR]: The limit for player skins has been reached. Contact Hades.", COLOR_ERROR));
        return false;
    }

    new separator = PathSep();

    new newid = GetFreeCustomSkinID(); // the skin id the skin will use
    CustomSkin[index][E_CUSTOM_SKIN_CHARACTERID] = characterid;
    CustomSkin[index][E_CUSTOM_SKIN_BASEID] = baseid;

    format(CustomSkin[index][E_CUSTOM_SKIN_DFF], 256, "%s.dff", dff);
    format(CustomSkin[index][E_CUSTOM_SKIN_TXD], 256, "%s.txd", txd);
    format(CustomSkin[index][E_CUSTOM_SKIN_DIR], 256, "%s", directory);

    CustomSkin[index][E_CUSTOM_SKIN_SLOT] = slot;
    CustomSkin[index][E_CUSTOM_SKIN_ID] = newid;
    CustomSkin[index][E_CUSTOM_SKIN_ACTIVE] = true; // TODO: default false, this is later set to true when the owner connects. so we avoid a huge cache on the server start

    new ret = AddCharModel(baseid, newid, sprintf("%s%c%s", directory, separator, CustomSkin[index][E_CUSTOM_SKIN_DFF]), sprintf("%s%c%s", directory, separator, CustomSkin[index][E_CUSTOM_SKIN_TXD]));

    if(ret) {
        printf("[CUSTOM SKIN CACHED][%i] Character %i with base %i in slot %i: %s|%s", newid, characterid, baseid, slot, dff, txd);
        Iter_Add(CustomSkins, index);

        foreach(new playerid: Player) {
            if(CustomSkin[index][E_CUSTOM_SKIN_CHARACTERID] == Character[playerid][E_CHARACTER_ID]) {
                SendClientMessage(playerid, COLOR_ERROR, "Your custom skin has been added. Use a wardrobe (in a clothing store or your house) to put it on. Enter an interior to download it.");
                break;
            }
        }
    }
    else {
        printf("[CUSTOM SKIN ERROR] Failed to cache skin %s|%s.", dff, txd);
        index = -1;
    }

    return index;         
}

GetFreeCustomSkinID() {
    new start_index = 25000; // we start at index 25000 for player skins, we will reserve the 
    // previous indexes for the default/faction skins that aren't dynamic to avoid overlap
    new total_skins = Iter_Free(CustomSkins);
    return (start_index+total_skins);
}

IsCustomPlayerSkin(skinid) {

    foreach(new i: CustomSkins) {
        if(CustomSkin[i][E_CUSTOM_SKIN_ID] == skinid) {
            return true;
        }
    }

    return false;
}