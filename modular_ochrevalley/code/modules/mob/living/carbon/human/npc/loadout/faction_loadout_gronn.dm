//** ARCHETYPES **//

/datum/npc_archetype/dreamraider
	job = "Kraken Cult Warrior"
	category = FACTION_GRONNMEN
	faction_tag = "raiders"
	threat_point = THREAT_DANGEROUS
	body = /datum/npc_body/northern_commoner/dreamraider
	statpack = /datum/npc_statpack/dreamraider
	armor_training = ARMOR_CLASS_HEAVY
	traits = list(TRAIT_STEELHEARTED, TRAIT_ABYSSOR_SWIM)
	melee = SKILL_LEVEL_EXPERT
	brawl = SKILL_LEVEL_EXPERT
	athletics = SKILL_LEVEL_EXPERT
	survival = SKILL_LEVEL_LEGENDARY //For legendary swimming
	loadouts = list(
		/datum/npc_loadout/armor/gronn/peasant,
		/datum/npc_loadout/kit/kraken_cult_flavor,
		/datum/npc_loadout/weapon/gronn_peasant,
	)

/datum/npc_archetype/dreamraider/archer
	job = "Kraken Cult Archer"
	statpack = /datum/npc_statpack/dreamraider/archer
	skills = list(/datum/skill/combat/bows = SKILL_LEVEL_MASTER)
	loadouts = list(
		/datum/npc_loadout/armor/gronn/archer,
		/datum/npc_loadout/kit/kraken_cult_flavor,
		/datum/npc_loadout/weapon/gronn_bow,
	)

/datum/npc_archetype/dreamraider/armored
	statpack = /datum/npc_statpack/dreamraider/armored
	melee = SKILL_LEVEL_MASTER
	brawl = SKILL_LEVEL_MASTER
	loadouts = list(
		/datum/npc_loadout/armor/gronn/armored,
		/datum/npc_loadout/kit/kraken_cult_flavor,
		/datum/npc_loadout/weapon/gronn_elite,
	)

/datum/npc_archetype/dreamraider/champion
	statpack = /datum/npc_statpack/dreamraider/champion
	melee = SKILL_LEVEL_LEGENDARY
	brawl = SKILL_LEVEL_LEGENDARY
	traits = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_BADTRAINER, TRAIT_NOPAINSTUN, TRAIT_NOPAIN, TRAIT_STRENGTH_UNCAPPED)
	loadouts = list(
		/datum/npc_loadout/armor/gronn/champion,
		/datum/npc_loadout/kit/kraken_champion_flavor,
		/datum/npc_loadout/weapon/gronn_elite,
	)

/datum/npc_archetype/dreamraider/walker
	statpack = /datum/npc_statpack/legendary
	melee = SKILL_LEVEL_LEGENDARY
	brawl = SKILL_LEVEL_LEGENDARY
	traits = list(TRAIT_CRITICAL_RESISTANCE, TRAIT_DREAMWALKER, TRAIT_BADTRAINER, TRAIT_NOPAINSTUN, TRAIT_NOPAIN, TRAIT_STRENGTH_UNCAPPED)
	loadouts = list(
		/datum/npc_loadout/armor/gronn/dreamwalker,
		/datum/npc_loadout/kit/kraken_champion_flavor,
		/datum/npc_loadout/weapon/dreamwalker,
	)
//** BODY **//

/datum/npc_body/northern_commoner/dreamraider
	male_name_file = "strings/rt/names/human/vikingm.txt"
	female_name_file = "strings/rt/names/human/vikingf.txt"
	aggro_lines_file = "strings/rt/dreamraideraggrolines.txt"
	voicepack_chance = 100
	voicepacks = list(
		list(/datum/voicepack/male/warrior, /datum/voicepack/female/warrior),
	)

//** STATS **//

/datum/npc_statpack/dreamraider
	strength = 12
	speed = 14
	constitution = 9
	willpower = 11
	perception = 12
	intelligence = 11

/datum/npc_statpack/dreamraider/archer
	speed = 12
	perception = 15
	intelligence = 12

/datum/npc_statpack/dreamraider/armored
	strength = 14
	constitution = 13
	willpower = 14
	perception = 15
	intelligence = 13

/datum/npc_statpack/dreamraider/champion
	strength = 16
	constitution = 15
	willpower = 15
	perception = 15
	intelligence = 15

//** FLAVOR **//

/datum/npc_loadout/kit/kraken_cult_flavor
	cloak = /obj/item/clothing/cloak/raincloak/blue
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather/black

/datum/npc_loadout/kit/kraken_champion_flavor
	cloak = /obj/item/clothing/cloak/tabard/abyssorite
	backr = /obj/item/clothing/cloak/volfmantle
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather/black

//** WEAPONS **//

/datum/npc_loadout/weapon/gronn_peasant
	weapons = list(
		list(/obj/item/rogueweapon/sword/short, /obj/item/rogueweapon/shield/wood),
		list(/obj/item/rogueweapon/stoneaxe/handaxe, /obj/item/rogueweapon/shield/wood),
		list(/obj/item/rogueweapon/spear),
		list(/obj/item/rogueweapon/huntingknife/combat, /obj/item/rogueweapon/shield/wood)
	)
/datum/npc_loadout/weapon/gronn_bow
	r_hand = /obj/item/rogueweapon/huntingknife/combat
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	backl = /obj/item/quiver/bodkin

/datum/npc_loadout/weapon/gronn_elite
	weapons = list(
		list(/obj/item/rogueweapon/sword/short/gronn, /obj/item/rogueweapon/shield/atgervi),
		list(/obj/item/rogueweapon/stoneaxe/woodcut/steel/atgervi, /obj/item/rogueweapon/shield/atgervi),
		list(/obj/item/rogueweapon/mace/warhammer/steel, /obj/item/rogueweapon/shield/atgervi),
		list(/obj/item/rogueweapon/spear/billhook),
		list(/obj/item/rogueweapon/greataxe/steel)
	)

/datum/npc_loadout/weapon/dreamwalker
	weapons = list(
		list(/obj/item/rogueweapon/spear/trident/dreamscape_trident/active, /obj/item/rogueweapon/shield/atgervi),
		list(/obj/item/rogueweapon/greatsword/bsword/dreamscape/active),
		list(/obj/item/rogueweapon/greataxe/dreamscape/active),
		list(/obj/item/rogueweapon/halberd/glaive/dreamscape/active)
	)
