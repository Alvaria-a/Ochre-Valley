#define REMOTE_SANCTUARY_MAX_Z 2

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
	/// Markers of sanctuaries that have been claimed by a player. Associated list; key is the ckey of the claimer, value is a reference to the marker the sanctuary used to spawn itself.
	var/list/markers_claimed = list()

/datum/controller/subsystem/remote_sanctuaries/proc/claim_sanctuary(var/mob/living/carbon/human/claimer, var/sanctuary_id)
	var/datum/map_template/remote_sanctuary/claimed = get_claimed_sanctuary(claimer.ckey)
	if(claimed)
		to_chat(claimer, span_red("I've already claimed a sanctuary for this week."))
		return null
	try
		var/datum/map_template/remote_sanctuary/S = spawn_sanctuary(claimer.ckey, sanctuary_id)
		to_chat(claimer, span_notice("My sanctuary is ready."))
		message_admins("[ADMIN_LOOKUPFLW(claimer)] has claimed and spawned a remote sanctuary \"[S.name]\" at [ADMIN_VERBOSEJMP(T)]")
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
	markers_claimed[owner_ckey] = marker
	var/max_z = REMOTE_SANCTUARY_MAX_Z - 1
	// We search specifically in the inner area of the sanctuary
	// because realistically there should never be anything of note on the very edges of the template maps!
	for(var/s_z in min(T.z, T.z + max_z) to max(T.z, T.z + max_z))
		for(var/s_x in min(T.x+1, T.x + S.width-1) to max(T.x+1, T.x + S.width-2))
			for(var/s_y in min(T.y+1, T.y + S.height-1) to max(T.y+1, T.y + S.height-2))
				var/turf/s_t = locate(s_x, s_y, s_z)
				// Find every door and closet within our sanctuary's area
				// and assign it a lock that the user's sanctuary key will be able to lock/unlock
				var/obj/structure/mineral_door/D = locate() in s_t
				if(D)
					D.lockid = "sanctuary_[owner_ckey]"
					D.lockhash = GLOB.lockids[D.lockid]
				var/obj/structure/closet/C = locate() in s_t
				if(C)
					C.lockid = "sanctuary_[owner_ckey]"
					C.lockhash = GLOB.lockids[D.lockid]
	log_admin("[key_name(owner_ckey)] has claimed and spawned a remote sanctuary \"[S.name]\" at [ADMIN_VERBOSEJMP(T)]")
	return S

/datum/controller/subsystem/remote_sanctuaries/proc/get_claimed_sanctuary(var/sanctuary_owner_ckey)
	return sanctuaries_claimed[sanctuary_owner_ckey]

/datum/controller/subsystem/remote_sanctuaries/proc/get_claimed_sanctuary_marker(var/sanctuary_owner_ckey)
	return markers_claimed[sanctuary_owner_ckey]

#undef REMOTE_SANCTUARY_MAX_Z
