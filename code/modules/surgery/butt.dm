//SURGERY STEPS

/datum/surgery_step/saw/remove_butt
	name = "remove butt"
	var/datum/organ/limb/butt/B = null // B because "Butt"

/datum/surgery_step/saw/remove_butt/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	B = target.get_organdatum("butt")
	if(B && B.exists())
		user.visible_message("[user] begins to saw off [target]'s butt", "<span class ='notice'>You begin to saw off [target]'s butt...</span>")
	else
		user.visible_message("[user] looks for [target]'s butt.", "<span class ='notice'>You look for [target]'s butt...</span>")


/datum/surgery_step/insert_butt
	name = "insert butt"
	implements = list(/obj/item/organ/limb/butt = 100)
	var/datum/organ/limb/butt/B = null // B because "Butt"
	var/obj/item/organ/limb/butt/BU = null	//This'll be the tool

/datum/surgery_step/insert_butt/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	B = target.get_organdatum("butt")
	BU = tool
	user.visible_message("[user] begins to replace the butt on [target].", "<span class ='notice'>You begin to replace the butt on [target]...</span>")

//ACTUAL SURGERIES

/datum/surgery/butt_removal
	name = "butt removal"
	requires_organic_bodypart = 0
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/saw/remove_butt, /datum/surgery_step/close)
	species = list(/mob/living/carbon/human)
	possible_locs = list("groin")

/datum/surgery/butt_removal/can_start(mob/user, mob/living/carbon/target, datum/organ/organdata)
	organdata = target.get_organdatum("butt")
	if(organdata && organdata.exists())	//Can only be done if target has a butt
		return 1
	else return 0

/datum/surgery/butt_replacement
	name = "butt replacement"
	requires_organic_bodypart = 0
	steps = list(/datum/surgery_step/insert_butt, /datum/surgery_step/close)
	species = list(/mob/living/carbon/human)
	possible_locs = list("groin")

/datum/surgery/butt_replacement/can_start(mob/user, mob/living/carbon/target, datum/organ/organdata)
	organdata = target.get_organdatum("butt")
	if(organdata && (organdata.status & ORGAN_REMOVED))	//Can only be done when mob has no butt
		return 1
	else return 0

//SURGERY STEP SUCCESSES

/datum/surgery_step/saw/remove_butt/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(B.exists())
		if(ishuman(target))
			user.visible_message("[user] successfully saws off [target]'s butt!", "<span class='notice'>You successfully saw off [target]'s butt.</span>")
			B.dismember(ORGAN_REMOVED)
			add_logs(user, target, "amputated", addition="by removing his butt INTENT: [uppertext(user.a_intent)]")
	else
		user << "<span class='warning'>[target] has no butt!</span>"
	return 1

/datum/surgery_step/insert_butt/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!B.exists())
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			user.visible_message("[user] successfully replaces [target]'s butt!", "<span class='notice'>You successfully replace [target]'s butt.</span>")
			user.drop_item()
			if(BU.Insert(H))
				add_logs(user, target, "augmented", addition="by replacing his butt INTENT: [uppertext(user.a_intent)]")
				BU.loc = null
	else
		user << "<span class='warning'>[target] has no butt!</span>"
	return 1