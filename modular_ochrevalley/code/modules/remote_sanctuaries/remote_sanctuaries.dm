/obj/effect/landmark/remote_sanctuary_spawn
	name = "remote sanctuary spawn"
	icon_state = "x3"

/obj/effect/landmark/remote_sanctuary_spawn/Initialize(mapload)
	. = ..()
	SSremote_sanctuaries.sanctuaries += src

/datum/controller/subsystem/mapping
	var/list/remote_sanctuary_templates = list()

/datum/controller/subsystem/mapping/proc/preload_remote_sanctuary_templates()
	for(var/datum/map_template/remote_sanctuary/sanctuary_type as anything in subtypesof(/datum/map_template/remote_sanctuary))
		if(!initial(sanctuary_type.mappath))
			continue
		var/datum/map_template/remote_sanctuary/S = new sanctuary_type()

		remote_sanctuary_templates[S.sanctuary_id] = S

SUBSYSTEM_DEF(remote_sanctuaries)
	name = "Remote Sanctuary"
	flags = SS_NO_FIRE
	/// All sanctuaries that exist in the game world
	var/list/sanctuaries = list()
	/// Sanctuaries that have been claimed. Associated list; key is the ckey of the claimer
	var/list/sanctuaries_claimed = list()
	/// Associated list of template dmm files that players can purchase to claim as their own sanctuaries.
	var/list/available_templates = list()

/datum/controller/subsystem/remote_sanctuaries/Initialize(start_timeofday)
	var/spawn_num = 0
	for(var/obj/effect/landmark/remote_sanctuary_spawn/S in sanctuaries)
		spawn_num++
		world << span_notice("WOAH HEY THERE SPAWN #[spawn_num]")
	spawn_sanctuary("ryumi", "cozy_homestead")
	return ..()

/datum/controller/subsystem/remote_sanctuaries/proc/claim_sanctuary(var/mob/living/carbon/human/claimer, var/sanctuary_id)
	spawn_sanctuary(claimer.ckey, sanctuary_id)
	to_chat(claimer, span_notice("My sanctuary is ready."))

/datum/controller/subsystem/remote_sanctuaries/proc/spawn_sanctuary(var/owner_ckey, var/sanctuary_id)

