//Vheslyn cultist faction, and remember any admin/GM reading this file that these guys should be rare!
//Many also carry steel gear, and will be valuable to kill if looted before they detonate.

/datum/outfit/job/roguetown/human/northern/infernal_cultist/proc/add_random_cultist_cloak(mob/living/carbon/human/H)
	var/random_cultist_cloak = rand(1,4)
	switch(random_cultist_cloak)
		if(1)
			cloak = /obj/item/clothing/cloak/raincloak/mortus
		if(2)
			cloak = /obj/item/clothing/suit/roguetown/shirt/robe/black
		if(3)
			cloak = /obj/item/clothing/cloak/half
		if(4)
			cloak = /obj/item/clothing/suit/roguetown/armor/longcoat
//Low level cultists, extremely random and disjointed gear. With a lot of luck they can be pretty protected.
//Otherwise, they're going to be weak and likely with notable gaps in their protection.
/mob/living/carbon/human/species/human/northern/infernal_cultist
	ai_controller = /datum/ai_controller/human_npc
	faction = list(FACTION_INFERNAL)
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK, INTENT_SPECIAL)
	blood_toll_bucket = STATS_KILLED_INFERNALS
	var/infernal_cultist_outfit = /datum/outfit/job/roguetown/human/northern/infernal_cultist

/mob/living/carbon/human/species/human/northern/infernal_cultist/Initialize(mapload)
	. = ..()
	//Begin RANDOMISE here
	set_species(pick(NPC_RACES_TYPES))
	gender = pick(MALE, FEMALE)
	dna.species.random_character(src) //Now we just randomise here, MUST be called after both race + gender
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)


/mob/living/carbon/human/species/human/northern/infernal_cultist/after_creation()
	..()
	AddComponent(/datum/component/ai_aggro_system)
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.highwayman_aggro, TRUE)
	job = "Vheslyn Cultist"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NPC_EXAMINE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_UNFORGIVABLE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_DNR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_DETACHED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_PSYCHOSIS, TRAIT_GENERIC)
	equipOutfit(new infernal_cultist_outfit)
	AddComponent(/datum/component/npc_death_line, null, 25)
	dna.species.handle_body(src)
	random_voice_NPC()
	random_hair_NPC()
	random_eye_color_NPC()
	correct_features_NPC()

	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/names/first_female.txt"))
	else
		real_name = pick(world.file2list("strings/names/first_male.txt"))
	update_hair()
	update_body()
	src.regenerate_icons() //Fixes the weird body


