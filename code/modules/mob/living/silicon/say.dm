/mob/living/silicon/say(var/message)
	return ..(message, "R")

/mob/living/proc/robot_talk(var/message)
	log_say("[key_name(src)] : [message]")
	var/desig = "Default Cyborg" //ezmode for taters
	if(istype(src, /mob/living/silicon))
		var/mob/living/silicon/S = src
		desig = trim_left(S.designation + " " + S.job)
	var/message_a = say_quote(message)
	var/rendered = "<i><span class='game say'>Robotic Talk, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i>"
	for(var/mob/M in living_mob_list)
		if(M.binarycheck())
			if(istype(M, /mob/living/silicon/ai))
				var/renderedAI = "<i><span class='game say'>Robotic Talk, <a href='?src=\ref[M];track=[name]'><span class='name'>[name] ([desig])</span></a> <span class='message'>[message_a]</span></span></i>"
				M << renderedAI
			else
				M << rendered
	for (var/mob/M in dead_mob_list)
		if(!istype(M,/mob/new_player) && !istype(M,/mob/living/carbon/brain)) //No meta-evesdropping
			rendered = "<i><span class='game say'>Robotic Talk, <span class='name'>[name]</span> <a href='byond://?src=\ref[M];follow2=\ref[M];follow=\ref[src]'>(Follow)</a> <span class='message'>[message_a]</span></span></i>"
			M << rendered


/mob/living/silicon/binarycheck()
	return 1

/mob/living/silicon/lingcheck()
	return 0 //Borged or AI'd lings can't speak on the ling channel.

/mob/living/silicon/radio(message, message_mode)
	. = ..()
	if(. != 0)
		return .

	if(message_mode == "robot")
		if (radio)
			radio.talk_into(src, message)
		return REDUCE_RANGE

	else if(message_mode in radiochannels)
		if(radio)
			radio.talk_into(src, message, message_mode)
			return ITALICS | REDUCE_RANGE

	return 0

/mob/living/silicon/get_message_mode(message)
	. = ..()
	if(..() == MODE_HEADSET)
		return MODE_ROBOT
	else
		return .

/mob/living/silicon/handle_inherent_channels(message, message_mode)
	. = ..()
	if(.)
		return .

	if(message_mode == MODE_BINARY)
		if(binarycheck())
			robot_talk(message)
			return 1
	return 0
