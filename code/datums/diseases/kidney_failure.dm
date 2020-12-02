/datum/disease/kidney_failure
	form = "Condition"
	name = "Kidney failure"
	max_stages = 3
	cure_text = "Kidney transplant"
	agent = "Toxins"
	viable_mobtypes = list(/mob/living/carbon/human)
	permeability_mod = 1
	desc = "If left untreated the subject will eventually die of toxin buildup."
	severity = "Dangerous!"
	longevity = 1000
	disease_flags = CAN_CARRY
	spread_flags = NON_CONTAGIOUS
	visibility_flags = HIDDEN_PANDEMIC
	required_organs = list(/obj/item/organ/internal/kidneys)


/datum/disease/kidney_failure/stage_act()
	..()

	switch(stage)
		if(1)
			if(prob(2))
				affected_mob << "<span class='warning'>You feel tired.</span>"
		if(2)
			var/obj/item/organ/internal/kidneys/K = null
			var/datum/organ/internal/kidneys/kidneys = affected_mob.get_organdatum("kidneys")
			if(kidneys && kidneys.exists())
				K = kidneys.organitem
			if(K)
				K.dysfunctional = 1
				K.update_icon()
			if(prob(3))
				affected_mob << "<span class='warning'>You feel a stabbing pain in your abdomen!</span>"
				affected_mob.Stun(rand(2,3))
				affected_mob.adjustToxLoss(1)
		if(3)
			if(prob(1))
				if (affected_mob.nutrition > 100)
					affected_mob.Stun(rand(4,6))
					affected_mob.visible_message("<span class='danger'>[affected_mob] throws up!</span>", \
												"<span class='userdanger'>[affected_mob] throws up!</span>")
					playsound(affected_mob.loc, 'sound/effects/splat.ogg', 50, 1)
					var/turf/location = affected_mob.loc
					if(istype(location, /turf/simulated))
						location.add_vomit_floor(affected_mob)
					affected_mob.nutrition -= 95
					affected_mob.adjustToxLoss(-1)
				else
					affected_mob << "<span class='userdanger'>You gag as you want to throw up, but there's nothing in your stomach!</span>"
					affected_mob.Weaken(10)
					affected_mob.adjustToxLoss(3)
			if(prob(5))
				affected_mob.adjustToxLoss(3)
				affected_mob.updatehealth()

