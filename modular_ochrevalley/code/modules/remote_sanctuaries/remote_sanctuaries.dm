/obj/effect/landmark/remote_sanctuary_spawn
	name = "remote sanctuary spawn"
	icon_state = "x3"

/obj/effect/landmark/remote_sanctuary_spawn/Initialize(mapload)
	. = ..()
	SSremote_sanctuaries.all_sanctuary_markers += src
	SSremote_sanctuaries.markers_available += src

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
	/// All sanctuary markers that exist in the game world
	var/list/all_sanctuary_markers = list()
	/// Sanctuaries that have been claimed. Associated list; key is the ckey of the claimer, value is a reference to the template the sanctuary used to spawn itself.
	var/list/sanctuaries_claimed = list()
	/// Markers of sanctuaries that have not yet been claimed by a player.
	var/list/markers_available = list()

/datum/controller/subsystem/remote_sanctuaries/proc/claim_sanctuary(var/mob/living/carbon/human/claimer, var/sanctuary_id)
	var/datum/map_template/remote_sanctuary/claimed = get_claimed_sanctuary(claimer.ckey)
	if(claimed)
		to_chat(claimer, span_red("I've already claimed a sanctuary for this week."))
		return null
	try
		var/datum/map_template/remote_sanctuary/S = spawn_sanctuary(claimer.ckey, sanctuary_id)
		to_chat(claimer, span_notice("My sanctuary is ready."))
		return S
	catch(var/exception/error)
		to_chat(claimer, span_alert("My sanctuary could not be created correctly because of an error! Scream at a coder about this:\n'[error]'"))
		return null

/datum/controller/subsystem/remote_sanctuaries/proc/spawn_sanctuary(var/owner_ckey, var/sanctuary_id)
	var/datum/map_template/remote_sanctuary/S = SSmapping.remote_sanctuary_templates[sanctuary_id]
	var/obj/effect/landmark/remote_sanctuary_spawn/marker = markers_available[1]
	var/turf/T = marker.loc
	S.load(T, FALSE)
	markers_available.Remove(marker)
	sanctuaries_claimed[owner_ckey] = S
	log_admin("[key_name(owner_ckey)] has claimed and spawned a remote sanctuary at [ADMIN_VERBOSEJMP(T)]")
	return S

/datum/controller/subsystem/remote_sanctuaries/proc/get_claimed_sanctuary(var/sanctuary_owner_ckey)
	var/datum/map_template/remote_sanctuary/claimed = sanctuaries_claimed[sanctuary_owner_ckey]
	return claimed
