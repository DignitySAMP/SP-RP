enum {
	VOICE_LINE_FAMILIES,
	VOICE_LINE_BALLAS,
	VOICE_LINE_VLA,
	VOICE_LINE_VAGOS,
	VOICE_LINE_LSPD
} ;

enum E_VOICELINE_DATA {

	E_VOICELINE_CONST,
	E_VOICELINE_ID,
	E_VOICELINE_DESC[96]
} ;

#warning improve this with the omp gm code... PLEASE
new VL_Families [ ] [ E_VOICELINE_DATA ] = {

	{ VOICE_LINE_FAMILIES, 103100, "Hey get in the car fools! " },
	{ VOICE_LINE_FAMILIES, 103104, "Proud of you boy you have him down." },
	{ VOICE_LINE_FAMILIES, 103105, "Man I hope nobody got hurt." },
	{ VOICE_LINE_FAMILIES, 103113, "Yeaaah baby ! " },
	{ VOICE_LINE_FAMILIES, 103118, "I can't go back to jail ! " },
	{ VOICE_LINE_FAMILIES, 103120, "Say, you must be high now ?" },
	{ VOICE_LINE_FAMILIES, 103122, "Hey man comeon man COME ONNN." },
	{ VOICE_LINE_FAMILIES, 103130, "Hey man do I look like a bitch ?" },
	{ VOICE_LINE_FAMILIES, 103131, "I ain't crazy just cold blooded ! " },
	{ VOICE_LINE_FAMILIES, 103135, "I kick yo ass mane !" },
	{ VOICE_LINE_FAMILIES, 103136, "Bangin' and MORE Bangin ! " },
	{ VOICE_LINE_FAMILIES, 103138, "I told you I don't care I am crazy ! " },
	{ VOICE_LINE_FAMILIES, 103140, "That car is DoOoDoO" },
	{ VOICE_LINE_FAMILIES, 103141, "Hey man your vehicle is garbage." },
	{ VOICE_LINE_FAMILIES, 103144, "Hey your haircut make yo' hair look BIG." },
	{ VOICE_LINE_FAMILIES, 103146, "Hey you need to kick your barber's ass." },
	{ VOICE_LINE_FAMILIES, 103148, "Hey man these shoes make yo' feet look BIG." },
	{ VOICE_LINE_FAMILIES, 103152, "Why you do that SHIT !? " },
	{ VOICE_LINE_FAMILIES, 103156, "Say mane I just gave you a compliment FOOL." },
	{ VOICE_LINE_FAMILIES, 103157, "Say foo' you take me for a foo' ? " },
	{ VOICE_LINE_FAMILIES, 103158, "You gonna ignore ME ? " },
	{ VOICE_LINE_FAMILIES, 103159, "I ain't a bitch, BITCH ! " },
	{ VOICE_LINE_FAMILIES, 103160, "Say mane why you treat me like a bitch ? " },
	{ VOICE_LINE_FAMILIES, 103161, "Mane thats TIGHT!" },
	{ VOICE_LINE_FAMILIES, 103164, "Hey that car is DOPE! " },
	{ VOICE_LINE_FAMILIES, 103166, "Hey where you get your haircut playa ? " },
	{ VOICE_LINE_FAMILIES, 103169, "Oh these are sum' tight kicks playboy ! " },
	{ VOICE_LINE_FAMILIES, 103172, "Hey lemme' see your kicks ?" },
	{ VOICE_LINE_FAMILIES, 103173, "Thats the ONE! " },
	{ VOICE_LINE_FAMILIES, 103177, "HEY I GOT THIS, I GOT THIS ! " },
	{ VOICE_LINE_FAMILIES, 103178, "GET MY BACK DUDE, GET MY BACK ! " },
	{ VOICE_LINE_FAMILIES, 103180, "COVER ME, COVER ME ! " },
	{ VOICE_LINE_FAMILIES, 103185, "Hey you better watch that fool! " },
	{ VOICE_LINE_FAMILIES, 103186, "Oh comeon MANE!" },
	{ VOICE_LINE_FAMILIES, 103187, "Oh NO,NO,NO ! " },
	{ VOICE_LINE_FAMILIES, 103196, "Hey man watch out there ! " },
	{ VOICE_LINE_FAMILIES, 103402, "Look at all those shit ones ! " },
	{ VOICE_LINE_FAMILIES, 103407, "Yay, pushin' GOAT FUCKAS ! " },
	{ VOICE_LINE_FAMILIES, 103409, "North Side, Assholes ! " },
	{ VOICE_LINE_FAMILIES, 103410, "You motha' fuckas." },
	{ VOICE_LINE_FAMILIES, 103411, "Azz-teca, Assholes ! " },
	{ VOICE_LINE_FAMILIES, 103413, "South Side Mother Fuckers ! " },
	{ VOICE_LINE_FAMILIES, 103415, "I didn't do nothin', I didn't say nothin! " },
	{ VOICE_LINE_FAMILIES, 103416, "I was just watchin' " },
	{ VOICE_LINE_FAMILIES, 103428, "Bow to the GROVE STREET!" },
	{ VOICE_LINE_FAMILIES, 103429, "V-L-A gonna BLEED." },
	{ VOICE_LINE_FAMILIES, 103439, "Hey gimme something to drink ova' here." },
	{ VOICE_LINE_FAMILIES, 103440, "I want the BEST, mother fucker." },
	{ VOICE_LINE_FAMILIES, 103443, "Hey whats the hold up ? " },
	{ VOICE_LINE_FAMILIES, 103445, "Grove Street O.G comin' thru." },
	{ VOICE_LINE_FAMILIES, 103451, "What is this shit you drinkin ? " },
	{ VOICE_LINE_FAMILIES, 103452, "Not exactly premium liquor, is it ? " },
	{ VOICE_LINE_FAMILIES, 103453, "Maan, this is so ghetto.." },
	{ VOICE_LINE_FAMILIES, 103455, "Yo, I need a beer." },
	{ VOICE_LINE_FAMILIES, 103470, "Mane, MA chest HURTS.." },
	{ VOICE_LINE_FAMILIES, 103481, "Hey man, chill, chill chill.. " },
	{ VOICE_LINE_FAMILIES, 103485, "Shit ! you drive like a mother fucker ! " },
	{ VOICE_LINE_FAMILIES, 103494, "Hey whats happening ?" },
	{ VOICE_LINE_FAMILIES, 103503, "Okey, get in, get in , get in." },
	{ VOICE_LINE_FAMILIES, 103504, "Okey lets do this, get in." },
	{ VOICE_LINE_FAMILIES, 103516, "This car can't fly you BITCH" },
	{ VOICE_LINE_FAMILIES, 103546, "You gotta do some exercise dude." },
	{ VOICE_LINE_FAMILIES, 103550, "I was talkin' to you whats yo problem ? " },
	{ VOICE_LINE_FAMILIES, 103559, "Hey check that ride !" },
	{ VOICE_LINE_FAMILIES, 103560, "Looking pumped homes' " },
	{ VOICE_LINE_FAMILIES, 103563, "Mane you spend too much time at the gym!" },
	{ VOICE_LINE_FAMILIES, 103564, "Lookin' like a male model or some shi'" },
	{ VOICE_LINE_FAMILIES, 103570, "Cover my back dudes" },
	{ VOICE_LINE_FAMILIES, 103571, "Spray em fools' " },
	{ VOICE_LINE_FAMILIES, 103572, "Keep your heads down ! " },
	{ VOICE_LINE_FAMILIES, 103573, "Make em hit DIRT! " },
	{ VOICE_LINE_FAMILIES, 103575, "Holy, MOTHER FUCKER !" },
	{ VOICE_LINE_FAMILIES, 103200, "Ball sucka strawberries ! " },
	{ VOICE_LINE_FAMILIES, 103203, "Ball-Sex got no heart mane!" },
	{ VOICE_LINE_FAMILIES, 103204, "Fuck BALLAS ! " },
	{ VOICE_LINE_FAMILIES, 103205, "North Side dropped the soap ! " },
	{ VOICE_LINE_FAMILIES, 103209, "Fuck North Side Hoes ! " },
	{ VOICE_LINE_FAMILIES, 103210, "Hey South Side Ass-holes ! " },
	{ VOICE_LINE_FAMILIES, 103213, "Ass-taker' ass suckas! " },
	{ VOICE_LINE_FAMILIES, 103214, "South Side Sucka burritos ! " },
	{ VOICE_LINE_FAMILIES, 103215, "Hey burrito boys ! " },
	{ VOICE_LINE_FAMILIES, 103216, "Yall' trippin." },
	{ VOICE_LINE_FAMILIES, 103218, "Officer I swear that ain't ma." },
	{ VOICE_LINE_FAMILIES, 103224, "Hey give it to them fools! " },
	{ VOICE_LINE_FAMILIES, 103238, "You gonna take some esses ? " },
	{ VOICE_LINE_FAMILIES, 103241, "I ain't drunk yet." },
	{ VOICE_LINE_FAMILIES, 103242, "Hey somebody can give me a drink ? " },
	{ VOICE_LINE_FAMILIES, 103246, "Hey move it mother fucker ! " },
	{ VOICE_LINE_FAMILIES, 103249, "Ice Cold ! " },
	{ VOICE_LINE_FAMILIES, 103250, "This tastes like some spit ! " },
	{ VOICE_LINE_FAMILIES, 103253, "Oh good looking homie." },
	{ VOICE_LINE_FAMILIES, 103299, "Yo we rollin' " },
	{ VOICE_LINE_FAMILIES, 103302, "Ahh shit I ain't intrested mane." },
	{ VOICE_LINE_FAMILIES, 103314, "Patrol Cars ! " },
	{ VOICE_LINE_FAMILIES, 103316, "Nice and cruzy." },
	{ VOICE_LINE_FAMILIES, 103320, "Hey hold up, hold up." },
	{ VOICE_LINE_FAMILIES, 103324, "I'ma O.G yes I am ! " },
	{ VOICE_LINE_FAMILIES, 103328, "I should pimp those hoes mane." },
	{ VOICE_LINE_FAMILIES, 103340, "Why your shoes lean to the side mane." },
	{ VOICE_LINE_FAMILIES, 103351, "Hey man I like your tier man its tight." },
	{ VOICE_LINE_FAMILIES, 103352, "You are well dressed mane." },
	{ VOICE_LINE_FAMILIES, 103354, "Hey how can I get like you homie." },
	{ VOICE_LINE_FAMILIES, 103356, "Hey nice hair cut." },
	{ VOICE_LINE_FAMILIES, 103363, "Where did you get em' kicks ? " },
	{ VOICE_LINE_FAMILIES, 103366, "HEY COVER ME DOGG ! " },
	{ VOICE_LINE_FAMILIES, 103367, "COVER ME CUZZ ! " },
	{ VOICE_LINE_FAMILIES, 103369, "HEY LIGHT THOSE FUCKERS UP ! " },
	{ VOICE_LINE_FAMILIES, 103376, "I am mad as FUCK ! now." },
	{ VOICE_LINE_FAMILIES, 103379, "Not this shit again.." },
	{ VOICE_LINE_FAMILIES, 103382, "Ma' knee UGHH." },
	{ VOICE_LINE_FAMILIES, 103383, "Ughh the pain ! " },
	{ VOICE_LINE_FAMILIES, 103386, "Go chase one of them Ballas, fool! " },
	{ VOICE_LINE_FAMILIES, 103387, "I didn't do nothing ! " },
	{ VOICE_LINE_FAMILIES, 103389, "Hey stupid ! " },
	{ VOICE_LINE_FAMILIES, 103390, "Hey watch the gear mutha fucka ! " },
	{ VOICE_LINE_FAMILIES, 103396, "Mane I am blown." },
	{ VOICE_LINE_FAMILIES, 103399, "I ain't interested in your shit." },
	{ VOICE_LINE_FAMILIES, 103000, "Hey Ballas, YOU WEAK ! " },
	{ VOICE_LINE_FAMILIES, 103002, "Hey Ballas, I'll take all you PUNKS! " },
	{ VOICE_LINE_FAMILIES, 103003, "Hey Ballas, YOU COCK SUCKERS ! " },
	{ VOICE_LINE_FAMILIES, 103004, "Right here dude right here ! " },
	{ VOICE_LINE_FAMILIES, 103005, "Hey Ballas, WHATS UP NOW ?" },
	{ VOICE_LINE_FAMILIES, 103007, "Hey Ballas, FUCK YOU ! " },
	{ VOICE_LINE_FAMILIES, 103008, "Hey you, VATO PUNKS ! " },
	{ VOICE_LINE_FAMILIES, 103009, "HEY YOU ESE ! " },
	{ VOICE_LINE_FAMILIES, 103011, "L-S-V Ain't shit ! " },
	{ VOICE_LINE_FAMILIES, 103013, "Aztecas- KISS MA ASS ! " },
	{ VOICE_LINE_FAMILIES, 103015, "Hey Aztecas, FUCK YOU ! " },
	{ VOICE_LINE_FAMILIES, 103017, "I ain't scared no Ass-Lickers." },
	{ VOICE_LINE_FAMILIES, 103018, "Hey man I am not scared of you." },
	{ VOICE_LINE_FAMILIES, 103019, "I didn't do nothing man." },
	{ VOICE_LINE_FAMILIES, 103020, "Hey Mr.Officer I didn't do shit." },
	{ VOICE_LINE_FAMILIES, 103021, "Hey man shut up you boring me mane." },
	{ VOICE_LINE_FAMILIES, 103025, "Hey whats up with that I thought we was folk { ? " },
	{ VOICE_LINE_FAMILIES, 103036, "They all MINE." },
	{ VOICE_LINE_FAMILIES, 103039, "Welcome to GROVE STREET ! " },
	{ VOICE_LINE_FAMILIES, 103043, "ITS GROVE 4 LIFE ! " },
	{ VOICE_LINE_FAMILIES, 103042, "Scuba time Baby ! " },
	{ VOICE_LINE_FAMILIES, 103046, "GROVE STREET FAMALAY ! " },
	{ VOICE_LINE_FAMILIES, 103049, "Hey get homie a drink." },
	{ VOICE_LINE_FAMILIES, 103050, "You wanna drink homie ? " },
	{ VOICE_LINE_FAMILIES, 103057, "Hey whats going on mane, move outta way ! " },
	{ VOICE_LINE_FAMILIES, 103059, "Hey Playboy, MOVE!" },
	{ VOICE_LINE_FAMILIES, 103061, "Hey let me get swallow of that." },
	{ VOICE_LINE_FAMILIES, 103062, "Hit me up with some of that,straight up." },
	{ VOICE_LINE_FAMILIES, 103063, "Say mane let me get a squeak." },
	{ VOICE_LINE_FAMILIES, 102700, "HELL YEAH FAMALAYY' " },
	{ VOICE_LINE_FAMILIES, 102699, "Geah ! Thats how Fam' doin it." },
	{ VOICE_LINE_FAMILIES, 102688, "Jump in FAMALAY ! " },
	{ VOICE_LINE_FAMILIES, 102634, "Loc, I ain't drinking that bullshit." },
	{ VOICE_LINE_FAMILIES, 102621, "V-L-A KILLAH'" },
	{ VOICE_LINE_FAMILIES, 102797, "This shit is too strong for me homie." },
	{ VOICE_LINE_FAMILIES, 102809, "Vatos PUNKS!" },
	{ VOICE_LINE_FAMILIES, 102812, "You ain't shit vatos." },
	{ VOICE_LINE_FAMILIES, 102807, "Ballas ain't shit." },
	{ VOICE_LINE_FAMILIES, 102806, "Ball-sack bustas' " },
	{ VOICE_LINE_FAMILIES, 102819, "I got lawyers I ain't trippin." },
	{ VOICE_LINE_FAMILIES, 102820, "You don't know who you fucking with huh." },
	{ VOICE_LINE_FAMILIES, 102821, "Damn squirrel ass police, uh-huh." },
	{ VOICE_LINE_FAMILIES, 102825, "I thought we was homies man, you trippin." },
	{ VOICE_LINE_FAMILIES, 102827, "Comeon yall whats up comeon !?" },
	{ VOICE_LINE_FAMILIES, 102830, "Grove Street comeon yall lets own." },
	{ VOICE_LINE_FAMILIES, 102837, "O - G - S ! " },
	{ VOICE_LINE_FAMILIES, 102838, "YEAH, O - G - S , GROVE ! " },
	{ VOICE_LINE_FAMILIES, 102839, "GROVE STREET FAMILY, Yeah Whats up Whats up !?" },
	{ VOICE_LINE_FAMILIES, 102843, "Grove Street, what you bitches gonna do now ? " },
	{ VOICE_LINE_FAMILIES, 102844, "GROVE STREET ! " },
	{ VOICE_LINE_FAMILIES, 102845, "Just an idiot with a drinking problem." },
	{ VOICE_LINE_FAMILIES, 102846, "You drink too much fool." },
	{ VOICE_LINE_FAMILIES, 102848, "You drunk or somethin' mane ?" },
	{ VOICE_LINE_FAMILIES, 102862, "Can I get a sip on that ? " },
	{ VOICE_LINE_FAMILIES, 102897, "Is everybody okey ? " },
	{ VOICE_LINE_FAMILIES, 102902, "Who rollin' shotgun ?" },
	{ VOICE_LINE_FAMILIES, 102908, "You killed that foo' " },
	{ VOICE_LINE_FAMILIES, 102922, "Wait wait wait, hold up a second." },
	{ VOICE_LINE_FAMILIES, 102923, "Wait here boy." },
	{ VOICE_LINE_FAMILIES, 102924, "Wait a second dogg." },
	{ VOICE_LINE_FAMILIES, 102925, "People don't respect the gangs no more." },
	{ VOICE_LINE_FAMILIES, 102927, "I am just holding shit down mane, yeah!" },
	{ VOICE_LINE_FAMILIES, 102928, "I shoulda join the army then." },
	{ VOICE_LINE_FAMILIES, 102929, "I got the hood on lock." },
	{ VOICE_LINE_FAMILIES, 102931, "Bitch better have my money." },
	{ VOICE_LINE_FAMILIES, 102932, "My set ain't for bustas mane." },
	{ VOICE_LINE_FAMILIES, 102934, "Mane you better left this shit at the { junkyard!" },
	{ VOICE_LINE_FAMILIES, 102937, "Mane you look like a fuckin clown! Dude." },
	{ VOICE_LINE_FAMILIES, 102938, "Mane you rocking some corny shit today mane!" },
	{ VOICE_LINE_FAMILIES, 102939, "Mane who told you that shit was G dogg !?" },
	{ VOICE_LINE_FAMILIES, 102948, "What kind of tattoo is that, is this { permanent or WHA-. ?" },
	{ VOICE_LINE_FAMILIES, 102951, "Your boy deaf or somethin'" },
	{ VOICE_LINE_FAMILIES, 102952, "You can't hear me huh." },
	{ VOICE_LINE_FAMILIES, 102958, "Man what are those mane, you look G'ed up! " },
	{ VOICE_LINE_FAMILIES, 102960, "Daamn! You G'ed up homie!" },
	{ VOICE_LINE_FAMILIES, 102967, "I need to see yo' barber, he's alright mane." },
	{ VOICE_LINE_FAMILIES, 102968, "Mane these are some nice kicks right there." },
	{ VOICE_LINE_FAMILIES, 102973, "Good art mane." },
	{ VOICE_LINE_FAMILIES, 102977, "COVER MA' BACK MANE, COVER ME MANE!" },
	{ VOICE_LINE_FAMILIES, 102980, "I GOT THIS!" },
	{ VOICE_LINE_FAMILIES, 102983, "You fuckin idiot!" },
	{ VOICE_LINE_FAMILIES, 102992, "Mane fuck you mane." },
	{ VOICE_LINE_FAMILIES, 102993, "Ah-. you MOTHER FUCKER!" },
	{ VOICE_LINE_FAMILIES, 102997, "Ah dog you be trippin! " },
	{ VOICE_LINE_FAMILIES, 102999, "What the FUCK is wrong with chu!?" }
};


