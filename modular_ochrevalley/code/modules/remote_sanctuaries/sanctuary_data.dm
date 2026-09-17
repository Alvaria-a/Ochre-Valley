/datum/sanctuary_data
	var/owner_ckey
	var/turf/min_turf
	var/min_x
	var/mix_y
	var/min_z
	var/max_x
	var/max_y
	var/max_z
	/// The template that was used to generate our sanctuary.
	var/datum/map_template/remote_sanctuary/used_template
	/// The keymaster exit in this sanctuary that can take players out of it.
	var/obj/item/roguemachine/keymaster/exit/sanctuary_exit
