// These only serve to represent the groin and mouth target zones
/datum/organ/abstract/

/datum/organ/abstract/remove(var/dism_type, var/newloc)
	return null

/datum/organ/abstract/groin
	name = "groin"
	organitem_type = /obj/item/organ/abstract/groin

/datum/organ/abstract/mouth
	name = "mouth"
	organitem_type = /obj/item/organ/abstract/mouth

/datum/organ/limb/
	name = "limb"
	var/icon_position = 0
	var/body_part = null
	organitem_type = /obj/item/organ/limb

	//Only set this variable to 1 if you want the limb to show up on the health doll.
	//Even when set to 1, a limb won't show up if the player does not have it.
	//Also you'll need to add an overlay sprite for the limb to screen_gen.dmi with the same name as the limb.
	var/healthdoll = 0

/datum/organ/limb/proc/counts_for_damage()
	return exists() && can_be_damaged

/datum/organ/limb/chest
	name = "chest"
	body_part = CHEST
	destroyed_dam = 200
	organitem_type = /obj/item/organ/limb/chest
	healthdoll = 1
	can_be_damaged = 1

/datum/organ/limb/chest/remove()	//DO NOT REMOVE CORE ORGANITEMS
	return null

/datum/organ/limb/chest/switch_organitem(var/obj/item/organ/neworgan)
	var/obj/item/oldorgan = ..(neworgan)
	if(oldorgan)
		if(owner && owner.organsystem.coreitem == oldorgan)
			owner.organsystem.coreitem = organitem
		qdel(oldorgan)	//dont' want any extra chests around. They're pointless anyway due to being core items that can't be placed anywhere

/datum/organ/limb/head
	name = "head"
	body_part = HEAD
	destroyed_dam = 200
	organitem_type = /obj/item/organ/limb/head
	healthdoll = 1
	can_be_damaged = 1

/datum/organ/limb/head/regenerate_organitem()	//Fucks with suborgans
	return null

/datum/organ/limb/arm/l_arm
	name = "l_arm"
	body_part = ARM_LEFT
	destroyed_dam = 40
	organitem_type = /obj/item/organ/limb/arm/l_arm
	healthdoll = 1
	can_be_damaged = 1

/datum/organ/limb/leg/l_leg
	name = "l_leg"
	body_part = LEG_LEFT
	destroyed_dam = 40
	organitem_type = /obj/item/organ/limb/leg/l_leg
	healthdoll = 1
	can_be_damaged = 1

/datum/organ/limb/arm/r_arm
	name = "r_arm"
	body_part = ARM_RIGHT
	destroyed_dam = 40
	organitem_type = /obj/item/organ/limb/arm/r_arm
	healthdoll = 1
	can_be_damaged = 1

/datum/organ/limb/leg/r_leg
	name = "r_leg"
	body_part = LEG_RIGHT
	destroyed_dam = 40
	organitem_type = /obj/item/organ/limb/leg/r_leg
	healthdoll = 1
	can_be_damaged = 1


/datum/organ/limb/butt
	name = "butt"
	organitem_type = /obj/item/organ/limb/butt

/datum/organ/limb/proc/make_robotic(var/drop_suborgans)
	return


/datum/organ/limb/head/make_robotic()
	var/RL = new /obj/item/organ/limb/head/robot(src)
	switch_organitem(RL)
	var/datum/organ/internal/eyes/EY = owner.get_organdatum("eyes")
	if(EY && EY.exists())
		var/obj/item/organ/internal/eyes/org = EY.organitem
		if(org.status == ORGAN_ORGANIC)
			EY.switch_organitem(new /obj/item/organ/internal/eyes/cyberimp)

/datum/organ/limb/head/make_robotic(drop_suborgans)
	var/RL = new /obj/item/organ/limb/chest/robot(src)
	switch_organitem(RL)
	for(var/datum/organ/internal/I in owner.get_internal_organs("chest"))
		if(I.status == ORGAN_ORGANIC && drop_suborgans) // FLESH IS WEAK
			I.dismember(ORGAN_REMOVED, special = 1)
	for(var/datum/organ/internal/I in owner.get_internal_organs("groin"))
		if(I.status == ORGAN_ORGANIC && drop_suborgans) // FLESH IS WEAK
			I.dismember(ORGAN_REMOVED, special = 1)
	owner.organsystem.remove_organ("egg")	//Can't get impregnated anymore

/datum/organ/limb/arm/l_arm/make_robotic()
	var/RL = new /obj/item/organ/limb/arm/l_arm/robot()
	switch_organitem(RL)

/datum/organ/limb/arm/r_arm/make_robotic()
	var/RL = new /obj/item/organ/limb/arm/r_arm/robot()
	switch_organitem(RL)

/datum/organ/limb/leg/r_leg/make_robotic()
	var/RL = new /obj/item/organ/limb/leg/r_leg/robot()
	switch_organitem(RL)

/datum/organ/limb/leg/l_leg/make_robotic()
	var/RL = new /obj/item/organ/limb/leg/l_leg/robot()
	switch_organitem(RL)