new VL_Ballas [ ] [ E_VOICELINE_DATA ] = {
	// RHB, KTB, FYB
	{ VOICE_LINE_BALLAS, 101100, "Grove Street Famaly' SUCK ASS ! " },
	{ VOICE_LINE_BALLAS, 101101, "SUCK MA DICK GROVE BITCH!" },
	{ VOICE_LINE_BALLAS, 101106, "Grove got nuthin' " },
	{ VOICE_LINE_BALLAS, 101107, "Grove Street mama' suck ma dick!" },
	{ VOICE_LINE_BALLAS, 101013, "North Side wear high heels ! " },
	{ VOICE_LINE_BALLAS, 101015, "North Side go fuck your self !" },
	{ VOICE_LINE_BALLAS, 101017, "You ain't for SHIT, Vaghoes." },
	{ VOICE_LINE_BALLAS, 101018, "Azz-teca, A-Holes ! " },
	{ VOICE_LINE_BALLAS, 101021, "South Side suck ass, sum' bitches." },
	{ VOICE_LINE_BALLAS, 101023, "South Side going down, Mother fucker ! " },
	{ VOICE_LINE_BALLAS, 101024, "Fuck yo' mane." },
	{ VOICE_LINE_BALLAS, 101025, "You got the wrong O.G" },
	{ VOICE_LINE_BALLAS, 101026, "Nah I didn't do SHIT!" },
	{ VOICE_LINE_BALLAS, 101028, "Yo mane this AIN'T Ma, gat ! " },
	{ VOICE_LINE_BALLAS, 101034, "He looks like a Grove O.G to me." },
	{ VOICE_LINE_BALLAS, 101041, "Lets torch this FUCKA! " },
	{ VOICE_LINE_BALLAS, 101047, "He smell like a Grove Street fool HUH! " },
	{ VOICE_LINE_BALLAS, 101050, "Thats the shit right here mane, that the shit!" },
	{ VOICE_LINE_BALLAS, 101051, "Yo you heard he news bro ?" },
	{ VOICE_LINE_BALLAS, 101055, "HEY YO WHAT THE FUCK FOO' !?" },
	{ VOICE_LINE_BALLAS, 101063, "Nice and cold, thanks mane." },
	{ VOICE_LINE_BALLAS, 101065, "Ey yo get me a beer dude." },
	{ VOICE_LINE_BALLAS, 101076, "Kill that SUCKA! " },
	{ VOICE_LINE_BALLAS, 101078, "Go and give him the BALLAS' Welcome." },
	{ VOICE_LINE_BALLAS, 101088, "Represent yo' self chicken boy." },
	{ VOICE_LINE_BALLAS, 101089, "Ey-. Ey-. come back here mane!" },
	{ VOICE_LINE_BALLAS, 101091, "Ooo- I luv this city." },
	{ VOICE_LINE_BALLAS, 101093, "Mane ma mama' giving me grief." },
	{ VOICE_LINE_BALLAS, 101094, "Some fool battling ma ryhmes cuzz'" },
	{ VOICE_LINE_BALLAS, 101095, "Yo Ima Baller mane' That means somethin! " },
	{ VOICE_LINE_BALLAS, 101098, "Balla' 4 Life Mane!" },
	{ VOICE_LINE_BALLAS, 101108, "You two hard to talk to me ?" },
	{ VOICE_LINE_BALLAS, 101109, "Go head mane I got you dogg.  " },
	{ VOICE_LINE_BALLAS, 101112, "I got em' under controll !" },
	{ VOICE_LINE_BALLAS, 101129, "I don't know nothin' " },
	{ VOICE_LINE_BALLAS, 101142, "Hey you lost lil' fella ?" },
	{ VOICE_LINE_BALLAS, 101143, "He ain't from around here I am telling you." },
	{ VOICE_LINE_BALLAS, 101144, "I ain't see this boy befo'" },
	{ VOICE_LINE_BALLAS, 101148, "Looks like a Grove boy to me." },
	{ VOICE_LINE_BALLAS, 101154, "Serve me up sum' fool comeon." },
	{ VOICE_LINE_BALLAS, 101165, "Stay down sucka!" },
	{ VOICE_LINE_BALLAS, 101166, "Anotha' wasted fool." },
	{ VOICE_LINE_BALLAS, 101170, "DON'T FUCK WITH THE BALLAS!" },
	{ VOICE_LINE_BALLAS, 101173, "Hey lady whats up girl." },
	{ VOICE_LINE_BALLAS, 101175, "I don't own you, so no I don't know you." },
	{ VOICE_LINE_BALLAS, 101176, "Fuck-. you lookin' at ?" },
	{ VOICE_LINE_BALLAS, 101178, "Do you know who you lookin' at ?" },
	{ VOICE_LINE_BALLAS, 101195, "Step up Lil' G." },
	{ VOICE_LINE_BALLAS, 101198, "You banging fool ?" },
	{ VOICE_LINE_BALLAS, 100480, "Oh you wanna be though for me?" },
	{ VOICE_LINE_BALLAS, 100481, "I said where you from?" },
	{ VOICE_LINE_BALLAS, 100484, "You better let someone know where you from { homeboy." },
	{ VOICE_LINE_BALLAS, 100485, "Cover me homie im going in" },
	{ VOICE_LINE_BALLAS, 100486, "COVER MY ASS GET THAT MOFUKA" },
	{ VOICE_LINE_BALLAS, 100487, "Im the hero around this motherfucka" },
	{ VOICE_LINE_BALLAS, 100488, "Ah you motherfucka! " },
	{ VOICE_LINE_BALLAS, 100489, "My wheels! " },
	{ VOICE_LINE_BALLAS, 100490, "DAMN LOOK OUT MOFUKA! " },
	{ VOICE_LINE_BALLAS, 100492, "MY MOTHERFUCKING RIDE! " },
	{ VOICE_LINE_BALLAS, 100493, "Man you fucked up my car! " },
	{ VOICE_LINE_BALLAS, 100510, "EY WATCH OUT! " },
	{ VOICE_LINE_BALLAS, 100494, "Man im gonna shoot cho punk ass!" },
	{ VOICE_LINE_BALLAS, 100497, "MY WHIP!!! " },
	{ VOICE_LINE_BALLAS, 100498, "MY CAR!!! " },
	{ VOICE_LINE_BALLAS, 100499, "OH OKAY ITS ON NOW!" },
	{ VOICE_LINE_BALLAS, 100500, "EY FOOL!" },
	{ VOICE_LINE_BALLAS, 100501, "DAMN YOU SEE THAT SHIET?" },
	{ VOICE_LINE_BALLAS, 100502, "OH MAN!" },
	{ VOICE_LINE_BALLAS, 100503, "MY RIDE FOOL " },
	{ VOICE_LINE_BALLAS, 100505, "POLICE TRYNA KILL ME" },
	{ VOICE_LINE_BALLAS, 100506, "EY MAN WHAT THE HELLS GOING ON MAN?" },
	{ VOICE_LINE_BALLAS, 100507, "WHASS GOIN ON HERE MAN WHY Y'ALL TRYNA KILL { ME?" },
	{ VOICE_LINE_BALLAS, 100508, "MAN SOMEONE VIDEO THIS SHIT!" },
	{ VOICE_LINE_BALLAS, 100512, "DONT LET ME CATCH YOU!" },
	{ VOICE_LINE_BALLAS, 100513, "OH ITS ON NOW!" },
	{ VOICE_LINE_BALLAS, 100514, "YOU GOT A DEATHWISH?" },
	{ VOICE_LINE_BALLAS, 100515, "STOP THAT CRAZY FOOL!" },
	{ VOICE_LINE_BALLAS, 100517, "MOTHERFUCKER!" },
	{ VOICE_LINE_BALLAS, 100519, "GIT YOUR PUNK ASS OUTTA MY HOOD!" },
	{ VOICE_LINE_BALLAS, 100521, "GET UP OUT THIS HOOD BOY!" },
	{ VOICE_LINE_BALLAS, 100522, "Thass them busters!" },
	{ VOICE_LINE_BALLAS, 100523, "OH YOU KNOW ME FROM SOMEWHERE FOOL?" },
	{ VOICE_LINE_BALLAS, 100524, "I DONT THINK YOU KNOW ME." },
	{ VOICE_LINE_BALLAS, 100526, "YOU MAD DOGGIN ME?" },
	{ VOICE_LINE_BALLAS, 100527, "YOU CANT BE MAD DOGGIN ME." },
	{ VOICE_LINE_BALLAS, 100522, "THASS THEM BUSTERS!" },
	{ VOICE_LINE_BALLAS, 100528, "YOU KNOW WHO BALLAS ARE BOY?" },
	{ VOICE_LINE_BALLAS, 100529, "YOU BETTER BACK UP OFF OF IT FOOL!" },
	{ VOICE_LINE_BALLAS, 100532, "GROVE ST? GET THE FUCK OUTTA HERE!" },
	{ VOICE_LINE_BALLAS, 100533, "MOTHERFUCKER IS THAT A GROVE ST MOTHERFUCKER?" },
	{ VOICE_LINE_BALLAS, 100537, "SO WATCHU GOT FOR ME MAN, LEMME CHECK IT OUT?" },
	{ VOICE_LINE_BALLAS, 100538, "DUCK MAN!" },
	{ VOICE_LINE_BALLAS, 100539, "OH SHIT DUCK DOWN NIGGA " },
	{ VOICE_LINE_BALLAS, 100540, "ROLL OVER THAT WAY! " },
	{ VOICE_LINE_BALLAS, 100542, "STAY DOWN DERE! " },
	{ VOICE_LINE_BALLAS, 100543, "GAME OVER BITCH! " },
	{ VOICE_LINE_BALLAS, 100544, "SHOULD'VE STAYED YOUR PUNK ASS AT HOME!" },
	{ VOICE_LINE_BALLAS, 100545, "HES BEEN DUMPED ON" },
	{ VOICE_LINE_BALLAS, 100548, "MAN YOU MAKE ME LAUGH." },
	{ VOICE_LINE_BALLAS, 100549, "YOU DIE HOMIE." },
	{ VOICE_LINE_BALLAS, 100550, "SORRY HOMEBOY." },
	{ VOICE_LINE_BALLAS, 100551, "ITS EITHER YOU OR ME FOOL!" },
	{ VOICE_LINE_BALLAS, 100553, "GO LAY DOWN FOR GOOD." },
	{ VOICE_LINE_BALLAS, 100554, "GOOD NIGHT MOTHERFUCKER." },
	{ VOICE_LINE_BALLAS, 100556, "WHATS HAPPENIN BABY?" },
	{ VOICE_LINE_BALLAS, 100558, "COME HOLLER AT YOUR BOY." },
	{ VOICE_LINE_BALLAS, 100559, "YOU KNOW ME OR SOMETHING?" },
	{ VOICE_LINE_BALLAS, 100560, "do i look like your bitch?" },
	{ VOICE_LINE_BALLAS, 100561, "you better look away bitch!" },
	{ VOICE_LINE_BALLAS, 100563, "WASSUP, TOE TO TOE?" },
	{ VOICE_LINE_BALLAS, 100565, "ME AND YOU, WHATS HAPPENIN?" },
	{ VOICE_LINE_BALLAS, 100568, "ITS ON NOW!" },
	{ VOICE_LINE_BALLAS, 100569, "YOU HIT LIKE A GIRL MAN!" },
	{ VOICE_LINE_BALLAS, 100570, "TRYNA HIT ME?" },
	{ VOICE_LINE_BALLAS, 100572, "CANT HURT ME NIGGUH IM A REAL BALLA" },
	{ VOICE_LINE_BALLAS, 100573, "WHATS HAPPENIN NIGGUH, LAY DOWN." },
	{ VOICE_LINE_BALLAS, 100574, "YOU BANG FOOL?" },
	{ VOICE_LINE_BALLAS, 100575, "WHAT SET YOU FROM HOMIE?" },
	{ VOICE_LINE_BALLAS, 100578, "WRONG COLOR - WRONG BLOCK." },
	{ VOICE_LINE_BALLAS, 100579, "You on the wrong side homeboy." },
	{ VOICE_LINE_BALLAS, 100580, "I THINK YOU BEST TO DIP." },
	{ VOICE_LINE_BALLAS, 100581, "BEST YOU TIP TOE OUTTA HERE." },
	{ VOICE_LINE_BALLAS, 100582, "WRONG HOOD!" },
	{ VOICE_LINE_BALLAS, 100585, "YOU A RIDER MY NIGGA? WHASS HAPENNIN?" },
	{ VOICE_LINE_BALLAS, 100587, "You know how this game goes." },
	{ VOICE_LINE_BALLAS, 100588, "I aint scared of you, you still a bitch!" },
	{ VOICE_LINE_BALLAS, 100590, "What y'all talking about?" },
	{ VOICE_LINE_BALLAS, 100593, "EY MAN YOU BETTER LEND ME A GUN UH?" },
	{ VOICE_LINE_BALLAS, 100596, "You dont wanna hurt no body, I dont wanna { hurt you." },
	{ VOICE_LINE_BALLAS, 100597, "We go head to head." },
	{ VOICE_LINE_BALLAS, 100598, "You better think for a second!" },
	{ VOICE_LINE_BALLAS, 100600, "Ah not this shit again! " },
	{ VOICE_LINE_BALLAS, 100601, "Damn back to the pen! " },
	{ VOICE_LINE_BALLAS, 100602, "This gotta be a set up! " },
	{ VOICE_LINE_BALLAS, 100603, "Alright y'all got me. " },
	{ VOICE_LINE_BALLAS, 100605, "GET HIM OUTTA THE CAR!" },
	{ VOICE_LINE_BALLAS, 100607, "OPEN THE DOOR!" },
	{ VOICE_LINE_BALLAS, 100609, "PUT IN SOME WORK, GET IN THERE RIGHT NOW! " },
	{ VOICE_LINE_BALLAS, 100611, "YOU HAVING A GOOD TIME NOW BITCH?" },
	{ VOICE_LINE_BALLAS, 100613, "Come holler at your homies biatch!" },
	{ VOICE_LINE_BALLAS, 100615, "EY MAN BUY ME A DRINK!" },
	{ VOICE_LINE_BALLAS, 100618, "I dont pay for nothing, im a baller!" },
	{ VOICE_LINE_BALLAS, 100620, "BOY! If i wasnt on parole!" },
	{ VOICE_LINE_BALLAS, 100621, "Oh now you blocking uh?" },
	{ VOICE_LINE_BALLAS, 100623, "you about to get penalized, thats a flag!" },
	{ VOICE_LINE_BALLAS, 100624, "oh you gonna block an og huh?" },
	{ VOICE_LINE_BALLAS, 100625, "GET OUT THE WAY! " },
	{ VOICE_LINE_BALLAS, 100627, "TOAST TO THE BOOGIE! " },
	{ VOICE_LINE_BALLAS, 100629, "Love these sour grapes " },
	{ VOICE_LINE_BALLAS, 100631, "Gimme some of that yay " },
	{ VOICE_LINE_BALLAS, 100635, "Ey you better watch yourself! " },
	{ VOICE_LINE_BALLAS, 100637, "BALLAS! FOOL!" },
	{ VOICE_LINE_BALLAS, 100639, "EY YOU TOO CLOSE, GIMME 5 FEET MAN." },
	{ VOICE_LINE_BALLAS, 100641, "EY PULL OVER! " },
	{ VOICE_LINE_BALLAS, 100643, "GROVE ST? WHERE YA GOIN?" },
	{ VOICE_LINE_BALLAS, 100644, "SHOOT THE TIRES OUT! " },
	{ VOICE_LINE_BALLAS, 100645, "EY BUST THE WINDOW " },
	{ VOICE_LINE_BALLAS, 100646, "STOMP/STOP HIM!" },
	{ VOICE_LINE_BALLAS, 100647, "Dont let that punk bitch get away! " },
	{ VOICE_LINE_BALLAS, 100649, "Ey where you going? Come back ere! " },
	{ VOICE_LINE_BALLAS, 100652, "I aint too old to catch you! " },
	{ VOICE_LINE_BALLAS, 100653, "Slow down! " },
	{ VOICE_LINE_BALLAS, 100656, "Ey where you going? I wanna be friends." },
	{ VOICE_LINE_BALLAS, 100658, "Disrespecting in my own hood?" },
	{ VOICE_LINE_BALLAS, 100659, "No respect at all." },
	{ VOICE_LINE_BALLAS, 100661, "Dope is killing this town, you know that! " },
	{ VOICE_LINE_BALLAS, 100662, "Damn drugs got everyone twisted! " },
	{ VOICE_LINE_BALLAS, 100665, "DO YOU HEAR ME? " },
	{ VOICE_LINE_BALLAS, 100666, "EY YOU KNOW WHO I AM? " },
	{ VOICE_LINE_BALLAS, 100667, "LISTEN UP! " },
	{ VOICE_LINE_BALLAS, 100668, "PAY ATTENTION YOU YOUNG PUNK" },
	{ VOICE_LINE_BALLAS, 100672, "MY SIGHTS ON HIM! " },
	{ VOICE_LINE_BALLAS, 100674, "You just hit my bike you buster! " },
	{ VOICE_LINE_BALLAS, 100675, "AH HELL NAH!" },
	{ VOICE_LINE_BALLAS, 100676, "FAUL BALL, DAMMIT! " },
	{ VOICE_LINE_BALLAS, 100677, "Thats your ass chump!" },
	{ VOICE_LINE_BALLAS, 100679, "MY CAR DAMN! " },
	{ VOICE_LINE_BALLAS, 100680, "MY FUCKING CAR!! " },
	{ VOICE_LINE_BALLAS, 100681, "CRACK MY CAR, I'LL CRACK YOUR NECK. " },
	{ VOICE_LINE_BALLAS, 100682, "MY RIDE FOOL! " },
	{ VOICE_LINE_BALLAS, 100683, "YOU BROKE IT? YOU FIX IT. " },
	{ VOICE_LINE_BALLAS, 100684, "EY MAN LEAVE ME ALONE MAN!" },
	{ VOICE_LINE_BALLAS, 100686, "IT WASNT ME I'M A BALLER!" },
	{ VOICE_LINE_BALLAS, 100689, "Use THE LINES YOU IDIOT!" },
	{ VOICE_LINE_BALLAS, 100694, "EY MANIAC!" },
	{ VOICE_LINE_BALLAS, 100696, "EY RAISE UP OUTTA OUR HOOD FOOL!" },
	{ VOICE_LINE_BALLAS, 100699, "Grove st dont roll through baller hood!" },
	{ VOICE_LINE_BALLAS, 100700, "EY EY LOOK! " },
	{ VOICE_LINE_BALLAS, 100702, "GET OUTTA MY HOOD YOU BITCH!" },
	{ VOICE_LINE_BALLAS, 100704, "GET OUT OF HERE GROVE ST!" },
	{ VOICE_LINE_BALLAS, 100706, "I dont need to crack, I want some chronic. " },
	{ VOICE_LINE_BALLAS, 100707, "Ey how much for that bag? " },
	{ VOICE_LINE_BALLAS, 100709, "Gimme like one zip man " },
	{ VOICE_LINE_BALLAS, 100710, "I'll take a half a zip " },
	{ VOICE_LINE_BALLAS, 100711, "Sandwich bag, aite thats cool. " },
	{ VOICE_LINE_BALLAS, 100713, "GET DOWN GET DOWN THEY DUMPIN " },
	{ VOICE_LINE_BALLAS, 100714, "WATCH OUT WATCH OUT WATCH OUT! " },
	{ VOICE_LINE_BALLAS, 100715, "EVERYBODY DUCK! " },
	{ VOICE_LINE_BALLAS, 100716, "DUCK FOOLS, GET DOWN THEY SHOOTIN! " },
	{ VOICE_LINE_BALLAS, 100717, "SHUT UP AND DUCK, THEY SHOOTIN! " },
	{ VOICE_LINE_BALLAS, 100719, "NOW YOU LEAKING! " },
	{ VOICE_LINE_BALLAS, 100720, "I PUT A HOLE IN YA UH? " },
	{ VOICE_LINE_BALLAS, 100722, "THATS HOT LED IN YA ASS! " },
	{ VOICE_LINE_BALLAS, 100723, "IMMA PUT ONE IN YOUR GUT! " },
	{ VOICE_LINE_BALLAS, 100726, "THATS A NICE ASS!" },
	{ VOICE_LINE_BALLAS, 100732, "COME GET SOME PUNK!" },
	{ VOICE_LINE_BALLAS, 100738, "COME ON, BITCH!" },
	{ VOICE_LINE_BALLAS, 100745, "These youngsters think they tough!" },
	{ VOICE_LINE_BALLAS, 100747, "Are you gang banging?" },
	{ VOICE_LINE_BALLAS, 100748, "EY FOOL, YOU BANG?" },
	{ VOICE_LINE_BALLAS, 100753, "I'LL MAKE YOU FAMOUS PEEWEE." },
	{ VOICE_LINE_BALLAS, 100755, "PUT IT DOWN, WE CAN SCRAP!" },
	{ VOICE_LINE_BALLAS, 100756, "CHILL, NO NEED FOR ALLA DAT!" },
	{ VOICE_LINE_BALLAS, 100761, "EY GET YOUR HANDS OFFA ME!" },
	{ VOICE_LINE_BALLAS, 100762, "BIG MISTAKE, YOU KNOW WHO I AM?" },
	{ VOICE_LINE_BALLAS, 100766, "THIS IS BALLA GANG, OG. " },
	{ VOICE_LINE_BALLAS, 100776, "FREEZE CHUMP! [gang]" },
	{ VOICE_LINE_BALLAS, 100779, "THIS IS A B' THANG, OG' THANG. " },
	{ VOICE_LINE_BALLAS, 100785, "EVERYBODY, MOVE IN! " },
	{ VOICE_LINE_BALLAS, 100786, "I GOT YOUR BACK, I GOT YOU COVERED! " },
	{ VOICE_LINE_BALLAS, 100793, "Look who's on the ground yo! " },
	{ VOICE_LINE_BALLAS, 100797, "Got to be a baller man not a bailer nigga! " },
	{ VOICE_LINE_BALLAS, 100802, "I didn't do nothing officer." },
	{ VOICE_LINE_BALLAS, 100803, "Man it was Grove Street not Ballas." },
	{ VOICE_LINE_BALLAS, 100812, "We homies now you're on our hood." },
	{ VOICE_LINE_BALLAS, 100820, "Yeah Ima put a sign this is Balla's border." },
	{ VOICE_LINE_BALLAS, 100823, "You busta' " },
	{ VOICE_LINE_BALLAS, 100825, "I shoul've buck yo ass punk!" },
	{ VOICE_LINE_BALLAS, 100828, "Mane what is this bottle liquor we drinkin' ?" },
	{ VOICE_LINE_BALLAS, 100829, "This tastes like SHIT'" },
	{ VOICE_LINE_BALLAS, 100832, "Gimme a drink on that." },
	{ VOICE_LINE_BALLAS, 100836, "Don't forget about your big homie." },
	{ VOICE_LINE_BALLAS, 100849, "Don't let that bitch escape." },
	{ VOICE_LINE_BALLAS, 100863, "Balla is taking out this town you know that ?" },
	{ VOICE_LINE_BALLAS, 100865, "Los Santos is a Ballas' Town." },
	{ VOICE_LINE_BALLAS, 100869, "Are you deaf ?" },
	{ VOICE_LINE_BALLAS, 100871, "Yeah you ! " },
	{ VOICE_LINE_BALLAS, 100872, "Over here you lil' mark." },
	{ VOICE_LINE_BALLAS, 100877, "Watch out Ima be the hero of the day." },
	{ VOICE_LINE_BALLAS, 100878, "I luv ma hood'." },
	{ VOICE_LINE_BALLAS, 100893, "You sucka ! " },
	{ VOICE_LINE_BALLAS, 100896, "Oh-. shit the police." },
	{ VOICE_LINE_BALLAS, 100899, "I didn't do shit to yall, I didn't do nothing." },
	{ VOICE_LINE_BALLAS, 100901, "Don't you have something better to do ? Go { have a donut.   " },
	{ VOICE_LINE_BALLAS, 100911, "What the fuck is they doing on our hood ?" },
	{ VOICE_LINE_BALLAS, 100925, "You should shut up ! " },
	{ VOICE_LINE_BALLAS, 100927, "What you expect to get against me huh punk ? " },
	{ VOICE_LINE_BALLAS, 100930, "You dead now BITCH!" },
	{ VOICE_LINE_BALLAS, 100931, "You still having fun gang-banging homie ?" },
	{ VOICE_LINE_BALLAS, 100933, "Whats going on baby, how you doing ?" },
	{ VOICE_LINE_BALLAS, 100934, "Where you been in all my life baby ?" },
	{ VOICE_LINE_BALLAS, 100936, "Do you know me ?" },
	{ VOICE_LINE_BALLAS, 100937, "The fuck you starin' at ?" },
	{ VOICE_LINE_BALLAS, 100938, "Man fuck you ! " },
	{ VOICE_LINE_BALLAS, 100947, "I ain't playing with you sucka! " },
	{ VOICE_LINE_BALLAS, 100949, "This is how I used to beat yo mama." },
	{ VOICE_LINE_BALLAS, 100956, "What set you from, speak up !?" },
	{ VOICE_LINE_BALLAS, 100957, "I'ma Baller homie, What are you ? " },
	{ VOICE_LINE_BALLAS, 100958, "Yeah Balla' 4 Life, What about you ?" },
	{ VOICE_LINE_BALLAS, 100959, "Ima Baller homie, Are you ? " },
	{ VOICE_LINE_BALLAS, 100966, "You can't kill me or there is gonna be war." },
	{ VOICE_LINE_BALLAS, 100967, "Don't turn this battle into a war homie." },
	{ VOICE_LINE_BALLAS, 100968, "Mane go and put that thing away mane." },
	{ VOICE_LINE_BALLAS, 100969, "Itchy trigger finger or what ? " },
	{ VOICE_LINE_BALLAS, 100976, "This is a B' ride busta'" },
	{ VOICE_LINE_BALLAS, 100984, "Somebody drop this fool." },
	{ VOICE_LINE_BALLAS, 100988, "You can't jack me mark, Ima BALLAS ! " }
} ;



