#define KEYMASTER_DESC "A queer device that allows one to purchase and access expensive private residences in far off locations. It's a little too enthusiastic - and LOUD - about serving its function."

/obj/item/roguemachine/keymaster
	name = "KEYMASTER"
	desc = KEYMASTER_DESC
	icon = 'modular_ochrevalley/icons/misc/machines.dmi'
	icon_state = "keymaster"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	/// Associated list of which ckeys have how much money stored here, storing money on a per-client basis. This allows multiple players to use the KEYMASTER without worrying about overlapping money from others.
	///
	/// Key is the player's ckey, value is the amount of mammon stored by that player
	var/list/stored_money
	/// Is this KEYMASTER intended to be used by wretches (AKA it SHOULD be in the wretch coast)?
	var/for_wretches = FALSE
	/// A list of lines that the KEYMASTER will yell when it successfully creates a portal.
	var/list/portal_lines = list(
		"THY PORTAL ART READY! PRITHEE, TAKE BUT ONE STEP WITHIN TO TRAVEL FAR BEYOND!!",
		"I HATH RENT A GATEWAY FOR THEE! THY DESTINATION AWAITS!!",
		"FOR THEE, YONDER PORTAL!! THY TRAVEL, STREAMLINED!! THE DISTANCE BETWEEN ME'S CUT FROM MILES TO INCHES IN ONE CLEAVE!!",
		"THE ME OF THERE HAS SPOKEN WITH THE ME OF HERE!! WE HATH AGREED TO YIELD TO THEE A PORTAL!!",
		"FOR THEE; A DOOR WHERE THERE WAS MOTES AGO AIR!! ON ITS OTHER SIDE; SANCTUARY!!",
		"A PORTAL HATH BEEN OPENED FOR THEE!! WAHOO!!"
	)
	/// An alternative list of lines that the wretch coast variant of the KEYMASTER will yell when it successfully creates a portal.
	var/list/portal_lines_wretches = list(
		"HERE IS YOUR PORTAL. GET IN BEFORE I HAVE TO LISTEN TO THE ME ON THE OTHER SIDE PRATTLE FURTHER.",
		"YEP, THAT KEY SEEMS GOOD ENOUGH TO ME. HERE'S YOUR PORTAL. BRING YOUR FRIENDS. OR DON'T.",
		"I CAN CLEAVE THROUGH DISTANCE ITSELF, CREATING A MAGICK DISTORTION OF THE SPACE BETWEEN THE ME OF HERE AND THE ME OF THERE. I AM A MARVEL OF ARTIFICING. AND THIS IS HOW I AM BEING USED. JOY. ANYWAYS, YOUR PORTAL IS READY.",
		"A GATEWAY OPENS. MAYBE IT'S FOR THE SANCTUARY OF THE KEY YOU USED. MAYBE IT'S ME TAKING YOU SOMEWHERE DIFFERENT ALTOGETHER. YOU DON'T KNOW FOR SURE UNLESS YOU STEP THROUGH. HA HA. I AM JUST KIDDING; IT LEADS TO THE PROPER SANCTUARY. PROBABLY.",
		"PORTAL. ONE MINUTE. DON'T FEEL LIKE SAYING MORE.",
	)

/obj/item/roguemachine/keymaster/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(!user)
		return
	var/datum/sanctuary_data/D = SSremote_sanctuaries.get_claimed_sanctuary(user.ckey)
	if(!D)
		purchase_sanctuary(user, "naledi_home")
	else if(D.spare_keys_remaining > 0)
		D.spare_keys_remaining--
		var/obj/item/roguekey/remote_sanctuary/K = regurgitate_key(user)
		playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
		user.put_in_hands(K)
	else
		playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
		if(for_wretches)
			say("NO MORE... I REFUSE TO COUGH UP ANY MORE SPARE KEYS FOR YOU.")
		else
			say("MINE APOLOGIES, DISCERNER, BUT I CANST NOT PROVIDE THEE WITH ANY MORE SPARE KEYS!!")



/obj/item/roguemachine/keymaster/Initialize(mapload)
	. = ..()
	if(for_wretches)
		SSremote_sanctuaries.keymaster_wretchcoast = src
	else
		SSremote_sanctuaries.keymaster_town = src

/obj/item/roguemachine/keymaster/attackby(obj/item/I, mob/user, params)
	. = ..()
	var/obj/item/roguekey/remote_sanctuary/K = I
	if(K)
		user.visible_message(span_notice("\The [user] sticks the pronged teeth of [K] against [src]. Its glassy surface begins to glow and swirl..."), span_notice("I stick the pronged teeth of [K] against [src]. Its glassy surface begins to glow and swirl..."))
		if(do_after(user, 5 SECONDS, target = src))
			key_act(user, K.sanctuary_owner_ckey)

