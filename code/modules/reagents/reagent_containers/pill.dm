/obj/item/weapon/reagent_containers/pill
	name = "pill"
	desc = "A tablet or capsule."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "pill"
	item_state = "pill"
	possible_transfer_amounts = null
	grind_reagents = list()
	volume = 50
	var/apply_type = INGEST
	var/apply_method = "swallow"
	var/roundstart = 0

/obj/item/weapon/reagent_containers/pill/New()
	..()
	if(!icon_state)
		icon_state = "pill[rand(1,20)]"
	if(reagents.total_volume && roundstart)
		name += " ([reagents.total_volume]u)"


/obj/item/weapon/reagent_containers/pill/attack_self(mob/user)
	return


/obj/item/weapon/reagent_containers/pill/attack(mob/M, mob/user, def_zone)
	if(!canconsume(M, user))
		return 0

	if(M == user)
		M << "<span class='notice'>You [apply_method] [src].</span>"

	else
		M.visible_message("<span class='danger'>[user] attempts to force [M] to [apply_method] [src].</span>", \
							"<span class='userdanger'>[user] attempts to force [M] to [apply_method] [src].</span>")

		if(!do_mob(user, M)) return

		M.visible_message("<span class='danger'>[user] forces [M] to [apply_method] [src].</span>", \
							"<span class='userdanger'>[user] forces [M] to [apply_method] [src].</span>")


	user.unEquip(src) //icon update
	add_logs(user, M, "fed", object="[reagentlist(src)]")
	loc = M //Put the pill inside the mob. This fixes the issue where the pill appears to drop to the ground after someone eats it.

	if(reagents.total_volume)
		reagents.reaction(M, apply_type)
		reagents.trans_to(M, reagents.total_volume)
		qdel(src)
		return 1
	else
		qdel(src)
		return 1
	return 0


/obj/item/weapon/reagent_containers/pill/afterattack(obj/target, mob/user , proximity)
	if(!proximity) return
	if(target.is_open_container() != 0 && target.reagents)
		if(!target.reagents.total_volume)
			user << "<span class='notice'>[target] is empty. There's nothing to dissolve [src] in.</span>"
			return
		user << "<span class='notice'>You dissolve [src] in [target].</span>"
		for(var/mob/O in viewers(2, user))	//viewers is necessary here because of the small radius
			O << "<span class='warning'>[user] slips something into [target].</span>"
		reagents.trans_to(target, reagents.total_volume)
		spawn(5)
			qdel(src)

/obj/item/weapon/reagent_containers/pill/tox
	name = "toxins pill"
	desc = "Highly toxic."
	icon_state = "pill5"
	list_reagents = list("toxin" = 50)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/cyanide
	name = "cyanide pill"
	desc = "Don't swallow this."
	icon_state = "pill5"
	list_reagents = list("cyanide" = 50)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/adminordrazine
	name = "adminordrazine pill"
	desc = "It's magic. We don't have to explain it."
	icon_state = "pill16"
	list_reagents = list("adminordrazine" = 50)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/morphine
	name = "morphine pill"
	desc = "Commonly used to treat insomnia."
	icon_state = "pill8"
	list_reagents = list("morphine" = 30)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/stoxin
	name = "morphine pill"
	desc = "Commonly used to treat insomnia."
	icon_state = "pill8"
	list_reagents = list("stoxin" = 30)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/stimulant
	name = "stimulant pill"
	desc = "Often taken by overworked employees, athletes, and the inebriated. You'll snap to attention immediately!"
	icon_state = "pill19"
	list_reagents = list("ephedrine" = 10, "ethylredoxrazine" = 10, "coffee" = 30) //>goofchem
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/dexalin
	name = "dexalin pill"
	desc = "Used to treat oxygen deprivation."
	icon_state = "pill18"
	list_reagents = list("dexalin" = 30)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/antitoxin
	name = "antitoxin pill"
	desc = "Neutralizes many common toxins."
	icon_state = "pill17"
	list_reagents = list("anti_toxin" = 50)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/inaprovaline
	name = "inaprovaline pill"
	desc = "Used to stabilize patients."
	icon_state = "pill5"
	list_reagents = list("inaprovaline" = 15)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/alkysine
	name = "alkysine pill"
	desc = "Used to treat brain damage."
	icon_state = "pill17"
	list_reagents = list("alkysine" = 50)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/ryetalyn
	name = "ryetalyn pill"
	desc = "Used to treat genetic damage."
	icon_state = "pill20"
	list_reagents = list("ryetalyn" = 50)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/kelotane
	name = "kelotane pill"
	desc = "Used to treat burns."
	icon_state = "pill5"
	list_reagents = list("kelotane" = 30)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/dermaline
	name = "dermaline pill"
	desc = "Used to treat severe burns."
	icon_state = "pill5"
	list_reagents = list("kelotane" = 25)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/bicaridine
	name = "dermaline pill"
	desc = "Used to treat physical injuries."
	icon_state = "pill5"
	list_reagents = list("bicaridine" = 30)
	roundstart = 1
/obj/item/weapon/reagent_containers/pill/insulin
	name = "insulin pill"
	desc = "Handles hyperglycaemic coma."
	icon_state = "pill5"
	list_reagents = list("insulin" = 50)
	roundstart = 1