new VL_Aztecas [ ] [ E_VOICELINE_DATA ] = {
	// VLA
	{ VOICE_LINE_VLA, 108406, "Ima blast on you pendejo" },
	{ VOICE_LINE_VLA, 108407, "Ballassos ivavossos pendejos " },
	{ VOICE_LINE_VLA, 108408, "I am gonna kill all the familias holmes " },
	{ VOICE_LINE_VLA, 108414, "V-L-A run your shit eh! " },
	{ VOICE_LINE_VLA, 108418, "Get the fuck outta here, South of the border!" },
	{ VOICE_LINE_VLA, 108419, "Get out of here pinche low lives!" },
	{ VOICE_LINE_VLA, 108421, "(Curse in Spanish)" },
	{ VOICE_LINE_VLA, 108426, "Don't lie officer you planted that! " },
	{ VOICE_LINE_VLA, 108425, "Get some feria then dirty Vagos " },
	{ VOICE_LINE_VLA, 108428, "I don't say nada, nada en nada  " },
	{ VOICE_LINE_VLA, 108429, "Hey dog I swear pcp made me do it." },
	{ VOICE_LINE_VLA, 108433, "Lets give this carro Azteca touch." },
	{ VOICE_LINE_VLA, 108443, "Hey CJ your sister was just here." },
	{ VOICE_LINE_VLA, 108540, "Officer I just say no I swear! " },
	{ VOICE_LINE_VLA, 108427, "Hey homie I don't know shit, I was too high { to remember " },
	{ VOICE_LINE_VLA, 108439, "Lets rock carlitos ! mundo." },
	{ VOICE_LINE_VLA, 108442, "Carlito peyasido perdito !" },
	{ VOICE_LINE_VLA, 108450, "I like to get slunky and drunk que no ?" },
	{ VOICE_LINE_VLA, 108451, "( Spanish )" },
	{ VOICE_LINE_VLA, 108453, "A pura te pendejo! " },
	{ VOICE_LINE_VLA, 108458, "Nah homie I can't forget about that." },
	{ VOICE_LINE_VLA, 108459, "Pistoo my favorite pass time mate!" },
	{ VOICE_LINE_VLA, 108460, "Ma homie help me find my needles." },
	{ VOICE_LINE_VLA, 108461, "Orale cerveza holmes ! " },
	{ VOICE_LINE_VLA, 108472, "Azteca this carro tascapando ! " },
	{ VOICE_LINE_VLA, 108481, "Hey homie you let them GO ! " },
	{ VOICE_LINE_VLA, 108482, "I am too high to chase this Puto ! " },
	{ VOICE_LINE_VLA, 108487, "Shoot them in the leg homie ! " },
	{ VOICE_LINE_VLA, 108489, "Hey homie I sniff crack all time sick." },
	{ VOICE_LINE_VLA, 108491, "Medicine gets me buzzed holmes' " },
	{ VOICE_LINE_VLA, 108493, " ( Spanish )" },
	{ VOICE_LINE_VLA, 108488, "I take naked photos of myself" },
	{ VOICE_LINE_VLA, 108490, "Ey homie I sniff markers all time sick" },
	{ VOICE_LINE_VLA, 108494, "Ay homie you attracthing them flies ! " },
	{ VOICE_LINE_VLA, 108495, "You dress like a leva holmes." },
	{ VOICE_LINE_VLA, 108498, "These shoes make you look like leva." },
	{ VOICE_LINE_VLA, 108499, "These patos are feo holmes." },
	{ VOICE_LINE_VLA, 108504, "There's so many got no heart wey'" },
	{ VOICE_LINE_VLA, 108515, "You dress like a star holmes." },
	{ VOICE_LINE_VLA, 108519, "Your patos are firmee ! " },
	{ VOICE_LINE_VLA, 108500, "Ay holmes I think your shoes are on crack." },
	{ VOICE_LINE_VLA, 108513, "Oralee what a ranfla!?" },
	{ VOICE_LINE_VLA, 108514, "Your carro gets all the hyenas, ese." },
	{ VOICE_LINE_VLA, 108434, "Lets make this carro bounce ese " },
	{ VOICE_LINE_VLA, 108435, "This carro rocking turns me on ! " },
	{ VOICE_LINE_VLA, 108521, "Ey homie can I get a pair of those ? " },
	{ VOICE_LINE_VLA, 108537, "I am high ese, whats your execuse ?" },
	{ VOICE_LINE_VLA, 108581, "I want to have gangbang with you and my { cliqa! " },
	{ VOICE_LINE_VLA, 108534, "You high holmes ? Cause I am." },
	{ VOICE_LINE_VLA, 108546, "Tu quidado ! " },
	{ VOICE_LINE_VLA, 108505, "You fear the Aztecas, ha chavala ? " },
	{ VOICE_LINE_VLA, 108578, "VLA putos ! Yas tuvo." },
	{ VOICE_LINE_VLA, 108506, "These pendejos always rank out" },
	{ VOICE_LINE_VLA, 108507, "We asked a question mochoso!" },
	{ VOICE_LINE_VLA, 108508, "There's so many afraid to die, que no ?" },
	{ VOICE_LINE_VLA, 108502, "Answer me then puto ! " },
	{ VOICE_LINE_VLA, 108418, "Get the fuck outta here south of the border" },
	{ VOICE_LINE_VLA, 108445, "You shoul've stayed North, cabron." },
	{ VOICE_LINE_VLA, 108510, "Maybe he's a ratta ese! " },
	{ VOICE_LINE_VLA, 108511, "Damn homie thats a sex machine" },
	{ VOICE_LINE_VLA, 108512, "Your ranfla is ruqa magnet wey'" },
	{ VOICE_LINE_VLA, 108540, "Officer I just say no, I swear!" },
	{ VOICE_LINE_VLA, 108553, "Oralee human sacrifice time!" },
	{ VOICE_LINE_VLA, 108487, "Shoot them in the leg homie" },
	{ VOICE_LINE_VLA, 108523, "Cover me carnales! " },
	{ VOICE_LINE_VLA, 108563, "Trucha, they shooting!" },
	{ VOICE_LINE_VLA, 108550, "Watchele ese! " },
	{ VOICE_LINE_VLA, 108568, "Duck Aztecas! " },
	{ VOICE_LINE_VLA, 108561, "Hey homie I want something for high tolarance { you know ?" },
	{ VOICE_LINE_VLA, 108562, "Hey homie you got something mota with the { coca holmes ?" },
	{ VOICE_LINE_VLA, 108563, "TRUCHA! They're shooting! " },
	{ VOICE_LINE_VLA, 108569, "Another blood sacrifice ese." },
	{ VOICE_LINE_VLA, 108572, "I told you this cuete doesn't miss!" },
	{ VOICE_LINE_VLA, 108574, "PCP tries again pendejo! " },
	{ VOICE_LINE_VLA, 108575, "I LOVE BUSTING ON OUR ENEMY!" },
	{ VOICE_LINE_VLA, 108579, "AZTECA EL CONTROLA TODO!" },
	{ VOICE_LINE_VLA, 108580, "I am looking for dirty bitch like you!" },
	{ VOICE_LINE_VLA, 108581, "I want to have gangbang with you and my cliqa!" },
	{ VOICE_LINE_VLA, 108591, "Hey homie you with the cliqa ey ?" },
	{ VOICE_LINE_VLA, 108592, "Who's your cliqa pendejo !?" },
	{ VOICE_LINE_VLA, 108598, "VLA cliqa you bang ?" },
	{ VOICE_LINE_VLA, 108599, "I jack off with guns ey." },
	{ VOICE_LINE_VLA, 108593, "Aztecas holmes you bang ? " },
	{ VOICE_LINE_VLA, 108536, "Ey homie I was just trying to masturbate ese { ! " },
	{ VOICE_LINE_VLA, 108805, "Its time for us to kick some Ballas ass  " },
	{ VOICE_LINE_VLA, 108801, "Pussy ass Ballas where you at ? " },
	{ VOICE_LINE_VLA, 108806, "Grove Street piece of shit! " },
	{ VOICE_LINE_VLA, 108808, "Grove Street sucks ass ! " },
	{ VOICE_LINE_VLA, 108814, "Aztecas gonna kick your Vagos ass! " },
	{ VOICE_LINE_VLA, 108820, "I did your mom last night." },
	{ VOICE_LINE_VLA, 108822, "Vagos ain't shit ! " },
	{ VOICE_LINE_VLA, 108815, "This is Azteca turf now ! " },
	{ VOICE_LINE_VLA, 108833, "Your life is over now." },
	{ VOICE_LINE_VLA, 108849, "I am in a mood for blood" },
	{ VOICE_LINE_VLA, 108839, "Kill them before the cops get here ! " },
	{ VOICE_LINE_VLA, 108855, "Learn how to drive." },
	{ VOICE_LINE_VLA, 108841, "Aztecas get em' " },
	{ VOICE_LINE_VLA, 108892, "Comeon we got em!" },
	{ VOICE_LINE_VLA, 108877, "You think you can get away from Los Aztecas ? " },
	{ VOICE_LINE_VLA, 108884, "Comeon and fight bitch ! " },
	{ VOICE_LINE_VLA, 108825, "I can't go back to jail man ! " },
	{ VOICE_LINE_VLA, 108854, "Outta my way man." },
	{ VOICE_LINE_VLA, 108955, "I always get busted for nothing" },
	{ VOICE_LINE_VLA, 108852, "You got logger beer in here ? " },
	{ VOICE_LINE_VLA, 108860, "Why can't anybody drive in this city ? " },
	{ VOICE_LINE_VLA, 108861, "Wish I had a cigarette too." },
	{ VOICE_LINE_VLA, 108863, "Ah surveza, nice." },
	{ VOICE_LINE_VLA, 108864, "Hey ese I am thirsty." },
	{ VOICE_LINE_VLA, 108876, "Your car is piece of shit." },
	{ VOICE_LINE_VLA, 108894, "Damn I need to work out" },
	{ VOICE_LINE_VLA, 108897, "The call of the streets is the most important { thing man." },
	{ VOICE_LINE_VLA, 108898, "I am sick from all these pussy ass bangers." },
	{ VOICE_LINE_VLA, 108899, "I am gonna retire early." },
	{ VOICE_LINE_VLA, 108900, "This city is going to hell but I can't leave." },
	{ VOICE_LINE_VLA, 108901, "Do your best to protect the Varrio you know." },
	{ VOICE_LINE_VLA, 108907, "Dude did your mama dress you ? " },
	{ VOICE_LINE_VLA, 108908, "These are some ugly clothes ese" },
	{ VOICE_LINE_VLA, 108928, "Ey vato you got some style." },
	{ VOICE_LINE_VLA, 108930, "Nice shoes ese" },
	{ VOICE_LINE_VLA, 108924, "That must get you a lot of chicks " },
	{ VOICE_LINE_VLA, 108913, "Hey man I am talking to you ! " },
	{ VOICE_LINE_VLA, 108949, "Whats your problem ?" },
	{ VOICE_LINE_VLA, 108917, "You deaf cabron ? " },
	{ VOICE_LINE_VLA, 108994, "Ese you better say you are sorry." },
	{ VOICE_LINE_VLA, 108967, "We won't hurt you we just kill you" },
	{ VOICE_LINE_VLA, 108935, "I am gonna get this cabron" },
	{ VOICE_LINE_VLA, 108936, "Somebody get my back! " },
	{ VOICE_LINE_VLA, 108938, "Oh my arm ! " },
	{ VOICE_LINE_VLA, 108976, "Get down ! " },
	{ VOICE_LINE_VLA, 108978, "Cover yourselve." },
	{ VOICE_LINE_VLA, 108989, "Yeah I got one ! " },
	{ VOICE_LINE_VLA, 108988, "Sleep well pendejo ! " },
	{ VOICE_LINE_VLA, 108993, "Hey mamasita you look good today! " },
	{ VOICE_LINE_VLA, 108999, "You roll with the gang ? " },
	{ VOICE_LINE_VLA, 109105, "You looking gangster, ese." },
	{ VOICE_LINE_VLA, 109107, "Woow, where did you get these kicks holmes' ? " },
	{ VOICE_LINE_VLA, 109110, "Cover me holmes." },
	{ VOICE_LINE_VLA, 109112, "I am counting on you holmes." },
	{ VOICE_LINE_VLA, 109115, "You wanna get hurt, HUH ?" },
	{ VOICE_LINE_VLA, 109120, "Look what did you do to my fuckin car." },
	{ VOICE_LINE_VLA, 109123, "I am gonna cut your fuckin throat ! " },
	{ VOICE_LINE_VLA, 109132, "I am innocent officer I swear to god." },
	{ VOICE_LINE_VLA, 109134, "Thats fucked up I didn't do nothing." },
	{ VOICE_LINE_VLA, 109135, "Officer comeon I am innocent." },
	{ VOICE_LINE_VLA, 109138, "You trying to kill me Loco ? " },
	{ VOICE_LINE_VLA, 109145, "Who the fuck you are ?" },
	{ VOICE_LINE_VLA, 109146, "Who the fuck you think you are ? " },
	{ VOICE_LINE_VLA, 109150, "Hey ese hook a homie up." },
	{ VOICE_LINE_VLA, 109151, "Hey ese you got this smoke ?" },
	{ VOICE_LINE_VLA, 109152, "MIERDA  Down ! " },
	{ VOICE_LINE_VLA, 109154, "MIERDA Watch out ! " },
	{ VOICE_LINE_VLA, 109156, "Come in this way !" },
	{ VOICE_LINE_VLA, 109168, "Woow nice ese ! " },
	{ VOICE_LINE_VLA, 109169, "He was in the wrong barrio ese." },
	{ VOICE_LINE_VLA, 109171, "Wohoo- Miha." },
	{ VOICE_LINE_VLA, 109174, "Check out big ass chica right there." },
	{ VOICE_LINE_VLA, 109186, "Who you with holmes ?" },
	{ VOICE_LINE_VLA, 109187, "You banging ese ? " },
	{ VOICE_LINE_VLA, 109192, "No lies ese who you with ? " },
	{ VOICE_LINE_VLA, 109197, "I am not afraid to die." },
	{ VOICE_LINE_VLA, 109198, "You know how to use that ese ?" },
	{ VOICE_LINE_VLA, 109199, "Puto you can't kill me." },
	{ VOICE_LINE_VLA, 109200, "Yall some squires! " },
	{ VOICE_LINE_VLA, 109201, "GANGSTA' " },
	{ VOICE_LINE_VLA, 109217, "Los Santos Assholes ! " },
	{ VOICE_LINE_VLA, 109218, "Fuckin Los Santos pussies ! " },
	{ VOICE_LINE_VLA, 109202, "Get out the here" },
	{ VOICE_LINE_VLA, 109203, "Man go back to your own hood" },
	{ VOICE_LINE_VLA, 109204, "You can't get down with the brown." },
	{ VOICE_LINE_VLA, 109205, "You want fight little man ? " },
	{ VOICE_LINE_VLA, 109206, "You want box or smoke rocks ?" },
	{ VOICE_LINE_VLA, 109211, "( Curse in Spanish ) " },
	{ VOICE_LINE_VLA, 109212, "( Curse in Spanish )" },
	{ VOICE_LINE_VLA, 109213, "( Curse in Spanish )" },
	{ VOICE_LINE_VLA, 10214 , "( Curse in Spanish )" },
	{ VOICE_LINE_VLA, 109226, "It must be worked on somethin to let me go." },
	{ VOICE_LINE_VLA, 109207, "You want some trouble little man ? " },
	{ VOICE_LINE_VLA, 109354, "Get outta here little man" },
	{ VOICE_LINE_VLA, 109364, "Ay man you know where the fuck you are ? " },
	{ VOICE_LINE_VLA, 109351, "Leva ! " },
	{ VOICE_LINE_VLA, 109377, "Stupid dickheads ! " },
	{ VOICE_LINE_VLA, 109224, "Man I ain't going back to that shithole !" },
	{ VOICE_LINE_VLA, 109227, "Can't we just settle this down with the check { ? " },
	{ VOICE_LINE_VLA, 109340, "Comeon man do I look like criminal ? " },
	{ VOICE_LINE_VLA, 109228, "Get the carrucha ! " },
	{ VOICE_LINE_VLA, 109240, "Grab that bastard !" },
	{ VOICE_LINE_VLA, 109274, "Get that ugly piece of shit ! " },
	{ VOICE_LINE_VLA, 109286, "You cowards." },
	{ VOICE_LINE_VLA, 109242, "I am gonna kill yo ass" },
	{ VOICE_LINE_VLA, 109246, "So sick of you puto ! " },
	{ VOICE_LINE_VLA, 109247, "Ey they charge so much for drinks around here" },
	{ VOICE_LINE_VLA, 109248, "Man this place is a rip off." },
	{ VOICE_LINE_VLA, 109252, "This city is killing me" },
	{ VOICE_LINE_VLA, 109256, "I gotta go" },
	{ VOICE_LINE_VLA, 109257, "Woow thats some good shit ! " },
	{ VOICE_LINE_VLA, 109260, "I need a drago homie" },
	{ VOICE_LINE_VLA, 109261, "Its time for me to get drunk." },
	{ VOICE_LINE_VLA, 109295, "Man were did you get that from the junkyard ? " },
	{ VOICE_LINE_VLA, 109297, "That car looks worse than it smells" },
	{ VOICE_LINE_VLA, 109311, "Man that car is fat homie" },
	{ VOICE_LINE_VLA, 109298, "I hope you didn't pay too much for that pants." },
	{ VOICE_LINE_VLA, 109314, "Man these are some hot clothes mane." },
	{ VOICE_LINE_VLA, 109316, "Man nothing like a hot style ese." },
	{ VOICE_LINE_VLA, 109303, "Man you look like you have these shoes from { WW2" },
	{ VOICE_LINE_VLA, 109335, "Ay you fucked up my car" },
	{ VOICE_LINE_VLA, 109349, "Puto driver" },
	{ VOICE_LINE_VLA, 109337, "Nothing is safe in this Varrio" },
	{ VOICE_LINE_VLA, 109338, "Another maniac in this varrio.. Great." },
	{ VOICE_LINE_VLA, 109368, "Ay man you got some white paint ?" },
	{ VOICE_LINE_VLA, 109382, "Nice shooting ese" },
	{ VOICE_LINE_VLA, 109393, "Damn you fine" },
	{ VOICE_LINE_VLA, 109305, "Think twice before you don't answer" },
	{ VOICE_LINE_VLA, 109307, "You can't be that stupid" },
	{ VOICE_LINE_VLA, 109320, "Ey watch my back homie" },
	{ VOICE_LINE_VLA, 109324, "Ey keep me covered" },
	{ VOICE_LINE_VLA, 109323, "Hold that puto down" },
	{ VOICE_LINE_VLA, 109369, "Get down ! " },
	{ VOICE_LINE_VLA, 109370, "Drop em" },
	{ VOICE_LINE_VLA, 109259, "Goes down one !  " },
	{ VOICE_LINE_VLA, 109321, "Cover Ma' Ass ! " },
	{ VOICE_LINE_VLA, 109339, "This shit keep happenin around here." },
	{ VOICE_LINE_VLA, 109390, "Thats incredible." },
	{ VOICE_LINE_VLA, 109331, "I am gonna teach you the value of the money { puto!" },
	{ VOICE_LINE_VLA, 109336, "Why don't I have more feria to live." },
	{ VOICE_LINE_VLA, 109339, "This shit' keeps happening around here." },
	{ VOICE_LINE_VLA, 109343, "I am not some pedo, cabron!" },
	{ VOICE_LINE_VLA, 109356, "Just keep to the pedal to the medal!" },
	{ VOICE_LINE_VLA, 106205, " (Spanish)" },
	{ VOICE_LINE_VLA, 106225, " (Spanish)" },
	{ VOICE_LINE_VLA, 106227, " (Spanish)" },
	{ VOICE_LINE_VLA, 106232, " (Spanish)" },
	{ VOICE_LINE_VLA, 106233, " (Spanish)" },
	{ VOICE_LINE_VLA, 104129, " (Spanish)" },
	{ VOICE_LINE_VLA, 104222, " (Spanish)" },
	{ VOICE_LINE_VLA, 104223, " (Spanish)" },
	{ VOICE_LINE_VLA, 104225, " (Spanish)" },
	{ VOICE_LINE_VLA, 104263, " (Spanish)" },
	{ VOICE_LINE_VLA, 104267, " (Spanish)" },
	{ VOICE_LINE_VLA, 106247, " (Spanish)" },
	{ VOICE_LINE_VLA, 106248, " (Spanish)" },
	{ VOICE_LINE_VLA, 106252, " (Spanish)" },
	{ VOICE_LINE_VLA, 106254, " (Spanish)" }
} ;