/obj/item/roguemachine/keymaster/proc/purchase_sanctuary(mob/living/carbon/human/user, sanctuary_id)
	// We first spawn the key in nullspace to ensure that a lockhash with its ID exists before
	// the player's sanctuary is generated. This way all the lockable things in there will be
	// usable with the key!
	var/obj/item/roguekey/remote_sanctuary/key = regurgitate_key(user)
	var/datum/sanctuary_data/data = SSremote_sanctuaries.claim_sanctuary(user, sanctuary_id, for_wretches)
	user.put_in_hands(key)
	playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
	if(for_wretches)
		keymaster_say(pick(data.used_template.purchase_lines_wretch))
	else
		keymaster_say(pick(data.used_template.purchase_lines))

/// Dispenses a key to the user
/obj/item/roguemachine/keymaster/proc/regurgitate_key(mob/living/carbon/human/user)
	var/obj/item/roguekey/remote_sanctuary/key = new(null, user)
	return key

/obj/item/roguemachine/keymaster/proc/key_act(mob/living/carbon/human/user, sanctuary_owner_ckey)
	var/datum/sanctuary_data/D = SSremote_sanctuaries.get_claimed_sanctuary(sanctuary_owner_ckey)
	if(for_wretches && !D.is_wretch_made())
		say("THAT KEY WASN'T FORGED BY ME. I CAN'T ACCESS ITS SANCTUARY, FOOL. SHOW IT TO THE OTHER, LOUDER, MORE ANNOYING ORB IN TOWN.")
		playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
		return
	if(!for_wretches && D.is_wretch_made())
		say("HUH!! I DOTH NOT RECOGNIZE THIS KEY!! MINE APOLOGIES, BUT I CANNOT TAKE THEE TO A SANCTUARY WHOSE KEY I DID NOT FORGE!!")
		playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
		return
	var/portal_attempt = SSremote_sanctuaries.try_create_portals(sanctuary_owner_ckey)
	if(isnum(portal_attempt))
		switch(portal_attempt)
			if(SANCTUARY_PORTAL_SUCCESSFUL)
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
				if(for_wretches)
					keymaster_say(pick(portal_lines_wretches))
				else
					keymaster_say(pick(portal_lines))
			if(SANCTUARY_PORTAL_ERROR_OBSTRUCTEDTURFS)
				say("AN ISSUE ARISES: THE SANCTUARY HATH TOO MANY OBSTRUCTIONS AROUND MINE ORB ON THE OTHER SIDE! I CANST NOT CONJURE A PORTAL FOR THEE UNTIL THE SPACE IS CLEARED!! MINE APOLOGIES!!")
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
			if(SANCTUARY_PORTAL_ERROR_MOBSINWAY)
				say("AN ISSUE ARISES: THE SANCTUARY HATH TOO MANY LIVING MEATBAGS IN THE WAY! I CANST NOT CONJURE A PORTAL FOR THEE UNTIL THEY MOVE!! WAIT UNTIL THEY MOVE AND TRY AGAIN!!")
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
			if(SANCTUARY_PORTAL_ERROR_PORTALSALREADYEXIST)
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
				if(for_wretches)
					say("THERE'S ALREADY AN OPEN PORTAL LEADING TO THAT SANCTUARY. IT'S RIGHT HERE NEXT TO US, FOOL.")
				else
					say("UH. SIRE, THERE ART ALREADY A PORTAL TO THAT SANCTUARY NEXT TO US!!")

/obj/item/roguemachine/keymaster/proc/keymaster_say(var/line)
	var/soundfile = pick('sound/misc/machinetalk.ogg', 'sound/misc/machinelong.ogg')
	playsound(loc, soundfile, 100, TRUE, -1)
	say(line)

/// This variant just exists to specify that it's meant to be the OTHER keymaster located in the wretch coast
/obj/item/roguemachine/keymaster/wretch_coast
	for_wretches = TRUE

/// KEYMASTER variant that exists to take the player back out of a sanctuary.
/obj/item/roguemachine/keymaster_exit
	name = "KEYMASTER"
	desc = KEYMASTER_DESC
	icon = 'modular_ochrevalley/icons/misc/machines.dmi'
	icon_state = "keymaster"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	/// Data of the sanctuary we belong to.
	var/datum/sanctuary_data/data
	var/list/portal_lines = list(
		"I HOPE THOU HATH ENJOYED THY STAY!!",
		"THE PORTAL BACK HATH OPENED!!",
		"A GATEWAY FROM WHENCE THOU CAME!",
		"PRITHEE, TREAD CAREFULLY THROUGH YONDER PORTAL!!",
	)
	var/list/portal_lines_wretches = list(
		"LEAVING SO SOON? ALRIGHT THEN.",
		"NO REST FOR THE WICKED. YOUR PORTAL IS READY.",
		"GO ON, THEN. GET BACK OUT THERE.",
		"UGH, PLEASE GO THROUGH QUICK. HATE HEARING WHAT THE ME ON THE OTHER SIDE IS THINKING.",
	)

