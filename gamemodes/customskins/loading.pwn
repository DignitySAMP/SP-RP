// The following is the temporary cache that will ensure new files get linked to avoid overlap.
// TODO: This should be integrated with the data in cache.pwn, but for now it's a separate cache to fix the problem. Optimizations are needed.


//* Caching container *//
#define MAX_SKIN_CACHE 256
enum _:E_SKIN_EXTENSIONS {
    E_SKIN_EXTENSION_DFF,
    E_SKIN_EXTENSION_TXD,
}
enum E_TEMP_SKIN_CACHE {
    E_SKIN_DIRECTORY[256],
    E_SKIN_FILENAME[256],
    E_SKIN_TYPE,
    E_SKIN_BASEID,
    E_SKIN_CHARID,
    bool:E_SKIN_ADDED,
}
new TempSkinCache[MAX_SKIN_CACHE][E_TEMP_SKIN_CACHE];
new Iterator: SkinCache<MAX_SKIN_CACHE>;

StoreFileInCache(type, baseid, charid, const dir[], const file[]) {

    new index = Iter_Free(SkinCache);
    if(index == -1) {
        printf("[CUSTOM SKIN ERROR]: Skin cache is full. Increase MAX_SKIN_CACHE.");
        return -1;
    }

    TempSkinCache[index][E_SKIN_TYPE] = type;
    TempSkinCache[index][E_SKIN_BASEID] = baseid;
    TempSkinCache[index][E_SKIN_CHARID] = charid;
    TempSkinCache[index][E_SKIN_ADDED] = false;

    format(TempSkinCache[index][E_SKIN_DIRECTORY],256, "%s", dir);
    format(TempSkinCache[index][E_SKIN_FILENAME], 256, "%s", file);

    Iter_Add(SkinCache, index);
    return index;
}


//* Loading functionality *//
static separator;
#include <YSI_Coding\y_hooks>

hook OnGameModeInit() {
    separator = PathSep(); // platform specific separator init

    lastSkinAddition = GetTickCount();
    LoadCustomSkins();
    return 1;
}

task OnCustomSkinReload[LIVE_SKIN_UPDATE_TIME]() {
    lastSkinAddition = GetTickCount();
    LoadCustomSkins();
}

CMD:forceskinupdate(playerid) {
    
    if(!IsPlayerAdmin(playerid)) return false;

    lastSkinAddition = GetTickCount();
    LoadCustomSkins();

    return true;
}

LoadCustomSkins() {
    new tick = GetTickCount();
    print("\n(Re-)Loading all custom skins:");

    new skinDirectory[256];
    format(skinDirectory, sizeof skinDirectory, "models%ccustomskins", separator);
    if(Exists(skinDirectory)) {
        new Directory:dir = OpenDir(skinDirectory), entry[256], ENTRY_TYPE:type;

        while(DirNext(dir, type, entry)) {
            if(type == E_DIRECTORY) {
                
                // Can the characterid be found in the directory? If not, skip the file. We skip this outside of files, otherwise this check passes.
                if(GetSkinFileCharID(entry) == -1) {
                    printf("[CUSTOM SKIN SKIPPED]: Character ID for %s couldn't be found.", entry);
                    continue;
                }
                
                CheckCustomSkins(entry);
            }
        }

        CloseDir(dir);
    }
    else print("[CUSTOM SKINS ERROR] No custom skins directory found.");

    printf("\nProcessed all custom skins files. Took %i ms.", GetTickCount() - tick);
}

// This scans all files inside a directory, checks for errors and eventually caches them for linking in ProcessPlayerSkins.
CheckCustomSkins(const directory[]) {

    if(Exists(directory)) {
        new Directory:dir = OpenDir(directory), ENTRY_TYPE:type, entry[256], extension[16], file_name[64];

        while(DirNext(dir, type, entry)) {
            PathExt(entry, extension, sizeof extension);
            PathBase(entry, file_name, sizeof file_name);

            if(type == E_REGULAR) { 
                // .dff's are the first to be read. We will do all filename checks on this, since if it fails we can't link the txd's anyway.
                if(!strcmp(extension, ".dff")) {
        
                    // Check for filename inconsistencies. We need all the following variables to be present.
                    if(GetSkinFileBaseID(file_name) == -1) {
                        printf("[CUSTOM SKIN ERROR]: Base ID for %s couldn't be found.", file_name);
                        continue;
                    }
                    else if(GetSkinFileSlot(file_name) == -1) {
                        printf("[CUSTOM SKIN ERROR]: Slot for %s couldn't be found.", file_name);
                        continue;
                    }

                    // If above checks are ok, let's cache the file.
                    else {
                        StoreFileInCache(E_SKIN_EXTENSION_DFF, GetSkinFileBaseID(file_name), GetSkinFileCharID(entry), directory, GetSkinFileName(file_name, extension));
                    }
                }
                else if(!strcmp(extension, ".txd")) {
                    // Check for filename inconsistencies. We need all the following variables to be present.
                    if(GetSkinFileBaseID(file_name) == -1) {
                        printf("[CUSTOM SKIN ERROR]: Base ID for %s couldn't be found.", file_name);
                        continue;
                    }
                    else if(GetSkinFileSlot(file_name) == -1) {
                        printf("[CUSTOM SKIN ERROR]: Slot for %s couldn't be found.", file_name);
                        continue;
                    }
                    
                    // If above checks are ok, let's cache the file.
                    else {
                        StoreFileInCache(E_SKIN_EXTENSION_TXD, GetSkinFileBaseID(file_name), GetSkinFileCharID(entry), directory, GetSkinFileName(file_name, extension));
                    }
                }
                else printf("[CUSTOM SKIN ERROR]: File %s is not a .txd nor a .dff. Invalid extension.", entry);
            }
        }
        
        print("[CUSTOM SKIN] Starting to process custom skins.");
        ProcessCustomSkins();
        CloseDir(dir);
    }
}

