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
	description = "By the demand of eccentric and wealthy Ravoxians, private arenas have been constructed, and this is one of them. A small colosseum, complete with a small kitchen and vomitorium, as well as some basic accommodations for an infirmary, as well as a couple viewpoints for spectators."
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/fight_zone.dmm"

/datum/map_template/remote_sanctuary/gambling_cave
	name = "Renovated Gambling Den"
	sanctuary_id = "gambling_cave"
	description = "Bandits, raiders, assassins, and criminals alike are oft known for building secret domiciles hidden from Astrata's inquisitorial gaze. Some such places grow in such popularity amongst heretics and criminals that they are given surprisingly impressive accommodations for what their ultimate purpose was. This used to be one of them. The heretical symbols have been rent from the walls, the unholy iconography peeled away so finely that one could never tell they were ever there, the traps removed, all threats cleaned and cleared out. These halls, once dedicated to Evyl, have since been entirely renovated and put to greater use: private use by the Tennites its original architects conspired against. What greater way to demoralize the worshipers of the Inhumen, after all, than to not merely destroy their hiding places, but comb away their original intents so finely that no trace of their deeds could be found by even the sharpest of eyes?"
	mappath = "_maps/ochre_valley/templates/remote_sanctuary/15x15/gambling_cave.dmm"
