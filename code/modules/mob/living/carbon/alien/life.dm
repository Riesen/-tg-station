
/mob/living/carbon/alien/check_breath(datum/gas_mixture/breath)
	if(status_flags & GODMODE)
		return

	if(!breath || (breath.total_moles() == 0))
		//Aliens breathe in vaccuum
		return 0

	var/toxins_used = 0
	var/breath_pressure = (breath.total_moles()*R_IDEAL_GAS_EQUATION*breath.temperature)/BREATH_VOLUME

	//Partial pressure of the toxins in our breath
	var/Toxins_pp = (breath.toxins/breath.total_moles())*breath_pressure

	if(Toxins_pp) // Detect toxins in air
		adjustPlasma(breath.toxins*250)
		throw_alert("alien_tox")

		toxins_used = breath.toxins

	else
		clear_alert("alien_tox")

	//Breathe in toxins and out oxygen
	breath.toxins -= toxins_used
	breath.oxygen += toxins_used

	//BREATH TEMPERATURE
	handle_breath_temperature(breath)

/mob/living/carbon/alien/update_sight()
	if(stat == DEAD)
		sight |= SEE_TURFS
		sight |= SEE_MOBS
		sight |= SEE_OBJS
		see_in_dark = 8
		see_invisible = SEE_INVISIBLE_LEVEL_TWO
	else
		see_in_dark =  4
		see_invisible =  SEE_INVISIBLE_LEVEL_TWO
		if(exists("eyes"))
			var/datum/organ/internal/eyes/eyedatum = get_organdatum("eyes")
			var/obj/item/organ/internal/eyes/E = eyedatum.organitem
			see_in_dark = max(see_in_dark, E.dark_sight)
			see_invisible = min(see_invisible, E.invis_sight)
			sight |= E.sight_flags
		see_in_dark = ((sight & SEE_TURFS) && (sight & SEE_MOBS) && (sight & SEE_OBJS)) ? 8 : see_in_dark  //Xray flag combo
		see_invisible = ((sight & SEE_TURFS) && (sight & SEE_MOBS) && (sight & SEE_OBJS)) ? SEE_INVISIBLE_MINIMUM : see_invisible //same here

		if(see_override)
			see_invisible = see_override


/mob/living/carbon/alien/handle_regular_status_updates()
	..()
	//natural reduction of movement delay due to stun.
	if(move_delay_add > 0)
		move_delay_add = max(0, move_delay_add - rand(1, 2))

	return 1

/mob/living/carbon/alien/handle_hud_icons()
	update_action_buttons()
	handle_actions()

	handle_hud_icons_health()

	return 1