new VL_Vagos [ ] [ E_VOICELINE_DATA ] = {
	// Vagos
	{ VOICE_LINE_VAGOS, 103800, "Adios Amigos ! " },
	{ VOICE_LINE_VAGOS, 103801, "You dead now BRO! " },
	{ VOICE_LINE_VAGOS, 103805, "Adios ENEMIGAS!" },
	{ VOICE_LINE_VAGOS, 103807, "You going to hell, BITCH." },
	{ VOICE_LINE_VAGOS, 103809, "Man fuck the Ballas." },
	{ VOICE_LINE_VAGOS, 103810, "There's no way out man, Ima kill EVERYBODY." },
	{ VOICE_LINE_VAGOS, 103814, "Grove Street Families going down ! " },
	{ VOICE_LINE_VAGOS, 103816, "We gonna take over Grove Street Turf ! " },
	{ VOICE_LINE_VAGOS, 103817, "GROVE STREET KILLA ! " },
	{ VOICE_LINE_VAGOS, 103822, "Whats up ? You want sum step up." },
	{ VOICE_LINE_VAGOS, 103823, "(Spanish)" },
	{ VOICE_LINE_VAGOS, 103825, "Man fuck your Varrio!" },
	{ VOICE_LINE_VAGOS, 103826, "Man this is Santos Vagos ! " },
	{ VOICE_LINE_VAGOS, 103827, "Fuck Varrios Los Aztecas ! " },
	{ VOICE_LINE_VAGOS, 103828, "Ima fuck you up ! " },
	{ VOICE_LINE_VAGOS, 103829, "Santos Vagos 4 Life ! " },
	{ VOICE_LINE_VAGOS, 103830, "Ima fuck up your Varrio man ! " },
	{ VOICE_LINE_VAGOS, 103832, "You shouldn't have fucked with Santos Vagos ! " },
	{ VOICE_LINE_VAGOS, 103833, "You got the wrong guy !! " },
	{ VOICE_LINE_VAGOS, 103834, "It wasn't ME ! " },
	{ VOICE_LINE_VAGOS, 103835, "Do I look like a Criminal ? " },
	{ VOICE_LINE_VAGOS, 103836, "Do I look like I done anything ? " },
	{ VOICE_LINE_VAGOS, 103837, "Fuck off man, comeon homies lets gets this { punk ! " },
	{ VOICE_LINE_VAGOS, 103845, "We gonna fuck you up Grove Streets mother { fuckers!" },
	{ VOICE_LINE_VAGOS, 103846, "Santos Vagos will fuck you up ! " },
	{ VOICE_LINE_VAGOS, 103853, "PENDEJO ! " },
	{ VOICE_LINE_VAGOS, 103859, "Uhh, fucked up now." },
	{ VOICE_LINE_VAGOS, 103860, "Oooo- sweet, sweet liquor." },
	{ VOICE_LINE_VAGOS, 103861, "Paradise baro BABY." },
	{ VOICE_LINE_VAGOS, 103864, "Little bit of that will relax me." },
	{ VOICE_LINE_VAGOS, 103866, "Yo hook me up bro, whats up ?" },
	{ VOICE_LINE_VAGOS, 103877, "Man you better get fuck outta here man! " },
	{ VOICE_LINE_VAGOS, 103884, "You better start running ! " },
	{ VOICE_LINE_VAGOS, 103895, "Man hyenas loving my big biceps." },
	{ VOICE_LINE_VAGOS, 103894, "Look at me flex ! " },
	{ VOICE_LINE_VAGOS, 103896, "Los Santos is full with pussies with no honor." },
	{ VOICE_LINE_VAGOS, 103898, "Man bitches like me cause I protect them." },
	{ VOICE_LINE_VAGOS, 103900, "Pinche cochinero." },
	{ VOICE_LINE_VAGOS, 103903, "Man these are some ugly ass clothes ! " },
	{ VOICE_LINE_VAGOS, 103904, "Man your clothes make you look like little { bitch ese ! " },
	{ VOICE_LINE_VAGOS, 103906, "Damn bro your shoes STINK! " },
	{ VOICE_LINE_VAGOS, 103909, "Whats up puto you can hear me ? " },
	{ VOICE_LINE_VAGOS, 103910, "I am talking to you bitch !? " },
	{ VOICE_LINE_VAGOS, 103912, "Are you ignoring me ? " },
	{ VOICE_LINE_VAGOS, 103913, "You should show me some respect in my barrio." },
	{ VOICE_LINE_VAGOS, 103914, "You better answer me back you little bitch ! " },
	{ VOICE_LINE_VAGOS, 103917, "Was that what ? NOW, fuck you up ! " },
	{ VOICE_LINE_VAGOS, 103918, "Hey thats a nice car man ! " },
	{ VOICE_LINE_VAGOS, 103920, "Big carro, for a BIG man ! " },
	{ VOICE_LINE_VAGOS, 103921, "Thats a nice shirt ese." },
	{ VOICE_LINE_VAGOS, 103923, "Man these are some nice kicks ese." },
	{ VOICE_LINE_VAGOS, 103924, "(Spanish)" },
	{ VOICE_LINE_VAGOS, 103927, "Pin em down bro we will fuck these fools up." },
	{ VOICE_LINE_VAGOS, 103929, "Yo man watch my back! " },
	{ VOICE_LINE_VAGOS, 103931, "Cover me ! " },
	{ VOICE_LINE_VAGOS, 103938, "Ay cabron, MI CARRO !!" },
	{ VOICE_LINE_VAGOS, 104000, "Check out them Ballas DICK-HEADS ! " },
	{ VOICE_LINE_VAGOS, 104001, "You're not man, you pussies ! " },
	{ VOICE_LINE_VAGOS, 104004, "Dos por Ballas bitches ! " },
	{ VOICE_LINE_VAGOS, 104005, "You want to start some shit with the Vagos ?" },
	{ VOICE_LINE_VAGOS, 104006, "Vagos gonna fuck you up ! " },
	{ VOICE_LINE_VAGOS, 104007, "What chu lookin at cabron ! " },
	{ VOICE_LINE_VAGOS, 104008, "I am loco Balla killer numero UNO! " },
	{ VOICE_LINE_VAGOS, 104009, "Ballas AIN'T shit ! " },
	{ VOICE_LINE_VAGOS, 104011, "Grove Street smells like pussy ! " },
	{ VOICE_LINE_VAGOS, 104012, "You Grove ass bitches !" },
	{ VOICE_LINE_VAGOS, 104013, "You got no balls to fight me! " },
	{ VOICE_LINE_VAGOS, 104014, "Made in MEXICO ! You dick heads." },
	{ VOICE_LINE_VAGOS, 104015, "Don't be afraid you little bitches ! " },
	{ VOICE_LINE_VAGOS, 104016, "Fuck Grove Street ! " },
	{ VOICE_LINE_VAGOS, 104017, "You levas are going down ! " },
	{ VOICE_LINE_VAGOS, 104019, "Ima fuck you up and your whole family ! " },
	{ VOICE_LINE_VAGOS, 104021, "Hey asshole, FUCK YOU ! " },
	{ VOICE_LINE_VAGOS, 104022, "You assholes think this is a game ? " },
	{ VOICE_LINE_VAGOS, 104024, "I am gonna paralyze all you cock suckers ! " },
	{ VOICE_LINE_VAGOS, 104027, "Get back over the border gringo ! " },
	{ VOICE_LINE_VAGOS, 104029, "Come on puto lets start some gerra ! " },
	{ VOICE_LINE_VAGOS, 104031, "You levas better run." },
	{ VOICE_LINE_VAGOS, 104033, "You better run holmes ! " },
	{ VOICE_LINE_VAGOS, 104034, "Fuckin Chavalas ! " },
	{ VOICE_LINE_VAGOS, 104036, "Aztecas are pussies ! " },
	{ VOICE_LINE_VAGOS, 104037, "Aztecas are going down ! " },
	{ VOICE_LINE_VAGOS, 104038, "Santos Vagos gonna fuck you up." },
	{ VOICE_LINE_VAGOS, 104039, "Officer,officer let me explain !" },
	{ VOICE_LINE_VAGOS, 104042, "I fuckin hate cops ! " },
	{ VOICE_LINE_VAGOS, 104050, "This is what happens when you FUCK with the { Vagos ! " },
	{ VOICE_LINE_VAGOS, 104053, "I'll show you who you messing with mother { fucker ! " },
	{ VOICE_LINE_VAGOS, 104055, "Out of the FUCKIN car ! " },
	{ VOICE_LINE_VAGOS, 104066, "Ugh.. this tastes like horse piss." },
	{ VOICE_LINE_VAGOS, 104067, "This part is full of pendejos.." },
	{ VOICE_LINE_VAGOS, 104068, "Check out that guy in strappos." },
	{ VOICE_LINE_VAGOS, 104069, "Juras are behind the Vago !" },
	{ VOICE_LINE_VAGOS, 104071, "Que pues whats the hold up !? " },
	{ VOICE_LINE_VAGOS, 104075, "Ese, I just stole some shit." },
	{ VOICE_LINE_VAGOS, 104076, "Thanks ese." },
	{ VOICE_LINE_VAGOS, 104077, "Yeahh, thats what I needed." },
	{ VOICE_LINE_VAGOS, 104078, "Maan, I was thirsty." },
	{ VOICE_LINE_VAGOS, 104079, "Hey ese I am thirsty." },
	{ VOICE_LINE_VAGOS, 104081, "Lets get fuckin drunk, ese." },
	{ VOICE_LINE_VAGOS, 104090, "Stop the car ! " },
	{ VOICE_LINE_VAGOS, 104093, "I am gonna get you mother fucker ! " },
	{ VOICE_LINE_VAGOS, 104097, "I better not get my hands on you." },
	{ VOICE_LINE_VAGOS, 104098, "Thats why I'll never walk again." },
	{ VOICE_LINE_VAGOS, 104099, "There's still bullet stuck in my head, ese." },
	{ VOICE_LINE_VAGOS, 104101, "I'll shoot my bitch if she gets fatter." },
	{ VOICE_LINE_VAGOS, 104103, "All that Clucking Bell is making me fat." },
	{ VOICE_LINE_VAGOS, 104105, "You will never get pussy in that shit." },
	{ VOICE_LINE_VAGOS, 104107, "Hey ese yo mama dressed you ? " },
	{ VOICE_LINE_VAGOS, 104108, "Hey ese your shoes are piece of shit ! " },
	{ VOICE_LINE_VAGOS, 104110, "You disrespecting me ? " },
	{ VOICE_LINE_VAGOS, 104113, "I asked you a question boy." },
	{ VOICE_LINE_VAGOS, 104117, "Get the fuck back here! " },
	{ VOICE_LINE_VAGOS, 104118, "Heey, nice wheels my friend." },
	{ VOICE_LINE_VAGOS, 104119, "Heey, that car looks expensive ! " },
	{ VOICE_LINE_VAGOS, 104121, "Hey man nice clothes." },
	{ VOICE_LINE_VAGOS, 104122, "Nice trappos ma man." },
	{ VOICE_LINE_VAGOS, 104124, "Hey ese I like your sapattos." },
	{ VOICE_LINE_VAGOS, 104137, "Mi ranfla ! " },
	{ VOICE_LINE_VAGOS, 104140, "What the shit ese." },
	{ VOICE_LINE_VAGOS, 104141, "I just shot them by accident man." },
	{ VOICE_LINE_VAGOS, 104145, "Watch out ese ! " },
	{ VOICE_LINE_VAGOS, 104147, "What the FUCK ! " },
	{ VOICE_LINE_VAGOS, 104151, "You are at the wrong part of the town ese." },
	{ VOICE_LINE_VAGOS, 104152, "Turn back and get the fuck outta here." },
	{ VOICE_LINE_VAGOS, 104155, "You trespassing ese." },
	{ VOICE_LINE_VAGOS, 104157, "You better go back to your own neighborhood { ese." },
	{ VOICE_LINE_VAGOS, 104159, "You don't belong here." },
	{ VOICE_LINE_VAGOS, 104160, "What Are you lost ? " },
	{ VOICE_LINE_VAGOS, 104166, "Hey ese I wanna get HIGH! " },
	{ VOICE_LINE_VAGOS, 104167, "Yo ese hook it up." },
	{ VOICE_LINE_VAGOS, 104169, "Yeahh ! Vagos 4 Life." },
	{ VOICE_LINE_VAGOS, 104170, "Maan I need a smoke now." },
	{ VOICE_LINE_VAGOS, 104171, "Fuck ese! How many of them did we kill ?  " },
	{ VOICE_LINE_VAGOS, 104172, "Lets get outta here before the cops come here." },
	{ VOICE_LINE_VAGOS, 104173, "Shiit look at all the blood ! " },
	{ VOICE_LINE_VAGOS, 104175, "I got blood on my shoes ese." },
	{ VOICE_LINE_VAGOS, 104177, "You vatos weren't lucky today." },
	{ VOICE_LINE_VAGOS, 104179, "Yeah we FUCKED all of you up ! " },
	{ VOICE_LINE_VAGOS, 104180, "Vagos is KING ! " },
	{ VOICE_LINE_VAGOS, 104181, "Daamn you're good looking hyena!" },
	{ VOICE_LINE_VAGOS, 104182, "Daamn good looking mami ! " },
	{ VOICE_LINE_VAGOS, 104195, "You bang ese ? " },
	{ VOICE_LINE_VAGOS, 104198, "I am fucking Vagos, bitch who the hell are { you ? " },
	{ VOICE_LINE_VAGOS, 104202, "Ballasos, biggest victim of East Los ! " },
	{ VOICE_LINE_VAGOS, 104204, "You Ballasos are BITCHES for Aztecas ! " },
	{ VOICE_LINE_VAGOS, 104205, "I heard Ballasos are getting smoked by V-L-A ?" },
	{ VOICE_LINE_VAGOS, 104207, "Ballasos use my cuete like a chupete, homie." },
	{ VOICE_LINE_VAGOS, 104208, "My cuete makes you dance ! " },
	{ VOICE_LINE_VAGOS, 104211, "Ganton Familia get killed by Ballas ! " },
	{ VOICE_LINE_VAGOS, 104212, "Stay out of the East Los payasidos ! " },
	{ VOICE_LINE_VAGOS, 104216, "Grove Street AIN'T SHIT ! " },
	{ VOICE_LINE_VAGOS, 104232, "Yeah homie whatever you say copper." },
	{ VOICE_LINE_VAGOS, 104233, "Orale grab that pinche fool." },
	{ VOICE_LINE_VAGOS, 104236, "Orale lets make this macoso bleed !" },
	{ VOICE_LINE_VAGOS, 104248, "Cliqa Vagos ! You canton cabrones ?" },
	{ VOICE_LINE_VAGOS, 104252, "(Spanish)" },
	{ VOICE_LINE_VAGOS, 104266, "Firme carnal, Thanks homie." },
	{ VOICE_LINE_VAGOS, 104269, "Hey comeon give me that holmes." },
	{ VOICE_LINE_VAGOS, 104270, "Hey give me that damn bottle holmes!" },
	{ VOICE_LINE_VAGOS, 104286, "Wait holmes we just wanna talk que no ? " },
	{ VOICE_LINE_VAGOS, 104291, "Why you running cowarde ? " },
	{ VOICE_LINE_VAGOS, 104295, "Wait, we were joking que no ? " },
	{ VOICE_LINE_VAGOS, 104298, "Vagos was killing' so I joined." },
	{ VOICE_LINE_VAGOS, 104301, "East L-S is my hunting ground holmes." },
	{ VOICE_LINE_VAGOS, 104304, "I hide bodies in that carrucha." },
	{ VOICE_LINE_VAGOS, 104309, "These are funeral shoes puto." },
	{ VOICE_LINE_VAGOS, 104312, "You're not down for your hood puto ?" },
	{ VOICE_LINE_VAGOS, 104313, "You're some kind like a ratta cabron ? " },
	{ VOICE_LINE_VAGOS, 104315, "Maybe you are a snitching ratta que no ? " },
	{ VOICE_LINE_VAGOS, 104318, "Ahh your carro keep flirting with me." },
	{ VOICE_LINE_VAGOS, 104322, "I kill for these clothes holmes." },
	{ VOICE_LINE_VAGOS, 104323, "Nice style holmes." },
	{ VOICE_LINE_VAGOS, 104326, "Firme sapattos ese, nice shoes." },
	{ VOICE_LINE_VAGOS, 104327, "COVER ME VAGO ! " },
	{ VOICE_LINE_VAGOS, 104329, "COVER ME ESE ! " },
	{ VOICE_LINE_VAGOS, 104331, "You can't stop me ! " },
	{ VOICE_LINE_VAGOS, 104334, "(Spanish)" },
	{ VOICE_LINE_VAGOS, 104352, "Those were for some self defence holmes." },
	{ VOICE_LINE_VAGOS, 104353, "I cut off my finger prints jura." },
	{ VOICE_LINE_VAGOS, 104356, "You miss cabron ! " },
	{ VOICE_LINE_VAGOS, 104364, "You know where you at ? " },
	{ VOICE_LINE_VAGOS, 104368, "Another body to drop ! " },
	{ VOICE_LINE_VAGOS, 104376, "Comeon holmes I need that shit right now { holmes." },
	{ VOICE_LINE_VAGOS, 104378, "Trucha ! He's got a cuete." },
	{ VOICE_LINE_VAGOS, 104379, "Duck holmes ! " },
	{ VOICE_LINE_VAGOS, 104381, "Vagos ! He's shooting." },
	{ VOICE_LINE_VAGOS, 10104383, "Muerto ! How I like em' ese." },
	{ VOICE_LINE_VAGOS, 104386, "Till I die, everyone else does." },
	{ VOICE_LINE_VAGOS, 104391, "I think I see his spirit que no ? " },
	{ VOICE_LINE_VAGOS, 104394, "Don't worry I only kill putas." },
	{ VOICE_LINE_VAGOS, 104396, "Hey where are you looking at holmes." },
	{ VOICE_LINE_VAGOS, 104397, "Hey you know me ese ? " },
	{ VOICE_LINE_VAGOS, 104398, "Hey are we friends holmes ? " },
	{ VOICE_LINE_VAGOS, 101012, "Vagos, Vamos!" },
	{ VOICE_LINE_VAGOS, 106205, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106225, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106227, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106232, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106233, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 104129, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 104222, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 104223, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 104225, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 104263, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 104267, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106247, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106248, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106252, " (Spanish)" },
	{ VOICE_LINE_VAGOS, 106254, " (Spanish)" }
} ;

