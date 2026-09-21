/datum/map_edit_operation/deploy_keymasters
	name = "Deploy KEYMASTERs"
	/// Templates we will deploy depending on what town map we're on
	var/list/town_templates_to_use = alist(
		"map_files/ovdun_world" = list("keymaster_stand_town", 106, 88, 2), //X 106, Y 88, Z 2
		"map_files/jagged_jaw" = list("keymaster_stand_town", 178, 183, 3), // x 178, Y 183, Z 3
	)

/datum/map_edit_operation/deploy_keymasters/deploy(datum/map_config/config)
	. = ..()
	// Get the bottommost z-level of the current map
	var/station_z = SSmapping.levels_by_trait(ZTRAIT_STATION)[1]
	// Now where we go on the town is going to depend on what town map we're on...
	var/list/our_operation = town_templates_to_use[config.map_path]
	if(our_operation)
		var/template_id = our_operation[1]
		var/our_x = our_operation[2]
		var/our_y = our_operation[3]
		var/our_z = our_operation[4]
		if(!template_id || !our_x || !our_y || !our_z)
			return FALSE
		var/datum/map_template/M = SSmapping.map_templates[template_id]
		if(!M)
			return FALSE
		// We have our template and our coordinates.
		// Because template loading doesn't clear out objects or mobs that might be in the way,
		// we first gotta do it ourselves!
		// Atoms have not yet initialized while we're doing this, so this should be fine...?
		// Just do it for the bottommost Z-level, anything more is overkill and unnecessary
		for(var/s_x in min(our_x, our_x + M.width-1) to max(our_x, our_x + M.width-1))
			for(var/s_y in min(our_y, our_y + M.height-1) to max(our_y, our_y + M.height-1))
				var/turf/T = locate(s_x, s_y, station_z + our_z-1)
				for(var/thing in T.contents)
					if(isobj(thing))
						qdel(thing)
					if(ismob(thing))
						qdel(thing)
		// With all that cleared out, deploy it!
		var/turf/target = locate(our_x, our_y, station_z + our_z - 1)
		M.load(target)

	return TRUE
