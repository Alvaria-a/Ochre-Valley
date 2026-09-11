/datum/map_template/remote_sanctuary
	var/sanctuary_id
	/// Description used in the shop to describe this shelter's contents
	var/description
	/// Cost in mammons to purchase this remote sanctuary from the shop
	var/price = 200

/datum/map_template/remote_sanctuary/cozy_homestead
	sanctuary_id = "cozy_homestead"
	description = "A quiet little cabin at the side of a stream along the mountains neighboring Ochre Valley. Has a kitchen and vomitorium."
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/cozy_homestead.dmm"
	price = 200