// This links the cached .dff and .txds to finally add the skin to the server.
ProcessCustomSkins() {
    foreach(new dff: SkinCache) {
        if(TempSkinCache[dff][E_SKIN_TYPE] == E_SKIN_EXTENSION_DFF && !TempSkinCache[dff][E_SKIN_ADDED]) {
            
            foreach(new txd: SkinCache) {
                if(TempSkinCache[txd][E_SKIN_TYPE] == E_SKIN_EXTENSION_TXD && !TempSkinCache[txd][E_SKIN_ADDED]) {

                    if(!strcmp(TempSkinCache[dff][E_SKIN_FILENAME], TempSkinCache[txd][E_SKIN_FILENAME]) && !strcmp(TempSkinCache[dff][E_SKIN_DIRECTORY], TempSkinCache[txd][E_SKIN_DIRECTORY])) {
                        
                        printf("[CUSTOM SKIN PROCESSED] Match found between %s.dff with %s.txd", TempSkinCache[dff][E_SKIN_FILENAME], TempSkinCache[txd][E_SKIN_FILENAME]);
                        AddNewPlayerSkin(
                            GetSkinFileCharID(TempSkinCache[dff][E_SKIN_DIRECTORY]), GetSkinFileBaseID(TempSkinCache[dff][E_SKIN_FILENAME]), GetSkinFileSlot(TempSkinCache[dff][E_SKIN_FILENAME]), 
                            TempSkinCache[dff][E_SKIN_FILENAME],
                            TempSkinCache[txd][E_SKIN_FILENAME],
                            GetSkinDirectory(TempSkinCache[dff][E_SKIN_DIRECTORY])
                        );
                        
                        TempSkinCache[dff][E_SKIN_ADDED] = true;
                        TempSkinCache[txd][E_SKIN_ADDED] = true;
                    }
                }
            }
        }
    }
    return 1;
}

//* Utility functions *//

// Returns file name without extension for matching
GetSkinFileName(const input[], const extension[]) {
    new buffer[64];
    strcat(buffer, input);
    strdel(buffer, strfind(buffer, extension, .ignorecase=true), strlen(buffer));
    return buffer;
}


// Decodes the character id from the file name
GetSkinFileCharID(const file[]) {
    new buffer[64];
    strcat(buffer, file);
    strdel(buffer, 0, strlen(sprintf("models%ccustomskins%c", separator, separator)));
    strdel(buffer, strfind(buffer, sprintf("%c", separator), true, 0), strlen(buffer));
    if(strval(buffer) == 0) return -1;
    return strval(buffer);
}

// Decodes the base id from the file name
GetSkinFileBaseID(const file[]) {
    new buffer[64];
    PathBase(file, buffer, sizeof(buffer));
    strdel(buffer, 0, strfind(buffer, "=")+1);
    strdel(buffer, strfind(buffer, "_"), strlen(buffer));
    if(strval(buffer) == 0) return -1;
    return strval(buffer);
}

// Decodes the slot from the file name
GetSkinFileSlot(const file[]) {
    new buffer[64];
    PathBase(file, buffer, sizeof(buffer));
    strdel(buffer, strfind(buffer, "baseid="), strfind(buffer, "_")+1);
    strdel(buffer, strfind(buffer, "."), strlen(buffer));
    if(strval(buffer) == 0) return -1;
    return strval(buffer);
}

// Removes "models" from the directory path.
GetSkinDirectory(const file[]) {

    new buffer[64];
    strcat(buffer, file);
    strdel(buffer, 0, strlen(sprintf("models%c", separator)));
    return buffer;
}