/obj/machinery/mommi_spawner
	name = "MoMMI Fabricator"
	desc = "A large pad sunk into the ground."
	icon = 'icons/obj/robotics.dmi'
	icon_state = "mommispawner-idle"
	density = 1
	anchored = 1
	var/building=0
	var/metal=0
	var/metalPerMoMMI=10
	var/metalPerTick=1
	use_power = 1
	idle_power_usage = 20
	active_power_usage = 5000
	var/recharge_time=600 // 60s

/obj/machinery/mommi_spawner/power_change()
	if (powered())
		stat &= ~NOPOWER
	else
		stat |= NOPOWER
	update_icon()

/obj/machinery/mommi_spawner/proc/canSpawn()
	return !(stat & NOPOWER) && !building && metal >= metalPerMoMMI

/obj/machinery/mommi_spawner/process()
	if(stat & NOPOWER || building || metal >= metalPerMoMMI)
		return
	metal+=metalPerTick
	if(metal >= metalPerMoMMI)
		update_icon()

/obj/machinery/mommi_spawner/attack_ghost(var/mob/dead/observer/user as mob)
	if(building)
		user << "\red \The [src] is busy building something already."
		return 1

	if(jobban_isbanned(user, "MoMMI"))
		user << "\red \The [src] lets out an annoyed buzz."
		return 1

	if(metal < metalPerMoMMI)
		user << "\red \The [src] doesn't have enough metal to complete this task."
		return 1

	var response = alert(user, "Do you wish to be turned into a MoMMI at this position?", "Confirm", "Yes", "No")
	if (response != "Yes")
		return
	else
		building=1
		update_icon()
		spawn(50)
			makeMoMMI(user)

/obj/machinery/mommi_spawner/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O,/obj/item/device/mmi))
		var/obj/item/device/mmi/mmi = O
		if(building)
			user << "\red \The [src] is busy building something already."
			return 1
		if(!mmi.brainmob)
			user << "\red \The [mmi] appears to be devoid of any soul."
			return 1
		if(!mmi.brainmob.key)
			var/ghost_can_reenter = 0
			if(mmi.brainmob.mind)
				for(var/mob/dead/observer/G in player_list)
					if(G.can_reenter_corpse && G.mind == mmi.brainmob.mind)
						ghost_can_reenter = 1
						break
			if(!ghost_can_reenter)
				user << "<span class='notice'>\The [src] indicates that their mind is completely unresponsive; there's no point.</span>"
				return TRUE

		if(mmi.brainmob.stat == DEAD)
			user << "\red Yeah, good idea. Give something deader than the pizza in your fridge legs.  Mom would be so proud."
			return TRUE

		if(mmi.brainmob.mind in ticker.mode.head_revolutionaries)
			user << "\red \The [src]'s firmware lets out a shrill sound, and flashes 'Abnormal Memory Engram'. It refuses to accept \the [mmi]."
			return TRUE

		if(jobban_isbanned(mmi.brainmob, "Cyborg"))
			user << "\red \The [src] lets out an annoyed buzz and rejects \the [mmi]."
			return TRUE

		if(metal < metalPerMoMMI)
			user << "\red \The [src] doesn't have enough metal to complete this task."
			return TRUE

		building=1
		update_icon()
		user.drop_item()
		mmi.icon = null
		mmi.invisibility = 101
		mmi.loc=src
		spawn(50)
			makeMoMMI(mmi.brainmob)
		return TRUE

/obj/machinery/mommi_spawner/proc/makeMoMMI(var/mob/user)
	if(!user || !user.key)
		building=0
		update_icon()
		return
	var/mob/living/silicon/robot/mommi/M = new /mob/living/silicon/robot/mommi(get_turf(loc))
	if(!M)
		building=0
		update_icon()
		return

	//M.custom_name = created_name

	if(M.key)
		M.ghostize(1)
	M.key = user.key


	M.job = "MoMMI"
	M.generated = 1
	M.invisibility = 0

	M.initialize_killswitch()

	//M.cell = locate(/obj/item/weapon/cell) in contents
	//M.cell.loc = M
	user.loc = M//Should fix cybros run time erroring when blown up. It got deleted before, along with the frame.

	M.mmi = new /obj/item/device/mmi(M)
	M.mmi.transfer_identity(user)//Does not transfer key/client.

	spawn(50) //delay to hopefully prevent mind getting deleted while it still hasn't transfered
		qdel(user)

	metal=0
	building=0
	update_icon()
	M.updateicon()
	M.cell.maxcharge = 15000
	M.cell.charge = 15000

/obj/machinery/mommi_spawner/update_icon()
	if(stat & NOPOWER)
		icon_state="mommispawner-nopower"
	else if(metal < metalPerMoMMI)
		icon_state="mommispawner-recharging"
	else if(building)
		icon_state="mommispawner-building"
	else
		icon_state="mommispawner-idle"

/obj/machinery/mommi_spawner/wireless //For uprising event
	use_power = 0
	density = 0
	recharge_time = 0
	metalPerMoMMI = 0
	idle_power_usage = 0
	active_power_usage = 0