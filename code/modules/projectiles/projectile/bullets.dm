/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = 0
	flag = "bullet"

/obj/item/projectile/bullet/weakbullet //beanbag, heavy stamina damage
	damage = 10
	stamina = 75
	stun = 2
	weaken = 2

/obj/item/projectile/bullet/weakbullet2 //detective revolver instastuns, but multiple shots are better for keeping punks down
	damage = 15
	stamina = 50
	stun = 3
	weaken = 3

/obj/item/projectile/bullet/weakbullet3
	damage = 20

/obj/item/projectile/bullet/toxinbullet
	damage = 15
	damage_type = TOX

/obj/item/projectile/bullet/armourpiercing
	damage = 17
	armour_penetration = 10

/obj/item/projectile/bullet/pellet
	name = "pellet"
	damage = 15
	dismember_class = new /datum/dismember_class/low/shotgun

/obj/item/projectile/bullet/pellet/weak
	damage = 3

/obj/item/projectile/bullet/pellet/random/New()
	damage = rand(10)


/obj/item/projectile/bullet/midbullet
	damage = 25
	stamina = 65 //two round bursts from the c20r knocks people down


/obj/item/projectile/bullet/midbullet2
	damage = 25

/obj/item/projectile/bullet/midbullet3
	damage = 35

/obj/item/projectile/bullet/heavybullet
	damage = 35

/obj/item/projectile/bullet/stunshot //taser slugs for shotguns, nothing special
	name = "stunshot"
	damage = 10
	stun = 5
	weaken = 5
	stutter = 5
	jitter = 20
	icon_state = "spark"
	color = "#FFFF00"

/obj/item/projectile/bullet/incendiary/on_hit(var/atom/target, var/blocked = 0)
	..()
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(1)
		M.IgniteMob()

/obj/item/projectile/bullet/incendiary/shell
	name = "incendiary slug"
	damage = 25

/obj/item/projectile/bullet/incendiary/shell/Move()
	..()
	var/turf/location = get_turf(src)
	if(!location)
		return

	PoolOrNew(/obj/effect/hotspot, location)
	location.hotspot_expose(700, 50, 1)

/obj/item/projectile/bullet/incendiary/shell/dragonsbreath
	name = "dragonsbreath round"
	damage = 5

/obj/item/projectile/bullet/incendiary/firebullet
	damage = 10

/obj/item/projectile/bullet/honker
	damage = 0
	weaken = 5
	stun = 5
	nodamage = 1
	hitsound = 'sound/items/bikehorn.ogg'
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "banana"

/obj/item/projectile/bullet/honker/New()
	..()
	SpinAnimation()

/*
you see this shit right here is EXACTLY why I don't code
/obj/item/projectile/bullet/henker
	damage = 0
	weaken = 5
	stun = 5
	stutter = 20
	nodamage = 1
	hitsound = 'sound/items/AirHorn.ogg'
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "banana"

/obj/item/projectile/bullet/henker/on_hit(var/mob/target) // dude procs lmao
	. = ..()
	if(!iscarbon(target))
		return 0
	var/mob/living/carbon/M = target
	var/ear_safety = M.check_ear_prot()
		if(!ear_safety)
			(M.ear_damage + 10, 100)
			M.ear_deaf = 10
		M << "<font color='red' size='7'>HONK</font>"

/obj/item/projectile/bullet/henker/New()
	..()
	SpinAnimation()
*/

/obj/item/projectile/bullet/meteorshot
	name = "meteor"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	weaken = 8
	stun = 8
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/item/projectile/bullet/meteorshot/on_hit(var/atom/target, var/blocked = 0)
	..()
	if(istype(target, /atom/movable))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.throw_at(throw_target, 3, 2)

/obj/item/projectile/bullet/meteorshot/New()
	..()
	SpinAnimation()

/obj/item/projectile/bullet/mime
	damage = 20

/obj/item/projectile/bullet/mime/on_hit(var/atom/target, var/blocked = 0)
	if(istype(target, /mob/living/carbon))
		var/mob/living/carbon/M = target
		M.silent = max(M.silent, 10)


/obj/item/projectile/bullet/dart
	name = "dart"
	icon_state = "cbbolt"
	damage = 6

/obj/item/projectile/bullet/dart/New()
	..()
	flags |= NOREACT
	create_reagents(50)

/obj/item/projectile/bullet/dart/on_hit(var/atom/target, var/blocked = 0, var/hit_zone)
	var/deflect = 0
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(M.can_inject(null,0,hit_zone)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
			..()
			reagents.trans_to(M, reagents.total_volume)
			return 1
		else
			deflect = 1
			target.visible_message("<span class='danger'>The [name] was deflected!</span>", \
								   "<span class='userdanger'>You were protected against the [name]!</span>")
	if(!deflect)
		..()
	flags &= ~NOREACT
	reagents.handle_reactions()
	return 1

/obj/item/projectile/bullet/dart/metalfoam
	New()
		..()
		reagents.add_reagent("aluminium", 15)
		reagents.add_reagent("foaming_agent", 5)
		reagents.add_reagent("facid", 5)

//This one is for future syringe guns update
/obj/item/projectile/bullet/dart/syringe
	name = "syringe"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringeproj"

/obj/item/projectile/bullet/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = TOX
	weaken = 5

/obj/item/projectile/bullet/neurotoxin/on_hit(var/atom/target, var/blocked = 0)
	if(isalien(target))
		return 0
	. = ..() // Execute the rest of the code.
