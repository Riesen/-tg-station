
/obj/structure/shuttle
	name = "shuttle"
	icon = 'icons/turf/shuttle.dmi'

/obj/structure/shuttle/CanAtmosPass(turf/T)
	return 0

/obj/structure/shuttle/engine
	name = "engine"
	density = 1
	anchored = 1.0
	var/active = 0
	var/brightness_strength = 1
	var/brightness_radius = 2
	var/brightness_color = "#ffffff"

/obj/structure/shuttle/engine/proc/toggle_light()
	if(active)
		set_light(0)
		active = 0
	else
		set_light(brightness_radius, brightness_strength, brightness_color)
		active = 1

/obj/structure/shuttle/engine/proc/set_active(bool)
	if(bool)
		set_light(brightness_radius, brightness_strength, brightness_color)
	else
		set_light(0)


/obj/structure/shuttle/engine/heater
	name = "heater"
	icon_state = "heater"

/obj/structure/shuttle/engine/platform
	name = "platform"
	icon_state = "platform"

/obj/structure/shuttle/engine/propulsion
	name = "propulsion"
	icon_state = "propulsion"
	opacity = 1

/obj/structure/shuttle/engine/propulsion/burst
	name = "burst"

/obj/structure/shuttle/engine/propulsion/burst/left
	name = "left"
	icon_state = "burst_l"

/obj/structure/shuttle/engine/propulsion/burst/right
	name = "right"
	icon_state = "burst_r"

/obj/structure/shuttle/engine/router
	name = "router"
	icon_state = "router"
