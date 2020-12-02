/obj/effect/proc_holder/changeling/fleshmend
	name = "Fleshmend"
	desc = "Our flesh rapidly regenerates, healing our wounds."
	helptext = "Heals a moderate amount of damage over a short period of time. Can be used while unconscious."
	chemical_cost = 25
	dna_cost = 2
	req_stat = UNCONSCIOUS

//Starts healing you every second for 10 seconds. Can be used whilst unconscious.
/obj/effect/proc_holder/changeling/fleshmend/sting_action(var/mob/living/user)
	user << "<span class='notice'>We begin to heal rapidly.</span>"
	spawn(0)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.restore_blood()
			H.remove_all_embedded_objects()
			if(H.dna)

				for(var/organname in H.organsystem.organlist)
					var/datum/organ/organdata = H.organsystem.organlist[organname]
					if(istype(organdata) && !organdata.exists())
						if(organdata.name == "organ") continue
						organdata.regenerate_organitem(H.dna) //We regenerate lost organs.
						if(organdata.exists())
							var/obj/item/organ/O = organdata.organitem
							if(istype(O))
								O.add_suborgans()
								O.on_insertion()
							user << "<span class='notice'>We regrow our [organdata.getDisplayName()]</span>"
			H.update_hud()
			H.update_body_parts()
			H.update_damage_overlays(0)


		for(var/i = 0, i<10,i++)
			user.adjustBruteLoss(-10)
			user.adjustOxyLoss(-10)
			user.adjustFireLoss(-10)
			sleep(10)

	feedback_add_details("changeling_powers","RR")
	return 1