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

/obj/item/roguemachine/keymaster/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(!user)
		return
	if(!SSremote_sanctuaries.get_claimed_sanctuary(user.ckey))
		purchase_sanctuary(user, "naledi_home")
	else
		regurgitate_key(user)

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
		key_act(user, K.sanctuary_owner_ckey)

/obj/item/roguemachine/keymaster/proc/purchase_sanctuary(mob/living/carbon/human/user, sanctuary_id)
	// We first spawn the key in nullspace to ensure that a lockhash with its ID exists before
	// the player's sanctuary is generated. This way all the lockable things in there will be
	// usable with the key!
	var/obj/item/roguekey/remote_sanctuary/key = regurgitate_key(user)
	var/datum/sanctuary_data/data = SSremote_sanctuaries.claim_sanctuary(user, sanctuary_id, for_wretches)
	user.put_in_hands(key)
	playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
	say(pick(data.used_template.purchase_lines))

/// Dispenses a key to the user
/obj/item/roguemachine/keymaster/proc/regurgitate_key(mob/living/carbon/human/user)
	var/obj/item/roguekey/remote_sanctuary/key = new(null, user)
	playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)
	user.put_in_hands(key)
	return key

/obj/item/roguemachine/keymaster/proc/key_act(mob/living/carbon/human/user, sanctuary_owner_ckey)
	var/portal_attempt = SSremote_sanctuaries.try_create_portals(sanctuary_owner_ckey)
	to_chat(user, span_notice("Portal attempt returned: [portal_attempt]"))
	if(isnum(portal_attempt))
		switch(portal_attempt)
			if(SANCTUARY_PORTAL_SUCCESSFUL)
				say("THY PORTAL ART READY! PRITHEE, TAKE BUT ONE STEP WITHIN TO TRAVEL MILES BEYOND!!")
			if(SANCTUARY_PORTAL_ERROR_OBSTRUCTEDTURFS)
				say("AN ISSUE ARISES: THE SANCTUARY HAS TOO MANY OBSTRUCTIONS AROUND MINE ORB ON THE OTHER SIDE! I CANST NOT CONJURE A PORTAL FOR THEE UNTIL THE SPACE IS CLEARED!! MINE APOLOGIES!!")
			if(SANCTUARY_PORTAL_ERROR_MOBSINWAY)
				say("AN ISSUE ARISES: THE SANCTUARY HAS TOO MANY LIVING MEATBAGS IN THE WAY! I CANST NOT CONJURE A PORTAL FOR THEE UNTIL THEY MOVE!! WAIT UNTIL THEY MOVE AND TRY AGAIN!!")
			if(SANCTUARY_PORTAL_ERROR_PORTALSALREADYEXIST)
				say("UH. SIRE, THERE ART ALREADY A PORTAL TO YONDER SANCTUARY NEXT TO US!!")

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

/obj/structure/fluff/traveltile/sanctuary_portal
	name = "sanctuary portal"
	desc = "A marvel of magicks automated by artifice. I cannot see the other side, but wherever it will take me, I can be sure I will be traveling for miles in but a single step..."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "underworldportal"

/obj/structure/fluff/traveltile/sanctuary_portal/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(expire)), 1 MINUTES)

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
