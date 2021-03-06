/obj/item/device/assembly/igniter
	name = "igniter"
	desc = "A small electronic device able to ignite combustable substances."
	icon_state = "igniter"
	m_amt = 500
	g_amt = 50
	origin_tech = "magnets=1"
	var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread


/obj/item/device/assembly/igniter/New()
	..()
	sparks.set_up(2, 0, src)
	sparks.attach(src)


/obj/item/device/assembly/igniter/activate()
	if(!..())	return 0//Cooldown check
	var/turf/location = get_turf(loc)
	if(location)	location.hotspot_expose(1000,1000)
	sparks.start()
	if (istype(src.loc,/obj/item/device/assembly_holder))
		if (istype(src.loc.loc, /obj/structure/reagent_dispensers/fueltank/))
			var/obj/structure/reagent_dispensers/fueltank/tank = src.loc.loc
			if (tank && tank.modded)
				tank.ex_act()
	return 1


/obj/item/device/assembly/igniter/attack_self(mob/user as mob)
	activate()
	add_fingerprint(user)
	return