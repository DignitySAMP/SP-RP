# SP-RP 1.0.5
This is the gamemode that evolved from the SOLS gamemode I wrote in 2019, up until when it turned into GTA-C, and then late 2024 turned into what is SP-RP.

It's a passion project written by a great number of passionate developers for an ungrateful community that has been allowed to play for free for many years, all the while the developers worked around the clock, wasting money on resources, just for them to try and dox the people responsible for making this great.

I hope that with the release of this script, people can look at some of our techniques, innovative solutions and learn from our mistakes. It's nothing great under the hood, but hosted over 200 concurrent players at it's peak.

At the point of releasing this script, we had 2300 commits and 8 github collabotators. Thanks to these people for making it great.

## Credits

Major contributions:
 - DignitySAMP / PXL-DavyL: primary contributor / project lead and creator
 - Spooky/Sporky: contributed towards the shift from SOLS to GTAC, including hundreds of QoL changes
 - Rusu: primary contributor towards bug fixes and QoL changes during the entire duration of the project

Minor contributions:
 - Matz (basketball and trucking)
 - LorenC (pool script, poker script, etc, all 100% written by him for SFCNR)
 - LS-RP (DamianC): the < 2011 furniture array
 - PatrickGTR, Matz, DenNorske, Kubi and Patryk: Open sourcing small systems that the server uses.
 - Tramposo (minor QoL changes)
 - DTVSamp (minor QoL changes)
 - Shabo/plsegott (old item prop system for beer and food that has since been reworked, but still has remnants in the script)

