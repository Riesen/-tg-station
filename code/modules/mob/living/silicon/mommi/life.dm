/mob/living/silicon/robot/mommi/Life()
	set invisibility = 0
	//set background = 1
	set background = BACKGROUND_ENABLED

	//Status updates, death etc.
	clamp_values()
	handle_regular_status_updates()
	handle_regular_hud_updates()
	if (client)
		handle_regular_hud_updates()
		update_items()
	if (src.stat != DEAD) //still using power
		use_power()
	update_canmove()
	update_gravity(mob_has_gravity())
	handle_fire()
	if(killswitch)
		process_killswitch()
//	handle_beams()




/mob/living/silicon/robot/mommi/clamp_values()

	SetStunned(min(stunned, 30))
	SetParalysis(min(paralysis, 30))
	SetWeakened(min(weakened, 20))
	sleeping = 0
	adjustBruteLoss(0)
	adjustToxLoss(0)
	adjustOxyLoss(0)
	adjustFireLoss(0)


/mob/living/silicon/robot/mommi/use_power()
	if (src.cell)
		if(src.cell.charge <= 0)
			uneq_all()
			src.stat = 1
		else if (src.cell.charge <= 100)
			src.module_active = null
			src.sight_state = null
			src.tool_state = null
			src.sight_mode = 0
			src.cell.use(1)
		else
			if(src.tool_state)
				src.cell.use(5)
			src.cell.use(1)
	//		src.blinded = 0
			src.stat = 0
	else
		uneq_all()
		src.stat = 1


/mob/living/silicon/robot/mommi/handle_regular_status_updates()

	if(src.camera && !scrambledcodes)
		if(src.stat == 2 || wires.IsCameraCut())
			src.camera.status = 0
		else
			src.camera.status = 1

	health = maxHealth - (getOxyLoss() + getFireLoss() + getBruteLoss())

	if(getOxyLoss() > 50) Paralyse(3)

	if(src.sleeping)
		Paralyse(3)
		src.sleeping--

	if(src.resting)
		Weaken(5)

	if(health <= 0 && src.stat != 2) //die only once
		gib()

	if (src.stat != 2) //Alive.
		if (src.paralysis || src.stunned || src.weakened) //Stunned etc.
			src.stat = 1
			if (src.stunned > 0)
				AdjustStunned(-1)
			if (src.weakened > 0)
				AdjustWeakened(-1)
			if (src.paralysis > 0)
				AdjustParalysis(-1)
//				src.blinded = 1
			else
//				src.blinded = 0

		else	//Not stunned.
			src.stat = 0

	else //Dead.
	//	src.blinded = 1
		src.stat = 2

	if (src.stuttering) src.stuttering--

	if (src.eye_blind)
		src.eye_blind--
//		src.blinded = 1

	if (src.ear_deaf > 0) src.ear_deaf--
	if (src.ear_damage < 25)
		src.ear_damage -= 0.05
		src.ear_damage = max(src.ear_damage, 0)

	src.density = !( src.lying )

//	if ((src.sdisabilities & BLIND))
//		src.blinded = 1
//	if ((src.sdisabilities & DEAF))
//		src.ear_deaf = 1

	if (src.eye_blurry > 0)
		src.eye_blurry--
		src.eye_blurry = max(0, src.eye_blurry)

	if (src.druggy > 0)
		src.druggy--
		src.druggy = max(0, src.druggy)

	return 1

	if (src.healths)
		if (src.stat != 2)
			switch(health)
				if(45 to INFINITY)
					src.healths.icon_state = "health0"
				if(20 to 45)
					src.healths.icon_state = "health1"
				if(10 to 20)
					src.healths.icon_state = "health3"
				if(0 to 10)
					src.healths.icon_state = "health4"
				if(config.health_threshold_dead to 0)
					src.healths.icon_state = "health5"
				else
					src.healths.icon_state = "health6"
		else
			src.healths.icon_state = "health7"

	if (src.syndicate && src.client)
		if(ticker.mode.name == "traitor")
			for(var/datum/mind/tra in ticker.mode.traitors)
				if(tra.current)
					var/I = image('icons/mob/mob.dmi', loc = tra.current, icon_state = "traitor")
					src.client.images += I
		if(src.connected_ai)
			src.connected_ai.connected_robots -= src
			src.connected_ai = null
		if(src.mind)
			if(!src.mind.special_role)
				src.mind.special_role = "traitor"
				ticker.mode.traitors += src.mind