new VL_LSPD [ ] [ E_VOICELINE_DATA ] = {
	{ VOICE_LINE_LSPD, 10800, "This doesn't concern you." } ,
	{ VOICE_LINE_LSPD, 10803, "Don't push me son." } ,
	{ VOICE_LINE_LSPD, 10811, "Did anybody frisk that guy ?" } ,
	{ VOICE_LINE_LSPD, 10829, "Beat him up a little huh ?" } ,
	{ VOICE_LINE_LSPD, 51003, "Tel it to the judge homeboy." } ,
	{ VOICE_LINE_LSPD, 51026, "My wife, in a sex sandwich!" } ,
	{ VOICE_LINE_LSPD, 51042, "Slow down civilian!" } ,
	{ VOICE_LINE_LSPD, 51058, "I'll kick your cuckolding ass!" } ,
	{ VOICE_LINE_LSPD, 50655, "Thanks for helping me, making streets clean." } ,
	{ VOICE_LINE_LSPD, 50667, "Suicide by cop, is that what you after ?" } ,
	{ VOICE_LINE_LSPD, 50669, "Shit! I think he went down here." } ,
	{ VOICE_LINE_LSPD, 50661, "Where the hell did he go." } ,
	{ VOICE_LINE_LSPD, 50662, "Argh- where the hell this son of a bitch go! " } ,
	{ VOICE_LINE_LSPD, 50642, "Respect the law!" } ,
	{ VOICE_LINE_LSPD, 50643, "Woooo-. man down! man down! " } ,
	{ VOICE_LINE_LSPD, 50621, "I got him spotted, I got him spotted! " } ,
	{ VOICE_LINE_LSPD, 50646, "We have a shooter, requesting all units! " } ,
	{ VOICE_LINE_LSPD, 50658, "CAN I GET SOME GOD DAMN COVER !?" } ,
	{ VOICE_LINE_LSPD, 50656, "Cover me boys I am going in! " } ,
	{ VOICE_LINE_LSPD, 50623, "I need cover, back me up!" } ,
	{ VOICE_LINE_LSPD, 50620, "Take him down on sight! " } ,
	{ VOICE_LINE_LSPD, 50608, "I am po-po, pissed off police officer!" } ,
	{ VOICE_LINE_LSPD, 53800, "At last I got you, you shit! " } ,
	{ VOICE_LINE_LSPD, 53801, "Get down, and stay down! " } ,
	{ VOICE_LINE_LSPD, 53802, "About time, you son of a bitch!" } ,
	{ VOICE_LINE_LSPD, 53803, "Somethings' going right... for once." } ,
	{ VOICE_LINE_LSPD, 51060, "You should join the force." } ,
	{ VOICE_LINE_LSPD, 53805, "You know your right, right ?" } ,
	{ VOICE_LINE_LSPD, 53910, "There's no where for you to go son of a bitch." } ,
	{ VOICE_LINE_LSPD, 53807, "You're BUSTED asshole!" } ,
	{ VOICE_LINE_LSPD, 53809, "Thought you can get away with breaking the law ?" } ,
	{ VOICE_LINE_LSPD, 53812, "We gonna have fun with you at the station." } ,
	{ VOICE_LINE_LSPD, 53814, "Move your vehicle! " } ,
	{ VOICE_LINE_LSPD, 53815, "Clear the road! " } ,
	{ VOICE_LINE_LSPD, 53817, "You stopping police bussines! " } ,
	{ VOICE_LINE_LSPD, 53819, "You looking to be taken in ?" } ,
	{ VOICE_LINE_LSPD, 53822, "You like guys in uniform or something ?" } ,
	{ VOICE_LINE_LSPD, 53823, "You wanna grab my pistol ?" } ,
	{ VOICE_LINE_LSPD, 53826, "You wanna experience some police brutality ?" } ,
	{ VOICE_LINE_LSPD, 53908, "Get in and TAKE OUT the enemy!" } ,
	{ VOICE_LINE_LSPD, 53928, "We got you surrounded !" } ,
	{ VOICE_LINE_LSPD, 53827, "GET BACK HERE, SON OF A BITCH!" } ,
	{ VOICE_LINE_LSPD, 53845, "COVER ME GUYS I AM GOING IN!" } ,
	{ VOICE_LINE_LSPD, 53847, "COVER ME! " } ,
	{ VOICE_LINE_LSPD, 53878, "GET DOWN!" } ,
	{ VOICE_LINE_LSPD, 53874, "EVERYONE WATCH OUT!" } ,
	{ VOICE_LINE_LSPD, 53877, "EVERYBODY HIT THE FLOOR!" } ,
	{ VOICE_LINE_LSPD, 53905, "SOMEONE SHOOT THAT GUY!" } ,
	{ VOICE_LINE_LSPD, 53907, "SHOOT HIM DAMMIT, SHOOT HIM!" } ,
	{ VOICE_LINE_LSPD, 53912, "OFFICER IN NEED OF ASSISTANCE!" } ,
	{ VOICE_LINE_LSPD, 53922, "STOP GOD DAMMIT, STOP!" } ,
	{ VOICE_LINE_LSPD, 53869, "ARREST THAT GUY! " } ,
	{ VOICE_LINE_LSPD, 53831, "Argh-. damn! " } ,
	{ VOICE_LINE_LSPD, 53832, "Somebody stop that guy ! " } ,
	{ VOICE_LINE_LSPD, 53835, "I am gonna get you, you BASTARD! " } ,
	{ VOICE_LINE_LSPD, 53837, "I told her, you ain't getting the kids." } ,
	{ VOICE_LINE_LSPD, 53839, "Nothing goes right for me these days." } ,
	{ VOICE_LINE_LSPD, 53841, "Save lives better when you're single.. I don't know." } ,
	{ VOICE_LINE_LSPD, 53854, "You gonna pay the price for that." } ,
	{ VOICE_LINE_LSPD, 53858, "Hey watch the car! Dick face." } ,
	{ VOICE_LINE_LSPD, 53864, "You're in trouble now, mister." } ,
	{ VOICE_LINE_LSPD, 53923, "Alright pal, you going nowhere." } ,
	{ VOICE_LINE_LSPD, 53872, "I am risking my life here!" } ,
	{ VOICE_LINE_LSPD, 53892, "Good job." } ,
	{ VOICE_LINE_LSPD, 53893, "You saved me the effort." } ,
	{ VOICE_LINE_LSPD, 53894, "Thanks man, I owe ya." } ,
	{ VOICE_LINE_LSPD, 53896, "Go on, shoot! " } ,
	{ VOICE_LINE_LSPD, 53897, "Can't hurt more than divorce." } ,
	{ VOICE_LINE_LSPD, 53898, "You got license for that thing ?" } ,
	{ VOICE_LINE_LSPD, 53901, "You know you should take the safety off." } ,
	{ VOICE_LINE_LSPD, 53902, "I got bigger gun than that." } ,
	{ VOICE_LINE_LSPD, 53914, "I gave up with the gym, when my wife left." } ,
	{ VOICE_LINE_LSPD, 53927, "Time for a gang bang." } ,
	{ VOICE_LINE_LSPD, 53937, "I am sticking my pistol in your mouth." } ,
	{ VOICE_LINE_LSPD, 53939, "Somebody looks like they gonna shit their pants." } ,
	{ VOICE_LINE_LSPD, 54200, "GIVE ME SOME COVER HERE!" } ,
	{ VOICE_LINE_LSPD, 54203, "Check my back buddy!" } ,
	{ VOICE_LINE_LSPD, 54205, "Return fire I am going in!" } ,
	{ VOICE_LINE_LSPD, 54207, "He's trying to kill me!" } ,
	{ VOICE_LINE_LSPD, 54211, "He's trying to run me down, SHOOT HIM!" } ,
	{ VOICE_LINE_LSPD, 54213, "Jesus.. GET DOWN!" } ,
	{ VOICE_LINE_LSPD, 54215, "Heads down! " } ,
	{ VOICE_LINE_LSPD, 54217, "We're getting shot at here!" } ,
	{ VOICE_LINE_LSPD, 54223, "UnIT 7 GOING IN!" } ,
	{ VOICE_LINE_LSPD, 54224, "Okey boys GO GO GO GO!" } ,
	{ VOICE_LINE_LSPD, 54226, "COME-ON RETURN FIRE, RETURN FIRE! " } ,
	{ VOICE_LINE_LSPD, 54227, "S.W.A.T Team, Coming in !" } ,
	{ VOICE_LINE_LSPD, 54228, "Keep looking." } ,
	{ VOICE_LINE_LSPD, 54229, "Scumbags hiding near some place." } ,
	{ VOICE_LINE_LSPD, 54231, "I know he's here, watching us." } ,
	{ VOICE_LINE_LSPD, 54232, "Take a look up that way." } ,
	{ VOICE_LINE_LSPD, 54237, "We got you now kid." } ,
	{ VOICE_LINE_LSPD, 54238, "Comeon give up last chance." } ,
	{ VOICE_LINE_LSPD, 54242, "Tango inside ! " } ,
	{ VOICE_LINE_LSPD, 53600, "You have rights to stay silent" } ,
	{ VOICE_LINE_LSPD, 53601, "Tell me about your childhood." } ,
	{ VOICE_LINE_LSPD, 53602, "I feel your pain." } ,
	{ VOICE_LINE_LSPD, 53603, "Did your parents fight a lot ?" } ,
	{ VOICE_LINE_LSPD, 53604, "We can work out therapist schedules later." } ,
	{ VOICE_LINE_LSPD, 53608, "This might be so hard for you." } ,
	{ VOICE_LINE_LSPD, 53609, "Sucks you got caught." } ,
	{ VOICE_LINE_LSPD, 53611, "Promise you call me if you feel suicidal." } ,
	{ VOICE_LINE_LSPD, 53615, "Take yout time, no rush." } ,
	{ VOICE_LINE_LSPD, 53616, "Is something wrong, can I help ?" } ,
	{ VOICE_LINE_LSPD, 53618, "Did you hurt yourself ?" }
} ;
 