Special thanks:
 - TommyB123 (updating SQL, YSI, major optimizations, init sampctl)
 - DenNorske (helping us fix the problems we couldn't fix ourselves, usually hidden kill switches or infinite loops, and later DDoS protection adjustments)

## Summary

This is plug and play for any competent developer. Uses sampctl for plugin management. The database structure is provided as well as the models required to run. No support will be given on how to run it. If you know what you're doing, you will have no issue with it. I started documenting the code about a month ago, but a lot of features are still lacking crucial documentation. Good luck deciphering it.

There are minor bugs but this ran in production for over 5 years. It should be stable, although if you're looking to host it, invest in a dedicated server with at least 3gb of ram and a shit ton of CPU power. The vehicle module is severely outdated and clogs up resources like crazy. 

I'd say 80-85% of the script is dynamic, meaning it's saved on MySQL. It has UCP support but our UCP remains closed source since the developer (Rusu) will recycle it for other projects. I'd recommend against using this as a base, but with some love, it's pretty much the ideal script for any medium level roleplay server.

The original repository remains private. There is sensitive data in commits that do not belong in the public.

## Features
**Note**: we were in the middle of updating the script late 2024 to a more up to date version. Some modules are still vastly outdated. I tried summarizing what's in here, but it's far too much to mention. In a nutshell, this script has everything you could possibly need, built over years of QoL updates:

Dynamic properties
 - Houses and businesses are properties. 
 - Every business has scripted income when a player does /buy
 - Extensive furniture system (interior only, players can upgrade their interior without needing admins)
 - Wardrobe system (saves your skins, lets you switch to them inside your house)
 - Nearby gunshots system (if someone shoots outside your house, you'll be notified)
 - Realtor system: properties get auto sold over time and can be found centralised at the /realtor
 - Property robbery script written by PatrickGTR for open CNR (EnEx models with actors that you can rob)
 - Property specific actions (/doorme, /doordo, /doorknock, /doorbell, /doorshout)
 - Property storage for guns and drugs
 - Many little QoL systems such as coloured property names and more
 - A large number of admin and user commands for flexibility
 (admins can change every aspect of your business)
 - Extensive buy types, check out /buy and the functions surrounding it.


Dynamic vehicles
 - Static and player owned vehicles support
 - Vehicle tuning system, linked to modshop properties. Features all possible components available in the game
 - Vehicle damage saving, post parking the car
 - Serverside pay and spray system with paintjob support and all SP colors
 - Basic fuel system, with dynamic fuel pump placement (objects) and ownable fuel stations. Refueling has an interface.
 - Unique singleplayer inspired vehicle GUI that's toggable in /settings
 - Car scrapping and car transfer/selling functionality
 - Impounding system for LSPD
 - Basic air traffic control for aircrafts to communicate with LSPD
 - Basic rental system
 - /rprf point system for jobs, factions, ... that fixes and repairs cars
 - Basic static dealership system hosting all non OP cars with prices relevant to our economy
 - DMV system featuring a theoretical quiz
 - Serverside colors and respawning system (a bit buggy, this module needs to be rewritten)
 - Vehicle window script that deters chat and is synced with all other local chats

Dynamic factions
 - Extensive member control (offline player support)
 - Faction tiers determine the power a player has in a faction (3 lowest, 2 command, 1 leader)
 - Dynamic faction ranks: no hard scripted nonsense, /setrank id title
 - Basic faction bank system = it works but was never emphasied upon
 - Faction skins that are semi dynamic, but need to be reworked. You add faction skins with a command and they show on the faction spawn
 - Armory system for LSPD, lets you get guns based on squad and tier
 - Communication (f chat, need to be "granted" by admins, toggable by tier2+, pager system for factions for IC communication, LSPD radios)
 - Faction spawns that allow people to change skins and spawn at this position when they first log in
 - Squad system for the LSPD
 - Many more admin and player commands for system flexibility, too many to mention

Minigames
 - Pool script: written by LorenC for SFCNR, ported to this gamemode, very minor adjustments made
 - Basketball system: very outdated module written by Matz that tries to encapsulate the singleplayer basketball game. Old, unoptimized, but it works.
 - Poker script: it used to work, after we changed the textdraw handler it quit working. You can probably get it to work but I wouldn't count on it. Never took the time to fix it.
 - /shakehands: should feature most if not all the greetings found in the base game with descriptions of what they do.

Jobs
 - Dockworker: you get in a forklift and go between 3 points. Payouts are randomized, streaks give you more money up until a certain cap. This is the entry level job to get you started, very afkable.
 - Garbagejob: you enter a trashmaster and you pick up trash around the city, this gets marked on the map and you use LALT to pick it up the trash on foot and put it in the truck. Payout per item picked up. This is an entry to medium level job, intensive but afkable nonetheless.
 - Trucking job: the end game job. You have to invest in a job, go to a wholesaler to pick up your delivery (you invest money in it), drive it to a store to sell it for a profit. This earns the most over time by far.

Injury
 - Serverside damage system, depending on weapon bullets and base damage (hard coded), dependant on body part hit and distance
 - Injury mode and execution system
 - Taser, tackle, and beanbag system for the LSPD.
 - Synced knife damages with the SKY plugin
 - Basic /damagelist to show your damages
 - If you get shot in the arm, you lose weapon skill and your screen will shake
 - If you get shot in the leg, you will stumble, can no longer sprint or jump
 - /surgery at a hospital heals all afflictions

Gym script
 - Singleplayer inspired gym script
 - You can train muscle and stamina, at the cost of hunger, thirst and energy. 
 - Hunger and thirst are replenished by buying food at a restaurant, this auto consumes.
 - Energy will automatically replenish over time
 - Singleplayer pop up script with a progress bar and green/red based on loss or gain
 - SPRINT+C or /gymstats to show the singleplayer box showing your current stats
 - You do more melee damage and take less melee damage based on muscle and stamina levels
 - If you max out stamina and melee, you can get a custom fightstyle (this can also be set by admins as per our early donation package)
 - All gyms are hardcoded.

Weapons
 - Serverside weapons, ability to add custom gun names 
 - Serverside ammunition, a large factor into determining damage. Easy to add more or change names.
 - Weapons save post /q, are properly removed when needed (hospital, jail, ajail, ban, /q during injury mode, etc) and can be stored in your vehicle or property
 - Dynamic dealer script: factions can be assigned to an "emmet", automatic cooldowns and automatic replenishing, basically a gun locker concept where factions can get weapons at a reduced rate
 - Emmet crate script: factions can get a /emmettip at their personal gun dealer, this has a chance to spawn a gun crate with a large quantity of strong weapons. Same concept as fortnite crates: they spawn at one out of 150 random locations on the map and can be looted using /emmetcrate. Cops can confiscate this crate if it's found, and other players can stumble onto them and loot them as well. Shows a blue skull on the minimap if you are close.
 - Unused "visible.pwn" which was a working prototype (with some bugs) for putting weapons visibly on the body of a player. If you want this to work, you must first adjust the attachment linit in attachments.
 - Serverside drivebies: you can use H to get back in the car if you are in the driveby animation
 - In the event of abuse, admins can give a gun ban using /setgunrights. This blocks the player from using weapons.
 - Because of the serverside weaponids and ammunition, we can easily cancel all incorrect data. This makes weapon hacking impossible.

Drugs
 - Weed: can be grown by buying a weed seed. Ticks over time, need to pass several stages before it will grow fruitfully. Has a chance to be diseased. Using weed heals you over time.
 - Cocaine: same concept as weed. Using cocaine gives you extra melee damage
 - Crack: same concept as weed and coke. Using crack gives you temporary armor that replenishes for as long as the effect is active.
 - Effects last depending on the strain and the amount of grams used.
 - Basic system to split drugs into different containers. All containers are bought from general stores or restaurants.

Chopshop
 - Bring a car to this place to make some quick money, it damages the car to minic the "scrap" effect, then you must drive it away to get the reward.
 - Can be owned by a faction, they take a little cut from the ordeal.

Carjacking
 - Lockpicking and hotwiring system, both have GUIs and act as a minigame.
 - Inspired by GTA-W's old hotwire/lockpick system, remniscent of real life

Boomboxes
 - Ability to stream an official radio channel or a custom link.
 - Placeable through the SAMP object editor, shows a label.
 - If the owner quits, it can be claimed for 15 minutes.
 - Admins can remove boomboxes.
 - Boomboxes use their own proxdetector to send messages to surrounding players in the event of becoming unclaimed or removed.
 - Extensive debugging done to this over the years, should automatically sync and prioritise with vehicle and property stations.

Anticheat
 - Extensive anticheat, rewritten in 2024 to use Raknet
 - Ability to tog some anticheats, this was a 2024 WIP that was never finished
 - External support for paused players and detection
 - All cheats detected:
    - AFking
    - Airbreaking
    - Botting (false connections)
    - Anti bunnyhop
    - Carjack detection
    - Car mod hack
    - Car particle hack
    - Car respray hack
    - Car swinger hack
    - Car troll hack
    - Car warp detection
    - Dialog protection against crashes, spoofing, ...
    - Double connection detection (logging into an user that's already connected or sharing an IP of a new connection)
    - Simple ban evader script (scans the subnet of all banned players, if there's a match, it alerts admins)
    - Fake kill detection
    - Healthhack detection (work in progress, will give false positives for anything other than melee weapons)
    - Money hack detection
    - No reload hack (including scroll to avoid reload detection)
    - Rapid fire detection
    - Spectate detection
    - Jetpack detection
    - Teleport hack detection
    - Ammo hack
    - Weapon hack
    

Attachments
 - Dynamic buypoints that can be linked to a property so the property owner can get income
 - Ability to buy several objects to attach to your player
 - Saving toys and their last edited positions over /q
 - Using the SAMP attachment editing system
 - Basic system, but does the job.
 - Helper functions to recognise bones, slots, etcetera (synced to the other modules)

Animations
 - Basic animation module. 
 - Sorted anims with options and single animations per file
 - "Particle" animations that have effects such as /piss, /shit, /puke, /shakebottle
 - Anti abuse /stopanim (also detects when it's being used to avoid stuns in melee battles)
 - Thanks to Emmet_, Reyo, niCe, BigBear amd DamianC (yoinked some LS-RP anims)

Admin
 - Hundreds of admin commands for everything imaginable
 - Spectating system, listening system, etcetera
 - Hundreds of extra commands for the other systems
 - Reports come in and are stored. Admins get reminded of reports
 (/ar and /dr to accept or deny respectively)
 - Basic admin level system with titles, /ahide, and much more
 - Way more features, impossible to cover it all

Helper
 - Questions come in through /ask, helpers can /ah to accept and /answer to answer
 - Questions are saved and helpers get reminded of reports
 - Some other small commands are accessible to them, use /staffhelp

Contributor
 - Ability to invite others to /admin chat with or without admin powers (no powers, junior, manager (= hidden admin))

Spraytags
 - Static spraytags remniscent of singleplayer
 - Ability to tag custom text, featuring a coloring system and more
 - Admins can track who sprayed what and wipe them
 - LSPD can also wipe them

Phone script
 - Textdraw clickable phone system
 - Ability to save contacts and call/sms using the contact names
 - Dialog/textdraw based or using basic commands
 - Ability to customise your phone with backgrounds, ringtones, and colors

Police script
 - Ability to use /carsign
 - Squads and armories
 - Amazing LSPD interior modelled by Spooky
 - Ability to use /bk and /panic (shows markers on minimap)
 - Entire pental code is scripted, synced with /charge and /ticket
 - Intricate ticket system, they auto expire and need to be paid by players
 - Custom 0.3DL lightstrobe effects for sirens
 - Custom /siren script, synced with lightstrobes
 - Mole script
 - Spike script
 - Soundproof interrogation rooms
 - Gunracks
 - No MDC, but helper commands to look for owned properties, character info and car info.
 - Intricate dialog and request based frisking system 

Hitman script
 - Currently unhooked: players call 666 to make a contract
 - Hitman has to visit the caller and manually assign data in a contract menu to avoid metagame
 - Once the hitman accepts a contact, they can mark the target.
 - Killing a target when they're marked will block them from using a character for 24 hours

Player accounts
 - Accounts can be registered ingame
 - Basic tutorial explaining the basics
 - Email prompts for UCP support
 - Max 5 character slots
 - Intricate spawning system, allowing you to spawn at your property, faction, a public spawn or your last position
 - Ability to add attributes to your character (height, weight, eye color,  hair color, body build, and more) => /examine system
 - /settings that lets you customise a bunch of things regarding the interface, per player
 - A ton of other things, too much to mention

Gates
 - Ability to create custom doors, gates and garage doors
 - Can be assigned to factions, properties, or be player owned
 - Ability to animate them or just have them open automatically
 - Ability to convert them to tolls, police can /policetolls
 - Ability to add autoclose


Passpoints
 - Ability to add /pass points, useful for backdoors or rear windows
 - Everything is customisable, range, color, name, and who can use it
 - Ability to /pass on foot or on vehicle (depending on type)

GPS
 - Ability to go to points of interest
 - Ability to go to enex /buy points
 - Ability to go to houses or properties
 - Always finds the nearest entity and sorts it accordingly (shown to player)

Custom skins
 - Loads skins without restarting = simply drag the file to the right folder
 - Follows a specific file name/directory format to dissect baseid and character id
 - Accessible in /wardrobe
 - Was designed to be used with an uploading system on a UCP, but works without as long as you drag the files in the appropriate subfolder with the appropriate name
 - Custom error handling, caching, and loading container.

Custom nametag system
 - Players can switch between firstname and lastname
 - Powered by Raknet
 - Synced in the scoreboard, tablist, and proxdetector
 - Custom sscanf handler to make the use of both playerids, clan tags, and firstname_lastname compatible.
 - Easily configurable, to turn off the switch simply remove the option to select clan tags.
 - Players choose their preference when they first spawn or in /settings

News system
 - Ability to do /breaking (admins got /abreaking) for a breaking news announcement
 - Ability to go live and invite people to your talkshow (players can do /broadcasts and tune in or out)
 - Faction type = news
 - Adds /mic support to businesses

Player logging
 - Most advanced player logging system ever seen on SA-MP, written by Spooky
 - Ingame log browser, sorted by type
 - Used throughout the script, stores important player data per store
 - Shows the last 75 logs when showing logs
 - Ability to show all logs, online player log, or offline player logs. (/plogs, /plog, /oplog)
 - Admin level restriction support

Server config
 - Stores a bunch of information that's dynamically appended:
 - Server year and time
 - Public and admin motd
 - Login song
 - Admin chat hex color
 - More minor stuff not worth mentioning

Spawnables/Holdables
 - Players can dynamically put down objects, or hold them
 - This is useful if a player wants to host a BBQ or an event, simply /spawn and map the objects themselves
 - Equally, in a bar, you can use /hold and equip a beer bottle or a glass. There are also food items or other useful items to aid you in your roleplaying situations.
 - Made by Spooky: this is the best way for players to immerse themselves and their scenes: players put down their own RP objects or hold RP props to benefit their screenshots and environment.
