
/datum/artifact_effect/gassleeping
	effecttype = "gassleeping"
	var/max_pressure
	var/target_percentage

/datum/artifact_effect/gassleeping/New()
	..()
	effect = pick(EFFECT_TOUCH, EFFECT_AURA)
	max_pressure = rand(25,250) //lower than other gases because this is a trace gas and doesn't play nice with other gases
	effect_type = pick(6,7)

/datum/artifact_effect/gassleeping/DoEffectTouch(var/mob/user)
	if(holder)
		var/datum/gas_mixture/env = holder.loc.return_air()
		if(env)
			var/datum/gas/sleeping_agent/H = locate(/datum/gas/sleeping_agent) in env.trace_gases
			if(!H)
				var/datum/gas/sleeping_agent/trace_gas = new
				env.trace_gases += trace_gas
				trace_gas.moles += rand(2,15)
			else if(H.moles < max_pressure)
				H.moles += rand(2,15)
			holder.air_update_turf(0)
		//	env.update_values()


/datum/artifact_effect/gassleeping/DoEffectAura()
	if(holder)
		var/datum/gas_mixture/env = holder.loc.return_air()
		if(env)
			var/datum/gas/sleeping_agent/H = locate(/datum/gas/sleeping_agent) in env.trace_gases
			if(!H)
				var/datum/gas/sleeping_agent/trace_gas = new
				env.trace_gases += trace_gas
				trace_gas.moles += pick(0, 0, 0.1, rand())
			else if(H.moles < max_pressure)
				H.moles += pick(0, 0, 0.1, rand())
			holder.air_update_turf(0)
		//	env.update_values()