Voiceline_GetDescription(soundid, desc [ ], len = sizeof ( desc )) {
	new bool: found = false ;

	for ( new i, j = sizeof ( VL_Families ); i < j ; i ++ ) {

		if ( VL_Families [ i ] [ E_VOICELINE_ID ] == soundid ) {

			format ( desc, len, "%s", VL_Families [ i ] [ E_VOICELINE_DESC ] ) ;
			found = true ;
		}

		else continue ;
	}

	for ( new i, j = sizeof ( VL_Ballas ); i < j ; i ++ ) {

		if ( VL_Ballas [ i ] [ E_VOICELINE_ID ] == soundid ) {

			format ( desc, len, "%s", VL_Ballas [ i ] [ E_VOICELINE_DESC ] ) ;
			found = true ;
		}

		else continue ;
	}

	for ( new i, j = sizeof ( VL_Aztecas ); i < j ; i ++ ) {

		if ( VL_Aztecas [ i ] [ E_VOICELINE_ID ] == soundid ) {

			format ( desc, len, "%s", VL_Aztecas [ i ] [ E_VOICELINE_DESC ] ) ;
			found = true ;
		}

		else continue ;
	}

	for ( new i, j = sizeof ( VL_Vagos ); i < j ; i ++ ) {

		if ( VL_Vagos [ i ] [ E_VOICELINE_ID ] == soundid ) {

			format ( desc, len, "%s", VL_Vagos [ i ] [ E_VOICELINE_DESC ] ) ;
			found = true ;
		}

		else continue ;
	}


	for ( new i, j = sizeof ( VL_LSPD ); i < j ; i ++ ) {

		if ( VL_LSPD [ i ] [ E_VOICELINE_ID ] == soundid ) {

			format ( desc, len, "%s", VL_LSPD [ i ] [ E_VOICELINE_DESC ] ) ;
			found = true ;
		}

		else continue ;
	}

	if ( ! found ) {

		format ( desc, len, "Invalid" ) ;
	}
}