/obj/item/roguemachine/keymaster_exit/attack_hand(mob/user)
	. = ..()
	to_chat(user, span_notice("I put a hand to the KEYMASTER..."))
	if(!do_after(user, 5 SECONDS, target = src))
		return
	var/portal_attempt = SSremote_sanctuaries.try_create_portals(data.owner_ckey)
	if(isnum(portal_attempt))
		switch(portal_attempt)
			if(SANCTUARY_PORTAL_SUCCESSFUL)
				playsound(loc, 'sound/misc/machinetalk.ogg', 100, TRUE, -1)
				if(data.is_wretch_made())
					say(pick(portal_lines_wretches))
				else
					say(pick(portal_lines))
			if(SANCTUARY_PORTAL_ERROR_OBSTRUCTEDTURFS)
				say("AN ISSUE ARISES: THE WAE BACK HATH TOO MANY OBSTRUCTIONS AROUND MINE ORB ON THE OTHER SIDE! I CANST NOT CONJURE A PORTAL FOR THEE UNTIL THE SPACE IS CLEARED!! MINE APOLOGIES!!")
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
			if(SANCTUARY_PORTAL_ERROR_MOBSINWAY)
				say("AN ISSUE ARISES: THE WAE BACK HATH TOO MANY LIVING MEATBAGS IN THE WAY! I CANST NOT CONJURE A PORTAL FOR THEE UNTIL THEY MOVE!! WAIT UNTIL THEY MOVE AND TRY AGAIN!!")
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
			if(SANCTUARY_PORTAL_ERROR_PORTALSALREADYEXIST)
				playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
				if(data.is_wretch_made())
					say("THERE'S ALREADY AN OPEN PORTAL LEADING BACK. IT'S RIGHT HERE NEXT TO US, FOOL.")
				else
					say("UH. SIRE, THERE ART ALREADY A PORTAL BACK NEXT TO US!!")

/obj/item/roguemachine/keymaster_exit/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/roguekey/remote_sanctuary))
		playsound(loc, 'sound/misc/machineno.ogg', 100, TRUE, -1)
		if(data.is_wretch_made())
			say("YOU DO NOT NEED TO USE A KEY TO HEAD BACK, FOOL. JUST PLACE YOUR EMPTY HAND UPON MY ORB.")
		else
			say("OH, THOU DOTH NOT REQUIRE A KEY TO RETURN!! JUST PLACE THY EMPTY HAND UPON MINE ORB!!")

/obj/structure/fluff/traveltile/sanctuary_portal
	name = "sanctuary portal"
	desc = "A marvel of magicks automated by artifice. I cannot see the other side, but wherever it will take me, I can be sure I will be traveling for miles in but a single step..."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "underworldportal"
	travel_message = span_blue("The magickal gateway requires a mote to carry me to my destination...")
	light_inner_range = 4
	light_outer_range = 5
	light_color = "#79ecfc"
	light_on = TRUE

/obj/structure/fluff/traveltile/sanctuary_portal/Initialize(mapload)
	. = ..()
	if(loc)
		playsound(loc, 'sound/misc/portalactivate.ogg', 100, TRUE, -1)
		visible_message(span_blue("\The [src] appears in a brilliant cerulean flash!"))

/obj/structure/fluff/traveltile/sanctuary_portal/perform_travel(obj/structure/fluff/traveltile/T, mob/living/L)
	playsound(loc, 'sound/misc/portalenter.ogg', 100, TRUE, -1)
	L.visible_message(span_notice("\The [L] enters \the [src] and vanishes inside in a single step."), span_blue("I feel a violent and sudden pull at the core of my being. By the time I am standing on stable ground again, I feel as though I have been falling for ages... Or was it only a fraction of a second?"))
	T.visible_message(span_notice("\The [L] emerges from the shimmering portal!"))
	playsound(T, 'sound/misc/portalenter.ogg', 100, TRUE, -1)
	. = ..()

/obj/structure/fluff/traveltile/sanctuary_portal/proc/expire()
	visible_message("\The [src] dissolves into cerulean sparks that waver and fizzle out like dying embers.")
	qdel(src)

// The keys the KEYMASTER spits out
/obj/item/roguekey/remote_sanctuary
	name = "remote sanctuary key"
	icon = 'modular_ochrevalley/icons/roguetown/items/keys.dmi'
	icon_state = "sanctuary_key"
	desc = "Mana and metal married and became as one to fit in a keyhole that did not exist until their conception. When I squeeze its handle, bright cerulean arcs flare and dance betwixt the azure teeth."
	/// Ckey of the player whose sanctuary this key leads to.
	var/sanctuary_owner_ckey

/obj/item/roguekey/remote_sanctuary/Initialize(mapload, mob/living/carbon/human/owner)
	sanctuary_owner_ckey = owner.ckey
	lockid = "sanctuary_[owner.ckey]"
	name = "[name] ([owner.real_name])"
	aura_color = owner.voice_color
	. = ..(mapload)

/obj/item/roguekey/remote_sanctuary/get_mechanics_examine(mob/user)
	. = ..()
	. += span_blue("Use this on the KEYMASTER to create a portal that will allow you to enter the remote sanctuary it was made for.")
	. += span_blue("This key will also work as a regular key does for any and all doors, chests, and closets within the sanctuary it was made for.")

#undef KEYMASTER_DESC
