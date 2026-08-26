// Basic Gronnic warrior, too poor for anything expensive, but they still know how to fight.

/mob/living/carbon/human/species/human/northern/dreamraider
	ai_controller = /datum/ai_controller/human_npc
	faction = list(FACTION_GRONNMEN, FACTION_DREAM, FACTION_STATION)
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK, INTENT_SPECIAL)
	blood_toll_bucket = STATS_KILLED_GRONNMEN
	var/dreamraider_outfit = /datum/outfit/job/roguetown/human/species/human/northern/dreamraider

/mob/living/carbon/human/species/human/northern/dreamraider/Initialize(mapload)
	. = ..()
	//Begin RANDOMISE here
	gender = pick(MALE, FEMALE)
	dna.species.random_character(src) //Now we just randomise here, MUST be called after both race + gender
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)


/mob/living/carbon/human/species/human/northern/dreamraider/after_creation()
	..()
	AddComponent(/datum/component/ai_aggro_system)
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.searaider_aggro, TRUE)
	job = "Kraken Cult Levy"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NPC_EXAMINE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ABYSSOR_SWIM, TRAIT_GENERIC)
	equipOutfit(new dreamraider_outfit)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	head.sellprice = HEAD_BOUNTY_SEARAIDER
	dna.species.handle_body(src)
	random_voice_NPC()
	random_hair_NPC()
	random_eye_color_NPC()
	correct_features_NPC()

	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/rt/names/human/vikingf.txt"))
	else
		real_name = pick(world.file2list("strings/rt/names/human/vikingm.txt"))
	update_hair()
	update_body()
	src.regenerate_icons() //Fixes the weird body but lets check performance first

/datum/outfit/job/roguetown/human/species/human/northern/dreamraider/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/atgervi/gronn
	neck = /obj/item/clothing/neck/roguetown/gorget
	cloak = /obj/item/clothing/cloak/raincloak/blue
	armor = /obj/item/clothing/suit/roguetown/shirt/tunic/blue
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord/light //They're meant to have weak body armor, 200 integ chest is bad, but it should be bad
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	gloves = /obj/item/clothing/gloves/roguetown/angle/atgervi
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	switch(rand(1, 4))
		if(1)
			r_hand = /obj/item/rogueweapon/sword/short
			l_hand = /obj/item/rogueweapon/shield/wood
			beltl = /obj/item/rogueweapon/scabbard/sword
		if(2)
			r_hand = /obj/item/rogueweapon/stoneaxe/handaxe
			l_hand = /obj/item/rogueweapon/shield/wood
		if(3)
			r_hand = /obj/item/rogueweapon/spear
		if(4)
			r_hand = /obj/item/rogueweapon/huntingknife/combat
			l_hand = /obj/item/rogueweapon/shield/wood
			beltl = /obj/item/rogueweapon/scabbard/sheath

	H.STASPD = 14 //They are wearing very light armor, thus, high speed to help them chase down kiting players.
	H.STACON = 9
	H.STAWIL = 12
	H.STAPER = 11
	H.STAINT = 10
	H.STASTR = 12
	H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_EXPERT, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, SKILL_LEVEL_JOURNEYMAN, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/misc/swimming, SKILL_LEVEL_LEGENDARY, TRUE) // Abyssorites, don't fight these guys in the water
	H.adjust_skillrank_up_to(/datum/skill/misc/climbing, SKILL_LEVEL_APPRENTICE, TRUE)

	H.dna.species.soundpack_m = GLOB.voice_packs[/datum/voicepack/male/warrior]
	H.dna.species.soundpack_f = GLOB.voice_packs[/datum/voicepack/female/warrior]

// Gronnic archers, given entirely unique equipment focused on protection against enemy archers.

/mob/living/carbon/human/species/human/northern/dreamraider/archer
	ai_controller = /datum/ai_controller/human_npc/archer
	d_intent = INTENT_DODGE //This might be too evil, but they're not parrying shit with their seax.
	dreamraider_outfit = /datum/outfit/job/roguetown/human/species/human/northern/dreamraider/archer

/mob/living/carbon/human/species/human/northern/dreamraider/archer/after_creation()
	..()
	job = "Kraken Cult Archer"

