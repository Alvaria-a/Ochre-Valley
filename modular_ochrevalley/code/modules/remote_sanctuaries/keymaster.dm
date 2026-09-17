/obj/item/roguemachine/keymaster
	name = "KEYMASTER"
	desc = "A queer device that allows one to purchase and access expensive private residences in far off locations."
	icon = 'modular_ochrevalley/icons/misc/machines.dmi'
	icon_state = "keymaster"
	density = TRUE
	blade_dulling = DULLING_BASH
	var/next_airlift
	max_integrity = 0
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	var/list/stored_money

/obj/item/roguemachine/keymaster/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(!user)
		return
	if(!SSremote_sanctuaries.get_claimed_sanctuary(user.ckey))
		purchase_sanctuary(user, "naledi_home")
	else
		regurgitate_key(user)

/obj/item/roguemachine/keymaster/proc/purchase_sanctuary(mob/living/carbon/human/user, sanctuary_id)
	regurgitate_key(user)
	var/datum/sanctuary_data/data = SSremote_sanctuaries.claim_sanctuary(user, sanctuary_id)
	say(pick(data.used_template.purchase_lines))
	playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)


/// Dispenses a key to the user
/obj/item/roguemachine/keymaster/proc/regurgitate_key(mob/living/carbon/human/user)
	var/obj/item/roguekey/remote_sanctuary/key = new(null, user)
	user.put_in_hands(key)
	playsound(loc, 'sound/misc/machinevomit.ogg', 100, TRUE, -1)

/// KEYMASTER variant that exists to take the player back out of a sanctuary.
/obj/item/roguemachine/keymaster/exit


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
	aura_color = owner.voice_color
	. = ..(mapload)
