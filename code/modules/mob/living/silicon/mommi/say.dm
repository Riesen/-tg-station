/*
/mob/living/silicon/robot/mommi/say_understands(var/other)
	if (istype(other, /mob/living/silicon/ai))
		return 1
	if (istype(other, /mob/living/silicon/decoy))
		return 1
	if (istype(other, /mob/living/silicon/robot))
		return 1
	if (istype(other, /mob/living/carbon/human))
		return 1
	if (istype(other, /mob/living/carbon/brain))
		return 1
	if (istype(other, /mob/living/silicon/pai))
		return 1
//	if (istype(other, /mob/living/silicon/hivebot))
//		return 1
	return ..()
*/

/mob/living/silicon/robot/mommi/handle_inherent_channels(message, message_mode)
	. = ..()
	if(.)
		return .

	if((keeper == 1) || message_mode == MODE_MOMMI)
		mommi_talk(message)
		return 1

/mob/living/silicon/robot/say_quote(var/text)
	var/ending = copytext(text, length(text))

	if(ending == "?")
		return "queries, \"<span class = 'robot'>[text]</span>\"";
	else if(copytext(text, length(text) - 1) == "!!")
		return "alarms, \"<span class = 'robot'><span class = 'yell'>[text]</span></span>\"";
	else if(ending == "!")
		return "declares, \"<span class = 'robot'>[text]</span>\"";

	return "states, \"<span class = 'robot'>[text]</span>\"";

/mob/living/silicon/robot/mommi/proc/mommi_talk(var/message)
	log_say("[key_name(src)] : [message]")

	message = trim(message)

	if (!message)
		return

	var/message_a = say_quote(message)
	var/rendered = "<i><span class='mommi game say'>Damage Control, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i>"

	for (var/mob/living/silicon/robot/mommi/S in world)
		if(istype(S))
			S.show_message(rendered, 2)

	for (var/mob/M in dead_mob_list)
		if(!istype(M,/mob/new_player) && !istype(M,/mob/living/carbon/brain)) //No meta-evesdropping
			rendered = "<i><span class='mommi game say'>Damage Control, <span class='name'>[name]</span> <a href='byond://?src=\ref[M];follow2=\ref[M];follow=\ref[src]'>(Follow)</a> <span class='message'>[message_a]</span></span></i>"
			M << rendered