/datum/outfit/job/roguetown/human/species/human/northern/dreamraider/archer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	neck = /obj/item/clothing/neck/roguetown/coif/heavypadding/black
	cloak = /obj/item/clothing/cloak/raincloak/blue
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/light
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	gloves = null
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather/reinforced
	r_hand = /obj/item/rogueweapon/huntingknife/combat
	l_hand = null
	beltl = /obj/item/rogueweapon/scabbard/sheath
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backl = /obj/item/quiver/bodkin //This is probably a bad idea, but I must know.

	H.STAPER = 14 //This also might be a bad idea.
	H.STASPD = 10
	H.STACON = 6
	H.adjust_skillrank_up_to(/datum/skill/combat/bows, SKILL_LEVEL_EXPERT, TRUE)

// A well armored Gronnic warrior. Meant to be a bit stronger than your typical better gear bogman.

/mob/living/carbon/human/species/human/northern/dreamraider/armored
	setparrytime = 25
	dreamraider_outfit = /datum/outfit/job/roguetown/human/species/human/northern/dreamraider/armored

/mob/living/carbon/human/species/human/northern/dreamraider/armored/after_creation()
	..()
	job = "Kraken Cult Soldier"

/datum/outfit/job/roguetown/human/species/human/northern/dreamraider/armored/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/atgervi/gronn/ownel
	neck = /obj/item/clothing/neck/roguetown/gorget/aventail
	cloak = /obj/item/clothing/cloak/raincloak/blue
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/gronn
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/black
	wrists = null
	gloves = /obj/item/clothing/gloves/roguetown/chain/gronn
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/chainlegs/gronn
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron
	switch(rand(1, 5))
		if(1)
			r_hand = /obj/item/rogueweapon/sword/short/gronn
			l_hand = /obj/item/rogueweapon/shield/atgervi
			beltl = /obj/item/rogueweapon/scabbard/sword
		if(2)
			r_hand = /obj/item/rogueweapon/stoneaxe/woodcut/steel/atgervi
			l_hand = /obj/item/rogueweapon/shield/atgervi
		if(3)
			r_hand = /obj/item/rogueweapon/mace/warhammer/steel
			l_hand = /obj/item/rogueweapon/shield/atgervi
		if(4)
			r_hand = /obj/item/rogueweapon/spear/billhook
			l_hand = null
		if(5)
			r_hand = /obj/item/rogueweapon/greataxe/steel
			l_hand = null

	H.STASPD = 12
	H.STACON = 11
	H.STAWIL = 14
	H.STAPER = 13
	H.STAINT = 13
	H.STASTR = 14

// Elite regular cultist, heavy armor, and master skills.

/mob/living/carbon/human/species/human/northern/dreamraider/champion
	setparrytime = 20
	dreamraider_outfit = /datum/outfit/job/roguetown/human/species/human/northern/dreamraider/champion

/mob/living/carbon/human/species/human/northern/dreamraider/champion/after_creation()
	..()
	job = "Kraken Cult Champion"
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STRENGTH_UNCAPPED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NODISMEMBER, TRAIT_GENERIC)
	for(var/obj/item/gear in get_equipped_items() + held_items)
		lock_gear_piece(gear, "dreamraider_champion_gear")

/datum/outfit/job/roguetown/human/species/human/northern/dreamraider/champion/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket/gronn
	neck = /obj/item/clothing/neck/roguetown/bevor/blacksteel/modern
	cloak = /obj/item/clothing/cloak/tabard/abyssorite
	backr = /obj/item/clothing/cloak/volfmantle
	armor = /obj/item/clothing/suit/roguetown/armor/plate/iron/gronn
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/plate/iron/gronn
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/platelegs/iron/gronn
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/iron/gronn
	switch(rand(1, 7))
		if(1)
			r_hand = /obj/item/rogueweapon/sword/short/messer/blacksteel
			l_hand = /obj/item/rogueweapon/shield/atgervi
			beltl = /obj/item/rogueweapon/scabbard/sword
		if(2)
			r_hand = /obj/item/rogueweapon/flail/blacksteel
			l_hand = /obj/item/rogueweapon/shield/atgervi
		if(3)
			r_hand = /obj/item/rogueweapon/handclaw/blacksteel
			l_hand = /obj/item/rogueweapon/shield/atgervi
		if(4)
			r_hand = /obj/item/rogueweapon/stoneaxe/battle/blacksteel
			l_hand = null
		if(5)
			r_hand = /obj/item/rogueweapon/eaglebeak/blacksteel
			l_hand = null
		if(6)
			r_hand = /obj/item/rogueweapon/spear/blacksteel
			l_hand = null
		if(7)
			r_hand = /obj/item/rogueweapon/greatsword/grenz/flamberge/blacksteel
			l_hand = null

	H.STASPD = 14
	H.STACON = 15
	H.STAWIL = 16
	H.STAPER = 14
	H.STAINT = 14
	H.STASTR = 16

	H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_MASTER, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, SKILL_LEVEL_MASTER, TRUE)

