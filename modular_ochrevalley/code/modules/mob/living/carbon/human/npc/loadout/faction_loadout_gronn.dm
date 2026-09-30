/datum/npc_archetype/dreamraider
	abstract_type = /datum/npc_archetype/dreamraider
	job = "Kraken Cult Warrior"
	category = FACTION_GRONNMEN
	faction_tag = "bandits"
	threat_point = THREAT_DANGEROUS
	body = /datum/npc_body/northern_commoner/dreamraider
	statpack = /datum/npc_statpack/dreamraider
	armor_training = ARMOR_CLASS_HEAVY
	traits = list(TRAIT_STEELHEARTED, TRAIT_ABYSSOR_SWIM)
	melee = SKILL_LEVEL_EXPERT
	brawl = SKILL_LEVEL_EXPERT
	athletics = SKILL_LEVEL_EXPERT
	loadouts = list(
		/datum/npc_loadout/armor/gronn/peasant,
		/datum/npc_loadout/kit/kraken_cult_flavor,
		/datum/npc_loadout/weapon/gronn/peasant,
	)

//Body
/datum/npc_body/northern_commoner/dreamraider
	male_name_file = "strings/rt/names/human/vikingm.txt"
	female_name_file = "strings/rt/names/human/vikingf.txt"
	aggro_lines_file = "strings/rt/searaideraggrolines.txt" // Fix this
	voicepack_chance = 100
	voicepacks = list(
		list(/datum/voicepack/male/warrior, /datum/voicepack/female/warrior),
	)

//Flavor kits
/datum/npc_loadout/kit/kraken_cult_flavor
	cloak = /obj/item/clothing/cloak/raincloak/blue
	id = /obj/item/clothing/neck/roguetown/psicross/abyssor/gronn
	belt = /obj/item/storage/belt/rogue/leather/black
//Weapon kits
