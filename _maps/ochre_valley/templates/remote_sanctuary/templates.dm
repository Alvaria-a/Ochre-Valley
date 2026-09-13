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

/datum/map_template/remote_sanctuary/kazengun_retreat
	name = "Kazengun Retreat"
	sanctuary_id = "kazengun_retreat"
	price = 600 // This one is PARTICULARLY extravagant so it's a bit more pricey
	description = "Azurian architects consulted with the builders of Kazengun for direction while constructing this unique home next to a natural hot spring bubbling at the side of one of the local mountainsides. Comes with a kitchen, vomitorium, two bedrooms, and of course hot spring, as well as a couple."
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/kazengun_retreat.dmm"

/datum/map_template/remote_sanctuary/arena
	name = "Arena"
	sanctuary_id = "fight_zone"
	description = "By the demand of eccentric and wealthy Ravoxians, private arenas have been constructed, and this is one of them. A small colosseum, complete with a small kitchen and vomitrium, as well as some basic accommodations for an infirmary, as well as a couple viewpoints for spectators."
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/fight_zone.dmm"