// Boss tier enemy, dreamwalker armor, dreamwalker weapons, legendary skills, insane stats and powerful traits.

/mob/living/carbon/human/species/human/northern/dreamraiderwalker
	ai_controller = /datum/ai_controller/human_npc
	faction = list(FACTION_GRONNMEN, FACTION_DREAM, FACTION_STATION)
	ambushable = FALSE
	cmode = 1
	setparrytime = 30
	a_intent = INTENT_HELP
	d_intent = INTENT_PARRY
	possible_mmb_intents = list(INTENT_BITE, INTENT_JUMP, INTENT_KICK, INTENT_SPECIAL)
	blood_toll_bucket = STATS_KILLED_GRONNMEN
	var/dreamraiderwalker_outfit = /datum/outfit/job/roguetown/human/species/human/northern/dreamraider/dreamwalker

/mob/living/carbon/human/species/human/northern/dreamraiderwalker/Initialize(mapload)
	. = ..()
	//Begin RANDOMISE here
	gender = pick(MALE, FEMALE)
	dna.species.random_character(src) //Now we just randomise here, MUST be called after both race + gender
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)


/mob/living/carbon/human/species/human/northern/dreamraiderwalker/after_creation()
	..()
	AddComponent(/datum/component/ai_aggro_system)
	SEND_SIGNAL(src, COMSIG_MOB_MODIFY_AGGRO_LINES, GLOB.searaider_aggro, TRUE)
	job = "Kraken Cult Dreamwalker"
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_STRENGTH_UNCAPPED, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NODISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BADTRAINER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_DREAMWALKER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LEECHIMMUNE, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NPC_EXAMINE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ABYSSOR_SWIM, TRAIT_GENERIC)
	equipOutfit(new dreamraiderwalker_outfit)
	var/obj/item/bodypart/head/head = get_bodypart(BODY_ZONE_HEAD)
	head.sellprice = HEAD_BOUNTY_SEARAIDER
	dna.species.handle_body(src)
	random_voice_NPC()
	random_hair_NPC()
	random_eye_color_NPC()
	correct_features_NPC()

	if(gender == FEMALE)
		real_name = pick(world.file2list("strings/rt/names/human/vikingf.txt"))
	else
		real_name = pick(world.file2list("strings/rt/names/human/vikingm.txt"))
	update_hair()
	update_body()
	src.regenerate_icons() //Fixes the weird body but lets check performance first





/datum/outfit/job/roguetown/human/species/human/northern/dreamraider/dreamwalker/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/bascinet/dreamwalker
	neck = /obj/item/clothing/neck/roguetown/bevor/dreamwalker
	cloak = /obj/item/clothing/cloak/tabard/abyssorite
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full/dreamwalker
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk/dreamwalker
	wrists = /obj/item/clothing/wrists/roguetown/bracers/dreamwalker
	gloves = /obj/item/clothing/gloves/roguetown/plate/dreamwalker
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/platelegs/dreamwalker
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/dreamwalker
	switch(rand(1, 4))
		if(1)
			r_hand = /obj/item/rogueweapon/spear/trident/dreamscape_trident/active
			l_hand = /obj/item/rogueweapon/shield/atgervi
		if(2)
			r_hand = /obj/item/rogueweapon/greatsword/bsword/dreamscape/active
			l_hand = null
		if(3)
			r_hand = /obj/item/rogueweapon/greataxe/dreamscape/active
			l_hand = null
		if(4)
			r_hand = /obj/item/rogueweapon/halberd/glaive/dreamscape/active
			l_hand = null


	H.STASPD = 15
	H.STACON = 18
	H.STAWIL = 18
	H.STAPER = 16
	H.STAINT = 16
	H.STASTR = 20

	H.adjust_skillrank_up_to(/datum/skill/combat/polearms, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/maces, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/axes, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/swords, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/knives, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/shields, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/unarmed, SKILL_LEVEL_LEGENDARY, TRUE)
	H.adjust_skillrank_up_to(/datum/skill/combat/wrestling, SKILL_LEVEL_LEGENDARY, TRUE)
