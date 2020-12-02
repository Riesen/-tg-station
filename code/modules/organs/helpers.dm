/mob/proc/get_organdatum()
	return

/mob/living/carbon/get_organdatum(var/organ)
	if(organsystem) //If the mob has an organ system, you should give the name of the organ, i.e. "brain"
		return organsystem.get_organ(organ)

/mob/proc/get_organitem()
	return

/mob/living/carbon/get_organitem(var/organ)
	if(organsystem) //If the mob has an organ system, you should give the name of the organ, i.e. "brain"
		var/datum/organ/O = organsystem.get_organ(organ)
		return O.organitem  //Can be null!


/*
/mob/living/carbon/human/get_organ(var/organ)
	if(!organ)	organ = "chest"
	return ..(organ)
*/

/mob/proc/add_organ()
	return

//Adds an organ DATUM to the organsystem (used for suborgans). You probably shouldn't call this proc in most cases
/mob/living/carbon/add_organ(var/datum/organ/organ)
	if(organsystem)
		return organsystem.add_organ(organ)
	else return 0

mob/living/carbon/exists(var/organname)
	if(organsystem)
		var/datum/organ/O = get_organdatum(organname)
		return (O && O.exists())
	else
		return 1

mob/proc/exists(var/organname)
	return 1

/mob/proc/get_internal_organs(zone)
	return

//Return all the datum/organ/internal that are the selected organ's suborgans
/mob/living/carbon/get_internal_organs(zone)
	if(organsystem)
		var/list/returnorg = list()

		var/datum/organ/PO = get_organdatum(zone)
		if(PO && PO.exists() && isorgan(PO.organitem))
			if(istype(PO, /datum/organ/internal))	//If we've already found an internal organ we can skip the next step
				returnorg += PO
				return returnorg
			var/obj/item/organ/OI = PO.organitem
			for(var/organname in OI.suborgans)
				if(organname != "eyes")
					var/datum/organ/RO = OI.suborgans[organname]
					if(RO.exists() && istype(RO, /datum/organ/internal))	//Only internal organs, not limbs etc.
						returnorg += RO
		return returnorg

/mob/proc/get_all_internal_organs()

//Return all the datum/organ/internal in target
/mob/living/carbon/get_all_internal_organs()
	if(organsystem)
		var/list/returnorg = list()

		for(var/organname in organsystem.organlist)
			var/datum/organ/org = get_organdatum(organname)
			var/obj/item/OI = org.organitem
			if(isinternalorgan(OI))
				returnorg += org
		return returnorg

/mob/proc/has_organ_slot()
	return 0

//Returns whether the zone has a slot for the organ
/mob/living/carbon/has_organ_slot(zone, organname)
	if(organsystem)
		var/datum/organ/PO = get_organdatum(zone)
		if(PO && PO.exists())
			if(isorgan(PO.organitem))
				var/obj/item/organ/OI = PO.organitem
				var/datum/organ/RO = OI.suborgans[organname]
				return RO
		else if (PO && zone == organname)	//For eyes, mainly
			return PO
		return 0

/mob/living/carbon/proc/list_limbs()	//In case we want limbs for non-humans
	return null

//Gets us a convenient list of limbs that matter for stuff like rendering and checking damage.
//Please update this if you break down limbs into more limbs (arm to arm and hand or stuff like that). |- Ricotez
/mob/living/carbon/human/list_limbs()
	return list("head", "chest", "l_arm", "r_arm", "l_leg", "r_leg")

/mob/proc/get_limbs()
	return 0

/mob/proc/get_missing_limbs()
	return 0

/mob/proc/get_num_arms()
	return 2
/mob/proc/get_num_legs()
	return 2

/mob/living/carbon/human/get_num_arms()
	. = 0
	var/datum/organ/limb/L
	L = get_organdatum("r_arm")
	if(L && L.exists())
		.++
	L = get_organdatum("l_arm")
	if(L && L.exists())
		.++

/mob/living/carbon/human/get_num_legs()
	. = 0
	var/datum/organ/limb/L
	L = get_organdatum("r_leg")
	if(L && L.exists())
		.++
	L = get_organdatum("l_leg")
	if(L && L.exists())
		.++

//Returns all limb datums
/mob/living/carbon/get_limbs()
	if(organsystem)
		var/list/returnlimbs = list()
		for(var/limbname in list_limbs())
			var/datum/organ/limb/LI = get_organdatum(limbname)
			if(LI)
				returnlimbs += LI
		return returnlimbs

/mob/living/carbon/get_missing_limbs()
	if(organsystem)
		var/list/returnlimbs = list()
		for(var/limbname in list_limbs())
			var/datum/organ/limb/LI = get_organdatum(limbname)
			if(LI && !LI.exists())
				returnlimbs += LI
		return returnlimbs

proc/isorgan(atom/A)
	return istype(A, /obj/item/organ)

proc/isinternalorgan(atom/A)
	return istype(A, /obj/item/organ/internal)

//Soon to be deprecated, only facehuggers need these
/mob/proc/getlimb()
	return

/mob/living/carbon/human/getlimb(typepath)
	return (locate(typepath) in organsystem.organlist)