/datum/outfit/job/roguetown/human/northern/infernal_cultist/pre_equip(mob/living/carbon/human/H)
	..()
	//Skills
	H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/athletics, SKILL_LEVEL_JOURNEYMAN, TRUE)
	//Stats
	H.STASTR = 12
	H.STASPD = 11
	H.STACON = 8
	H.STAWIL = 8
	H.STAPER = 12
	H.STAINT = 8
	//Head Gear
	if(prob(70))
		switch(rand(1, 4))
			if(1)
				head = /obj/item/clothing/head/roguetown/helmet/kettle/iron
			if(2)
				head = /obj/item/clothing/head/roguetown/helmet/skullcap
				neck = /obj/item/clothing/neck/roguetown/coif
				mask = /obj/item/clothing/head/roguetown/roguehood/black
			if(3)
				head = /obj/item/clothing/head/roguetown/helmet/leather
				neck = /obj/item/clothing/neck/roguetown/leather
			if(4)
				neck = /obj/item/clothing/neck/roguetown/coif/heavypadding/black
				mask = /obj/item/clothing/head/roguetown/roguehood/black
	//Chest Gear
	add_random_cultist_cloak(H)
	belt = /obj/item/storage/belt/rogue/leather/battleskirt/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	if(prob(50))
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	switch(rand(1, 7))
		if(1)
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
		if(2)
			armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
		if(3)
			armor = /obj/item/clothing/suit/roguetown/armor/leather
		if(4)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
		if(5)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
		if(6)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
		if(7)
			armor = /obj/item/clothing/suit/roguetown/shirt/tunic/black
	//Arm Gear
	if(prob(50))
		gloves = /obj/item/clothing/gloves/roguetown/leather/black
	if(prob(75))
		switch(rand(1, 4))
			if(1)
				wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			if(2)
				wrists = /obj/item/clothing/wrists/roguetown/bracers/jackchain
			if(3)
				wrists = /obj/item/clothing/wrists/roguetown/bracers/splint
			if(4)
				wrists = /obj/item/clothing/wrists/roguetown/bracers/copper
	//Leg Gear
	switch(rand(1, 7))
		if(1)
			pants = /obj/item/clothing/under/roguetown/splintlegs
		if(2)
			pants = /obj/item/clothing/under/roguetown/trou/leather
		if(3)
			pants = /obj/item/clothing/under/roguetown/trou
		if(5)
			pants = /obj/item/clothing/under/roguetown/tights/black
		if(6)
			pants = /obj/item/clothing/under/roguetown/heavy_leather_pants/kazengun/black
		if(7)
			pants = /obj/item/clothing/under/roguetown/skirt/black
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	//Weapons
	switch(rand(1, 7))
		if(1)
			l_hand = /obj/item/rogueweapon/spear/short
			r_hand = /obj/item/rogueweapon/shield/iron
		if(2)
			r_hand = /obj/item/rogueweapon/sword/falchion/militia
			if(prob(30))
				l_hand = /obj/item/rogueweapon/shield/wood
		if(3)
			r_hand = /obj/item/rogueweapon/sword/short/iron
			if(prob(50))
				l_hand = /obj/item/rogueweapon/shield/wood
		if(4)
			r_hand = /obj/item/rogueweapon/flail/militia
			if(prob(75))
				l_hand = /obj/item/rogueweapon/shield/iron
		if(5)
			r_hand = /obj/item/rogueweapon/stoneaxe/woodcut
		if(6)
			r_hand = /obj/item/rogueweapon/sword/long/iron
		if(7)
			r_hand = /obj/item/rogueweapon/woodstaff/quarterstaff/iron

//Proper fighting cultists with much more organized gear and better stats.
/mob/living/carbon/human/species/human/northern/infernal_cultist/soldier
	var/infernal_cultist_outfit = /datum/outfit/job/roguetown/human/northern/infernal_cult_soldier

/mob/living/carbon/human/species/human/northern/infernal_cultist/soldier/after_creation()
	..()
	job = "Vheslyn Cult Warrior"
	ADD_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)


/datum/outfit/job/roguetown/human/northern/infernal_cultist/pre_equip(mob/living/carbon/human/H)
	..()
	//Skills
	H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_EXPERT, TRUE)
	//Stats
	H.STASTR = 14
	H.STASPD = 12
	H.STACON = 10
	H.STAWIL = 11
	H.STAPER = 12
	H.STAINT = 11
	//Head Gear
	switch(rand(1, 5))
		if(1)
			head = /obj/item/clothing/head/roguetown/helmet/heavy/beakhelm
			neck = /obj/item/clothing/neck/roguetown/coif/heavypadding/black
			mask = /obj/item/clothing/head/roguetown/roguehood/black
		if(2)
			head = /obj/item/clothing/head/roguetown/helmet/kettle
			neck = /obj/item/clothing/neck/roguetown/coif/heavypadding/black
		if(3)
			head = /obj/item/clothing/head/roguetown/helmet/sallet
			neck = /obj/item/clothing/neck/roguetown/gorget/aventail
		if(4)
			head = /obj/item/clothing/head/roguetown/helmet/nasal
			neck = /obj/item/clothing/neck/roguetown/gorget/steel
		if(5)
			head = /obj/item/clothing/head/roguetown/helmet/kettle
			neck = /obj/item/clothing/neck/roguetown/gorget/steel
	//Body Gear
	switch(rand(1, 4))
		if(1) //Brigandine
			armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
			shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/iron
			wrists = /obj/item/clothing/wrists/roguetown/bracers/brigandine
			pants = /obj/item/clothing/under/roguetown/brigandinelegs
		if(2) //Chainmail
		if(3) //Plate
		if(4) //Scale
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