SaveVoicelines(playerid) {

	new query [ 1024 ] ;

	mysql_format(mysql, query, sizeof ( query ), "UPDATE characters SET player_vl_slot_0 = %d, player_vl_slot_1 = %d, player_vl_slot_2 = %d,\
		player_vl_slot_3 = %d, player_vl_slot_4 = %d, player_vl_slot_5 = %d, player_vl_slot_6 = %d, player_vl_slot_7 = %d, player_vl_slot_8 = %d,\
		player_vl_slot_9 = %d WHERE player_id = %d", 

		Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ],
		Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ],
		Character [ playerid ] [ E_CHARACTER_ID ]
	) ;

	mysql_tquery(mysql, query);
	return true ;
}


CMD:vl(playerid, params[]) {

	new slot, idx ;

	if ( sscanf ( params, "i", slot ) ) {

		return SendClientMessage(playerid, -1, "/vl [slot] - use /myvoices") ;
	}

	switch ( slot ) {

		case 1: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 2: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 3: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 4: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 5: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 6: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 7: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 8: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 9: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}
		case 10: {

			idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ] ;

			if ( idx ) {

				PlayPlayerVoiceline ( playerid, idx ) ;
			}

			else return SendClientMessage(playerid, -1, "This voiceline slot is empty!" ) ;
		}

		default: {

			return SendClientMessage(playerid, -1, "The slot you entered is invalid." ) ;
		}
	}


	return true ;
}

CMD:myvoices(playerid, params[]) {

	SendClientMessage(playerid, COLOR_BLUE, "Stored voicelines (from /voicelines)" ) ;

	new idx, desc [ 64 ], string [ 128 ] ;

	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 1: %d (%s)\n",  idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 1: None\n" ) ;

	SendClientMessage(playerid, COLOR_GRAD0, string);
	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 2: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 2: None\n" );

	SendClientMessage(playerid, COLOR_GRAD1, string);
	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 3: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 3: None\n" );

	SendClientMessage(playerid, COLOR_GRAD0, string);
	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 4: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 4: None\n" );

	SendClientMessage(playerid, COLOR_GRAD1, string);

	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 5: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 5: None\n" );

	SendClientMessage(playerid, COLOR_GRAD0, string);
	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 6: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 6: None\n" );

	SendClientMessage(playerid, COLOR_GRAD1, string);
	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 7: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 7: None\n" );
	SendClientMessage(playerid, COLOR_GRAD0, string);

	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 8: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 8: None\n" );

	SendClientMessage(playerid, COLOR_GRAD1, string);

	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
		format ( string, sizeof ( string ), "Slot 9: %d (%s)\n", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 9: None\n" );

	SendClientMessage(playerid, COLOR_GRAD0, string);

	if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ] ) {
		idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ] ;
		Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;

		format ( string, sizeof ( string ), "Slot 10: %d (%s)", idx, desc ) ;
	}
	else format ( string, sizeof ( string ), "Slot 10: None" );

	SendClientMessage(playerid, COLOR_GRAD1, string);

	return true ;
}

CMD:voicelines(playerid, params[]) {

	inline voiceline_select(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		if ( response ) {
			if (PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {
				SendClientMessage(playerid, COLOR_YELLOW, sprintf("You've left of at page %d.", PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) ) ;
				PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] = 0 ;
			}
			Voicelines_List ( playerid, listitem ) ;
		}

	}

	Dialog_ShowCallback ( playerid, using inline voiceline_select, DIALOG_STYLE_LIST, 
		"Voicelines: Select Gang", "Families\nBallas\nAztecas\nVagos\nPolice", "Proceed", "Back" ) ;

	return true ;
}

