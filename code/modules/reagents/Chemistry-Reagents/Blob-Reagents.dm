// These can only be applied by blobs. They are what blobs are made out of.
// The 4 damage
datum/reagent/blob
	var/message = "The blob strikes you" //message sent to any mob hit by the blob
	var/message_living = null //extension to first mob sent to only living mobs i.e. silicons have no skin to be burnt

datum/reagent/blob/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	if(!istype(M, /mob/living)) //gods why
		return


datum/reagent/blob/boiling_oil
	name = "Boiling Oil"
	id = "boiling_oil"
	description = ""
	color = "#B68D00"
	message = "The blob splashes you with burning oil"

datum/reagent/blob/boiling_oil/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(15, BURN)
		M.adjust_fire_stacks(2)
		M.IgniteMob()
		if(show_message)
			send_message(M)
		M.emote("scream")

datum/reagent/blob/toxic_goop
	name = "Toxic Goop"
	id = "toxic_goop"
	description = ""
	color = "#008000"
	message_living = ", and you feel sick and nauseated"

datum/reagent/blob/toxic_goop/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(20, TOX)
		if(show_message)
			send_message(M)

datum/reagent/blob/skin_ripper
	name = "Skin Ripper"
	id = "skin_ripper"
	description = ""
	color = "#FF4C4C"
	message_living = ", and you feel your skin ripping and tearing off"

datum/reagent/blob/skin_ripper/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(20, BRUTE)
		if(show_message)
			send_message(M)
			M.emote("scream")

// Combo Reagents

datum/reagent/blob/skin_melter
	name = "Skin Melter"
	id = "skin_melter"
	description = ""
	color = "#7F0000"
	message_living = ", and you feel your skin char and melt"

datum/reagent/blob/skin_melter/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(10, BRUTE)
		M.apply_damage(10, BURN)
		M.adjust_fire_stacks(2)
		M.IgniteMob()
		if(show_message)
			send_message(M)
			M.emote("scream")

datum/reagent/blob/lung_destroying_toxin
	name = "Lung Destroying Toxin"
	id = "lung_destroying_toxin"
	description = ""
	color = "#00FFC5"
	message_living = ", and your lungs feel heavy and weak"

datum/reagent/blob/lung_destroying_toxin/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume,var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(20, OXY)
		M.losebreath += 15
		M.apply_damage(20, TOX)
		if(show_message)
			send_message(M)
// Special Reagents

datum/reagent/blob/acid
	name = "Acidic Liquid"
	id = "blob_acid"
	description = ""
	color = "#BD80F4"

datum/reagent/blob/acid/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		if(prob(50))
			M.acid_act(5,1,5)
			if(show_message)
				M << "<span class = 'userdanger'>The blob's tendrils melt through your equipment!</span>"
		M.apply_damage(10, BRUTE)

datum/reagent/blob/radioactive_liquid
	name = "Radioactive Liquid"
	id = "radioactive_liquid"
	description = ""
	color = "#00EE00"
	message_living = ", and your skin feels papery and everything hurts"

datum/reagent/blob/radioactive_liquid/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume,var/show_message = 1)
	..()
	if(method == TOUCH)
		if(istype(M, /mob/living/carbon/human))
			M.apply_damage(10, BRUTE)
			M.apply_effect(40,IRRADIATE,0) // irradiate the shit out of these fuckers
			if(prob(33))
				randmuti(M)
				if(prob(98))
					randmutb(M)
				domutcheck(M, null)
				updateappearance(M)
			if(show_message)
				send_message(M)

datum/reagent/blob/dark_matter
	name = "Dark Matter"
	id = "dark_matter"
	description = ""
	color = "#61407E"
	message = "You feel a thrum as the blob strikes you, and everything flies at you"

datum/reagent/blob/dark_matter/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(15, BRUTE)
		reagent_vortex(M, 0)
		if(show_message)
			send_message(M)

datum/reagent/blob/b_sorium
	name = "Sorium"
	id = "b_sorium"
	description = ""
	color = "#808000"
	message = "The blob slams into you, and sends you flying"

datum/reagent/blob/b_sorium/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		M.apply_damage(15, BRUTE)
		if(show_message)
			send_message(M)
		reagent_vortex(M, 1)


datum/reagent/blob/explosive // I'm gonna burn in hell for this one
	name = "Explosive Gelatin"
	id = "explosive"
	description = ""
	color = "#FFA500"
	message = "The blob strikes you, and its tendrils explode"

datum/reagent/blob/explosive/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume, var/show_message = 1)
	..()
	if(method == TOUCH)
		if(prob(75))
			if(show_message)
				send_message(M)
			explosion(M.loc, 0, 0, 1, 0, 0)

/proc/reagent_vortex(var/mob/living/M as mob, var/setting_type)
	var/turf/pull = get_turf(M)
	for(var/atom/movable/X in range(4,pull))
		if(istype(X, /atom/movable))
			if((X) && !X.anchored)
				if(setting_type)
					step_away(X,pull)
					step_away(X,pull)
					step_away(X,pull)
					step_away(X,pull)
				else
					X.throw_at(pull)

datum/reagent/blob/proc/send_message(var/mob/living/M as mob)
	var/totalmessage = message
	if(message_living && !issilicon(M))
		totalmessage += message_living
	totalmessage += "!"
	M << "<span class = 'userdanger'>[totalmessage]</span>"