/mob/living/silicon/robot/mommi/handle_regular_hud_updates()

	if (src.stat == 2 || src.sight_mode & BORGXRAY)
		src.sight |= SEE_TURFS
		src.sight |= SEE_MOBS
		src.sight |= SEE_OBJS
		src.see_in_dark = 8
		src.see_invisible = SEE_INVISIBLE_LEVEL_TWO
	else
		src.see_in_dark = 8
		if (src.sight_mode & BORGMESON && src.sight_mode & BORGTHERM)
			src.sight |= SEE_TURFS
			src.sight |= SEE_MOBS
			src.see_invisible = SEE_INVISIBLE_MINIMUM
		else if (src.sight_mode & BORGMESON)
			src.sight |= SEE_TURFS
			src.see_invisible = SEE_INVISIBLE_MINIMUM
			src.see_in_dark = 2
		else if (src.sight_mode & BORGTHERM)
			src.sight |= SEE_MOBS
			src.see_invisible = SEE_INVISIBLE_LEVEL_TWO
		else if (src.stat != 2)
			src.sight &= ~SEE_MOBS
			src.sight &= ~SEE_TURFS
			src.sight &= ~SEE_OBJS
			src.see_invisible = SEE_INVISIBLE_LEVEL_TWO
		if(see_override)
			see_invisible = see_override


	if (src.cell)
		var/cellcharge = src.cell.charge/src.cell.maxcharge
		switch(cellcharge)
			if(0.75 to INFINITY)
				clear_alert("charge")
			if(0.5 to 0.75)
				throw_alert("charge","lowcell",1)
			if(0.25 to 0.5)
				throw_alert("charge","lowcell",2)
			if(0.01 to 0.25)
				throw_alert("charge","lowcell",3)
			else
				throw_alert("charge","emptycell")
	else
		throw_alert("charge","nocell")
/*
	if(bodytemp)
		switch(src.bodytemperature) //310.055 optimal body temp
			if(335 to INFINITY)
				src.bodytemp.icon_state = "temp2"
			if(320 to 335)
				src.bodytemp.icon_state = "temp1"
			if(300 to 320)
				src.bodytemp.icon_state = "temp0"
			if(260 to 300)
				src.bodytemp.icon_state = "temp-1"
			else
				src.bodytemp.icon_state = "temp-2"
*/

	if(src.pullin)	src.pullin.icon_state = "pull[src.pulling ? 1 : 0]"
//Oxygen and fire does nothing yet!!
//	if (src.oxygen) src.oxygen.icon_state = "oxy[src.oxygen_alert ? 1 : 0]"
//	if (src.fire) src.fire.icon_state = "fire[src.fire_alert ? 1 : 0]"
/*
	client.screen.Remove(global_hud.blurry,global_hud.druggy)

	if ((src.blind && src.stat != 2))
		if(src.blinded)
			src.blind.layer = 18
		else
			src.blind.layer = 0
	//		if (src.disabilities & NEARSIGHTED)
	//			src.client.screen += global_hud.vimpaired

	//		if (src.eye_blurry)
	//			src.client.screen += global_hud.blurry

			if (src.druggy)
				src.client.screen += global_hud.druggy
*/
	if (src.stat != 2)
		if (src.machine)
			if (!( src.machine.check_eye(src) ))
				src.reset_view(null)
//		else
//			if(!client.adminobs)
//				reset_view(null)

	return 1


// MoMMIs only have one hand.
/mob/living/silicon/robot/mommi/update_items()
	if (src.client)
		src.client.screen -= src.contents
		for(var/obj/I in src.contents)
			//if(I && !(istype(I,/obj/item/weapon/cell) || istype(I,/obj/item/device/radio)  || istype(I,/obj/machinery/camera) || istype(I,/obj/item/device/mmi)))
			if(I)
				// Make sure we're not showing any of our internal components, as that would be lewd.
				// This way of doing it ensures that shit we pick up will be visible, wheras shit inside of us isn't.
				if(I!=src.cell && I!=src.radio && I!=src.camera && I!=src.mmi)
					src.client.screen += I
	//if(src.sight_state)
	//	src.sight_state:screen_loc = ui_inv2
	if(src.tool_state)
		src.tool_state:screen_loc = ui_inv1
		src.tool_state:layer = 20
	if(src.head_state)
		src.head_state:screen_loc = ui_borg_album
		src.head_state:layer = 20

/mob/living/silicon/robot/mommi/update_canmove()
	canmove = !(paralysis || stunned || weakened || buckled || lockcharge || anchored)
	return canmove



/mob/living/silicon/robot/mommi/proc/process_killswitch() //this proc is here to stop derelict mommis from getting on the station and shitting things up
	if(killswitch) //sanity
		if(src.z)  //If a mommi somehow escapes inside a locker, it'll get wrecked next tick life() processes
			if(!(src.z in allowed_z))
				src.killswitch()
				return
			return
		return
	return



/mob/living/silicon/robot/mommi/proc/killswitch()
 	src << "<span class= 'danger'> You have left the bounds of your operational area and your killswitch has been activated </span>"
 	src.dust()
 	return