Voicelines_List(playerid, choice ) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] == 0 ) {
		PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] = 1 ;
	}



	// Pagination stuff
	new MAX_ITEMS_ON_PAGE = 10, string [ 1024 ], bool: nextpage ;
    new resultcount = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) - MAX_ITEMS_ON_PAGE ) ;


    strcat(string, "Description\n");

    if ( choice == 0 ) {

	 	for ( new i = resultcount, j = sizeof ( VL_Families ); i < j; i ++ ) {

			resultcount ++ ;

	        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {

	        	format(string, sizeof(string), "%s%s\n", string, VL_Families [ i ] [ E_VOICELINE_DESC ]); 
	        }

	     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {
	     		nextpage = true; break;
	     	} 
		}
	}

    if ( choice == 1 ) {

	 	for ( new i = resultcount, j = sizeof ( VL_Ballas ); i < j; i ++ ) {

			resultcount ++ ;

	        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {

	        	format(string, sizeof(string), "%s%s\n", string, VL_Ballas [ i ] [ E_VOICELINE_DESC ]); 
	        }

	     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {
	     		nextpage = true; break;
	     	} 
		}
	}

    if ( choice == 2 ) {

	 	for ( new i = resultcount, j = sizeof ( VL_Aztecas ); i < j; i ++ ) {

			resultcount ++ ;

	        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {

	        	format(string, sizeof(string), "%s%s\n", string, VL_Aztecas [ i ] [ E_VOICELINE_DESC ]); 
	        }

	     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {
	     		nextpage = true; break;
	     	} 
		}
	}

    if ( choice == 3 ) {

	 	for ( new i = resultcount, j = sizeof ( VL_Vagos ); i < j; i ++ ) {

			resultcount ++ ;

	        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {

	        	format(string, sizeof(string), "%s%s\n", string, VL_Vagos [ i ] [ E_VOICELINE_DESC ]); 
	        }

	     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {
	     		nextpage = true; break;
	     	} 
		}
	}
    if ( choice == 4 ) {

	 	for ( new i = resultcount, j = sizeof ( VL_LSPD ); i < j; i ++ ) {

			resultcount ++ ;

	        if ( resultcount <= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {

	        	format(string, sizeof(string), "%s%s\n", string, VL_LSPD [ i ] [ E_VOICELINE_DESC ]); 
	        }

	     	if ( resultcount >= MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) {
	     		nextpage = true; break;
	     	} 
		}
	}

	new pages = floatround ( resultcount / MAX_ITEMS_ON_PAGE, floatround_floor ) + 1 ;

    if ( nextpage ) {
    	strcat(string, "Next Page >>" ) ;
    }


	inline voicelines_list(pid, dialogid, response, listitem, string: inputtext[]) {
		#pragma unused pid, dialogid, inputtext

		new selection = ( ( MAX_ITEMS_ON_PAGE * PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ) - MAX_ITEMS_ON_PAGE ) + listitem;

		if ( ! response ) {

			if ( PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] > 1 ) {

				PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] -- ;
				return Voicelines_List(playerid, choice);
			}

			else return true ;
		}

		if ( response ) {

			if ( listitem >= MAX_ITEMS_ON_PAGE) {

				PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] ++ ;
				return Voicelines_List(playerid, choice);
			}

			else if ( listitem < MAX_ITEMS_ON_PAGE ) {

				new idx, desc [ 64 ] ;

				inline voicelines_menu(pidx, dialogidx, responsex, listitemx, string: inputtextx[]) {
					#pragma unused pidx, dialogidx, inputtextx

					if ( responsex ) {

						if ( listitemx == 0 ) {
							switch ( choice ) {

								case 0: PlayPlayerVoiceline(playerid, 	VL_Families [ selection ] 	[ E_VOICELINE_ID ] );
								case 1: PlayPlayerVoiceline(playerid,	VL_Ballas 	[ selection ] 	[ E_VOICELINE_ID ] );
								case 2: PlayPlayerVoiceline(playerid,	VL_Aztecas 	[ selection ] 	[ E_VOICELINE_ID ] );
								case 3: PlayPlayerVoiceline(playerid,	VL_Vagos 	[ selection ] 	[ E_VOICELINE_ID ] );
								case 4: PlayPlayerVoiceline(playerid,	VL_LSPD 	[ selection ] 	[ E_VOICELINE_ID ] );
							}
						}

						else if ( listitemx == 1 ) {

							inline voicelines_store(pidy, dialogidy, responsey, listitemy, string: inputtexty[]) {
								#pragma unused pidy, dialogidy, inputtexty

								if ( responsey ) {

									switch ( choice ) {

										case 0: idx = 	VL_Families [ selection ] [ E_VOICELINE_ID ] ;
										case 1: idx = 	VL_Ballas 	[ selection ] [ E_VOICELINE_ID ] ;
										case 2: idx = 	VL_Aztecas 	[ selection ] [ E_VOICELINE_ID ] ;
										case 3: idx = 	VL_Vagos 	[ selection ] [ E_VOICELINE_ID ] ;
										case 4: idx = 	VL_LSPD 	[ selection ] [ E_VOICELINE_ID ] ;
									}

									switch ( listitemy ) {

										case 0: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 1.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ], desc ) ) ;
										}
										case 1: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 2.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ], desc ) ) ;
										}
										case 2: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 3.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ], desc ) ) ;
										}
										case 3: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 4.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ], desc ) ) ;
										}
										case 4: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 5.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ], desc ) ) ;
										}
										case 5: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 6.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ], desc ) ) ;
										}
										case 6: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 7.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ], desc ) ) ;
										}
										case 7: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 8.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ], desc ) ) ;
										}
										case 8: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 9.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ], desc ) ) ;
										}
										case 9: {
											Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
											Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ] = idx ;

											SendClientMessage(playerid, -1, sprintf("Stored voiceline %d \"%s\" in slot 10.", 
												Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ], desc ) ) ;
										}
									}

									SaveVoicelines(playerid) ;
								}
							}

							string [ 0 ] = EOS ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_0 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "Slot 1: %d (%s)\n",  idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "Slot 1: None\n" ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_1 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 2: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 2: None\n", string ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_2 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 3: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 3: None\n", string ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_3 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 4: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 4: None\n", string ) ;
							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_4 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 5: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 5: None\n", string ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_5 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 6: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 6: None\n", string ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_6 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 7: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 7: None\n", string ) ;
							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_7 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 8: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 8: None\n", string ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_8 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;
								format ( string, sizeof ( string ), "%sSlot 9: %d (%s)\n",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 9: None\n", string ) ;

							if ( Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ] ) {
								idx = Character [ playerid ] [ E_CHARACTER_VL_SLOT_9 ] ;
								Voiceline_GetDescription ( idx, desc, sizeof ( desc ) ) ;

								format ( string, sizeof ( string ), "%sSlot 10: %d (%s)",  string, idx, desc ) ;
							}
							else format ( string, sizeof ( string ), "%sSlot 10: None", string ) ;

							Dialog_ShowCallback ( playerid, using inline voicelines_store, DIALOG_STYLE_LIST, "Voicelines: Store (select any row to replace it)", string, "Select", "Previous" ) ;
						}
					}
				}

				Dialog_ShowCallback ( playerid, using inline voicelines_menu, DIALOG_STYLE_LIST, "Voicelines: Menu", "Play Voiceline\nStore Voiceline", "Select", "Previous" ) ;


 				return true ;
			}
		}
	}

	if ( PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ] > 1 ) {
		Dialog_ShowCallback ( playerid, using inline voicelines_list, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Voicelines: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ], pages), string, "Select", "Previous" ) ;
	}

	else Dialog_ShowCallback ( playerid, using inline voicelines_list, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Voicelines: Page %d of %d", PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_PAGE ], pages), string, "Select", "Back" ) ;

	return true ;
}


#define VOICELINE_LOCAL_COLOR	( 0xC4DDB9FF )
#define VOICELINE_COOLDOWN_TIME 10

PlayPlayerVoiceline(playerid, voiceid) {

	if ( PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_COOLDOWN ] && (gettime() - PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_COOLDOWN ]) < VOICELINE_COOLDOWN_TIME )
	{
		return SendClientMessage(playerid, 0xC4DD89FF, "You must wait before playing another voice line.");
	}

	new text [ 128 ] ;

	Voiceline_GetDescription ( voiceid, text, sizeof ( text ) ) ;
	PlayerPlaySoundEx(playerid, voiceid ) ;

	new string [ 256 ]  ;

	// No tag color
	//format ( string, sizeof ( string ), "* %s says: %s", ReturnTagName(playerid, "C4DDB9"), text ) ;
	//ProxDetector ( playerid, 20.0, VOICELINE_LOCAL_COLOR, string );

	// With tag color
	//format ( name, sizeof ( name ), "* %s", ReturnTagName ( playerid ) ) ;
	//format ( string, sizeof ( string ), " says: %s", text ) ;
	//ProxDetectorNameTag(playerid, 15.0, 0xC4DDB9FF, name, string);


	format ( string, sizeof ( string ), "* %s{C4DD89} says: %s", ReturnMixedName ( playerid ), text ) ;
	SetPlayerChatBubble(playerid, string, 0xC4DD89FF, 15.0, 5000 ) ;

	format ( string, sizeof ( string ), "> %s{C4DD89} says: %s", ReturnMixedName ( playerid ), text ) ;
	SendClientMessage(playerid, 0xC4DD89FF, string);

	PlayerVar [ playerid ] [ E_PLAYER_VOICELINE_COOLDOWN ] = gettime();

	return true ;
}		

PlayerPlaySoundEx(playerid, sound, Float:range=20.0)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) {
		if ( Character [ i ] [ E_CHARACTER_VOICELINE_SOUND] ) {

			if (IsPlayerInRangeOfPoint(i, range, x, y, z)) {
		   	 	PlayerPlaySound(i, sound, x, y, z);
		   	}
		}
	}
	return 1;
}


/*
Cesar Vialpando:

101400: Ballas fools! 
101402: Ballas perros! 
101547: Ballas cabrones!
101404: Chavalas Vagos! 
101405: (Curse in Spanish)
101407: Pendejo Vagos Idiotas! 
101587: L-S-V PUTAS! 
101409: Mi vida loca! 
101411: Maan you got the wrong guy.
101421: Heyy move out of the road! 
101422: Whats the problem wey'
101423: Out of the way cabrones! 
101427: Watch where you going eh.
101431: Trying to start something eh?
101432: Don't fuck with me!
101443: Keep it going holmes.
101453: Oh shit man! 
101455: Man cops will get all over us!
101457: Hey did you know that guy?
101462: I can see my house from up here! 
101469: Juras are on our case ese! 
101475: Well we're on a A-P-B for sure holmes.
101477: Nice low profile stats holmes.
101408: Step on it ese.
101487: Varrios Los Aztecas will never die! 
101490: There's some nice people in the Varrios man.
101491: Gonna build me a new hopper.
101493: North Side have no heart man.
101499: Keep your stupid heads down! 
101525: Take cover! 
101528: Hey hit the dirt holmes! 
101500: I am moving COVER ME! 
101501: Keep them busy! 
101503: Arghh- Fuck!
101509: You are in trouble now eh.
101512: (Curse in Spanish)
101513: (Curse in Spanish)
101514: Another BAD fuckin day! 
101515: FUCK YOU CHOTA! 
101517: Varrios gonna get you man! 
101518: I am innocent holmes! 
101533: I am gonna cut you up holmes!
101535: I am gonna snap your bones man! 
101536: YOU MESSING WITH THE AZTECAS! 
101537: Real tough guy eh ?
101538: You think you tough huh holmes ?
101539: Comeon holmes hit me fucker! 
101540: Eh holmes we cool huh ?
101541: Ey ese put it away.
101544: Stick it up your ass.
101547: Big mistake idiota.
101548: You looking for trouble ?
101550: What the fuck ?
101553: I know your face puta! 
101554: Aztecas gonna catch up with you.
101557: Get the fuck out of the car holmes.
101559: Run if you don't want trouble eh.
101581: Wanna bullet in your balls ?
101584: (Talking in Spanish)


Sweet Johnson


/play 107600 "Ey Balla fools!"
/play 107601 "Balla bitches"
/play 107602 "Step up Balla bitches"
/play 107610 "The fuck you doing man?"
/play 107613 "Hol'on homie!"
/play 107620 "You got'a prob'?"
/play 107621 "You wanna say sum'?"
/play 107638 "Lets roll!"
/play 107641 "Slow down, fool."
/play 107673 "Watch out!"
/play 107679 "Heads down!"
/play 107682 "Get down!"
/play 107684 "Time to beat up another fool"
/play 107685 "You dead meat"
/play 107686 "Im talking to you mother fucker"
/play 107687 "Taste my knuckles"
/play 107690 "You think you can take me?"
/play 107692 "You think you can take me?"
/play 107693 "You think you are killa?"
/play 107698 "Break ya self, fool!"
/play 107701 "Nice try, but not today"
/play 107702 "Wrong move mofoka"
/play 107708 "Time to die, balla bitch"
/play 107709 "Pop those Ball-sucks"
/play 107710 "Grove Street justice!"
/play 107715 "You think you are OG, huh?"
/play 107719  "You want the whole clip?"
/play 107724 "Die mother fucker, die!"
/play 107725 "Man, you made the biggest misstake"



Alejandro Bortolo ( My character ;D )
106403 : Hey Pinches!
106404 : Where do you think u going pendejo! 
106406 : Yeahh Keep Trying!
106411 : You guys are all bitches ! 
109415 : I am beating this shit up to the grouuund ! 
106417 : Burn this shit mother fuckers comeon ! 
106419 : Welcome to hell bitch! 
106427 : I am getting drunk tonight
106429 : Move it Pendejo! 
106433 : Move bitch get out the way ! 
106437 . Fuck I wanted this shit.. 
106435 : Comeon! 
106440 : Ey tengor se Ese
106439 : Gimme sip of that carnal 
106458 : Hey come back here bitch 
106468 : Where the fuck did u get these car from 
106470 : Shit you fire man
11006475: Those shoes are mierda! 
106477 : Don't be ignore me mother fucker
106488 : Cover me ese fuck ! 
106490 : Watch out mother fuckers ! 
106511 : Pinche Cabron ! 
106514 : You are at the wrong side of the town homie.
106517 : Get the fuck outta here homie 
106523 : Comeon gimme some of that fire 
106532: See you in hell pinche puto!
106534: No more banging for you cabron!
106535 : Lights out puto ! 
106553 : What barrio you from ?
106584 : Go go go go 
106599 : Whats happenin beautiful ? 
106465: My gang is like my family homie.
106466: I need something to sip on man! 
106478: I know you hear me.
106480: Nice carrucha you got there man.
106484: Hey nice gear man.
106486: I looove them kicks homie! 
106497: Come here bitch! 
106518: This is my Varrio! 
106520: Fuckin levas!
106539: Daamn girl you fine! 
106552: Ey ey homie, do you gang bang ?


More Voices for both LSV&VLA

105602: Got some laundry to give your parents.
105603: You loading your cuete with rice ?
105607: Fine! Throw me in the pinta.
105610: Pinche animales! 
105614: Lets get them carnals! 
105620: You pendejos better defend yourselves! 
105621: You just gonna sit there like bunch of fools ?
105624: Give you whole new perspective!
105638: I hate this place and everything.
105644: I don't have any miha to visit anyways.
105649: This your canton or something cabron ?
105652: Thanks, I needed it bad.
105653: Give me some more I forgot to taste already.
105656: Give me a sip or preaper to die.
105666: Face me like a hombre then! 
105667: Thats how we do it here.
105675: I'll chase you forever.
105683: Is there something wrong with me ?
105684: I am so sick of masturbating.
105685: I only trust mi ranfla now.
105687: I wish I was born in a dead body.
105688: There's no point to anything.
105691: Since you don't use your ears, do you mind If I cut them off ?
105708: Where there's everything bad happening to me.
105720: I am a pintero man, PINTERO! 
105739: Come here, let me show you my meth.
105740: Its a good barrio right ?
105744: Get down, the fool gone wild.
105762: The animales should pay us for this shit.
105764: You remind me of my old miha!
105765: You can help me to get hyena.
105770: I have nothing to lose cabron.
105773: You gonna learn how shitty life is ese.
105777: I am gonna go LOCO on you my friend.
105779: You a gangbanger mane ?
105783: You in some cliqa mayne ?
105791: You gonna be a banger when you grow up cabron ?
105792: I don't care if you pull the trigger.
105794: Mi ex-miha wants to have cuete like that.
105796: You look like a puto holding that.
105799: I won't fight back if you promise to kill me.





 



*/