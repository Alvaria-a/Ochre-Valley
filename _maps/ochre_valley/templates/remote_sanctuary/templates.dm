/datum/map_template/remote_sanctuary
	var/sanctuary_id
	/// Description used in the shop to describe this shelter's contents
	var/description
	/// Cost in mammons to purchase this remote sanctuary from the shop.
	/// Owning one of these is a VERY luxurious opportunity, so keep them pricy!
	var/price = 500

/datum/map_template/remote_sanctuary/cozy_homestead
	name = "Mountain Cabin"
	sanctuary_id = "cozy_homestead"
	description = "A quiet little cabin at the side of a stream along the mountains neighboring Ochre Valley. Has a kitchen and vomitorium."
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/cozy_homestead.dmm"

/datum/map_template/remote_sanctuary/shitty_cave
	name = "Barren Cave"
	sanctuary_id = "shitty_cave"
	description = "One of the many recently discovered caves along the distant mountains. Barely any accommodations whatsoever, but with decent natural resources at one's disposal, an industrious owner could turn it into something special... with some effort."
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/shitty_cave.dmm"
