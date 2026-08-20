/obj/structure/skele_portal
	name = "skeleton portal"
	desc = "A bright portal torn through the fabric of the world, sounds of rattling bones and skeleton warcries can be heard on the other side. This can't be good."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "shitportal"
	max_integrity = 500 //keep it a bit more intact, you'll need an axe to properly take it down quickly.
	anchored = TRUE
	density = FALSE
	layer = BELOW_OBJ_LAYER
	var/playerskele = 0 //Seperate so that skeleton NPCs (IF EVER ADDED) don't hog player slots
	var/maxplayerskele = 100 //upped for player shenngions with these.
	var/datum/looping_sound/boneloop/soundloop
	attacked_sound = 'sound/vo/mobs/ghost/skullpile_hit.ogg'

/obj/structure/skele_portal/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	soundloop.start()

	set_light(3, 2, 20, l_color = "#7b60f3")
	playsound(loc, 'sound/misc/portalopen.ogg', 100, FALSE, pressure_affected = FALSE)

/obj/structure/skele_portal/attack_ghost(mob/dead/observer/user)
	if(QDELETED(user))
		return
	if(!in_range(src, user))
		return
	if(playerskele >= (maxplayerskele+1))
		to_chat(user, "<span class='danger'>Too many player Skeletons.</span>")
		return
	playerskele++
	var/mob/living/carbon/human/species/skeleton/no_equipment/target = new (get_turf(src))
	target.key = user.key
	SSjob.EquipRank(target, "Fortified Skeleton", TRUE)
	target.copy_known_languages_from(user, TRUE)
	target.visible_message(span_warning("[target]'s eyes light up with an eerie glow!"))
	addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "FORTIFIED SKELETON"), 3 SECONDS)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, choose_pronouns_and_body)), 7 SECONDS)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, select_skeleton_features)), 7 SECONDS)
	target.mind.AddSpell(new /obj/effect/proc_holder/spell/self/suicidebomb/lesser)
	to_chat(target, span_danger("You are a disposable antagonist, expect to die rather quickly. Make sure to abide by the Event Rules of Engagement. Now go cause problems and stir some conflict! Remember to roleplay where possible."))
	qdel(user)

/obj/structure/skele_portal/examine(mob/user) //Ghosts only can examine this.
	. = ..()
	if(!isliving(user))
		var/bonelives = (maxplayerskele-playerskele)
		. += span_bloody("The skeleton wars beckon! You can click this portal to join as a skeleton if there are bones remaining. There are [bonelives] bones left.")


/obj/structure/skele_portal/Destroy()
	soundloop.stop()
	. = ..()
