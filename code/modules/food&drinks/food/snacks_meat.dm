R//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu


////////////////////////////////////////////FISH////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/cubancarp
	name = "\improper Cuban carp"
	desc = "A grifftastic sandwich that burns your tongue and then leaves it numb!"
	icon_state = "cubancarp"
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 1, "vitamin" = 4)
	bitesize = 3
	filling_color = "#CD853F"

/obj/item/weapon/reagent_containers/food/snacks/carpmeat
	name = "carp fillet"
	desc = "A fillet of spess carp meat."
	icon_state = "fishfillet"
	list_reagents = list("nutriment" = 2, "carpotoxin" = 2, "vitamin" = 2)
	bitesize = 6
	filling_color = "#FA8072"

/obj/item/weapon/reagent_containers/food/snacks/carpmeat/New()
	..()
	eatverb = pick("bite","chew","choke down","gnaw","swallow","chomp")

/obj/item/weapon/reagent_containers/food/snacks/carpmeat/imitation
	name = "imitation carp fillet"
	desc = "Almost just like the real thing, kinda."

/obj/item/weapon/reagent_containers/food/snacks/fishfingers
	name = "fish fingers"
	desc = "A finger of fish."
	icon_state = "fishfingers"
	list_reagents = list("nutriment" = 1, "vitamin" = 2)
	bitesize = 1
	filling_color = "#CD853F"

/obj/item/weapon/reagent_containers/food/snacks/fishandchips
	name = "fish and chips"
	desc = "I do say so myself chap."
	icon_state = "fishandchips"
	list_reagents = list("nutriment" = 1, "vitamin" = 2)
	filling_color = "#FA8072"

////////////////////////////////////////////MEATS AND ALIKE////////////////////////////////////////////

/obj/item/weapon/reagent_containers/food/snacks/tofu
	name = "tofu"
	desc = "We all love tofu."
	icon_state = "tofu"
	list_reagents = list("nutriment" = 2)
	filling_color = "#F0E68C"

/obj/item/weapon/reagent_containers/food/snacks/tendies
	name = "Chicken Tendies"
	desc = "Fills you up and gives you Good Boy Points."
	icon_state = "tendies"
	list_reagents = list("nutriment" = 5, "vitamin" = 2)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/spiderleg
	name = "spider leg"
	desc = "A still twitching leg of a giant spider... you don't really want to eat this, do you?"
	icon_state = "spiderleg"
	list_reagents = list("nutriment" = 2, "toxin" = 2)
	cooked_type = /obj/item/weapon/reagent_containers/food/snacks/boiledspiderleg
	filling_color = "#000000"

/obj/item/weapon/reagent_containers/food/snacks/cornedbeef
	name = "corned beef and cabbage"
	desc = "Now you can feel like a real tourist vacationing in Ireland."
	icon_state = "cornedbeef"
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 1, "vitamin" = 4)

/obj/item/weapon/reagent_containers/food/snacks/faggot
	name = "faggot"
	desc = "A great meal all round. Not a cord of wood."
	icon_state = "faggot"
	list_reagents = list("nutriment" = 4, "vitamin" = 1)
	filling_color = "#800000"

/obj/item/weapon/reagent_containers/food/snacks/sausage
	name = "sausage"
	desc = "A piece of mixed, long meat."
	icon_state = "sausage"
	filling_color = "#CD5C5C"

/obj/item/weapon/reagent_containers/food/snacks/sausage/New()
	..()
	eatverb = pick("bite","chew","nibble","deep throat","gobble","chomp")

/obj/item/weapon/reagent_containers/food/snacks/wingfangchu
	icon = 'icons/obj/food/soupsalad.dmi'
	name = "wing fang chu"
	desc = "A savory dish of alien wing wang in soy."
	icon_state = "wingfangchu"
	trash = /obj/item/weapon/reagent_containers/glass/bowl
	list_reagents = list("nutriment" = 1, "vitamin" = 2)


/obj/item/weapon/reagent_containers/food/snacks/bearsteak
	name = "Filet migrawr"
	desc = "Because eating bear wasn't manly enough."
	icon_state = "bearsteak"
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 2, "vitamin" = 5, "manlydorf" = 5)

/obj/item/weapon/reagent_containers/food/snacks/eggwrap
	name = "egg wrap"
	desc = "The precursor to Pigs in a Blanket."
	icon_state = "eggwrap"
	list_reagents = list("nutriment" = 1, "vitamin" = 3)
	filling_color = "#F0E68C"


/obj/item/weapon/reagent_containers/food/snacks/kebab
	trash = /obj/item/stack/rods
	icon_state = "kebab"
	w_class = 3

/obj/item/weapon/reagent_containers/food/snacks/kebab/human
	name = "human-kebab"
	desc = "A human meat, on a stick."
	list_reagents = list("nutriment" = 1, "vitamin" = 6)

/obj/item/weapon/reagent_containers/food/snacks/kebab/monkey
	name = "meat-kebab"
	desc = "Delicious meat, on a stick."
	list_reagents = list("nutriment" = 1, "vitamin" = 2)

/obj/item/weapon/reagent_containers/food/snacks/kebab/tofu
	name = "tofu-kebab"
	desc = "Vegan meat, on a stick."
	list_reagents = list("nutriment" = 1)

/obj/item/weapon/reagent_containers/food/snacks/monkeycube
	name = "monkey cube"
	desc = "Just add water!"
	icon_state = "monkeycube"
	bitesize = 12
	wrapped = 0
	list_reagents = list("nutriment" = 2)
	filling_color = "#CD853F"

/obj/item/weapon/reagent_containers/food/snacks/monkeycube/afterattack(obj/O, mob/user,proximity)
	if(!proximity) return
	if(istype(O,/obj/structure/sink) && !wrapped)
		user << "<span class='notice'>You place [src] under a stream of water...</span>"
		user.drop_item()
		loc = get_turf(O)
		return Expand()
	..()

/obj/item/weapon/reagent_containers/food/snacks/monkeycube/attack_self(mob/user)
	if(wrapped)
		Unwrap(user)

/obj/item/weapon/reagent_containers/food/snacks/monkeycube/proc/Expand()
	visible_message("<span class='notice'>[src] expands!</span>")
	new /mob/living/carbon/monkey(get_turf(src))
	qdel(src)

/obj/item/weapon/reagent_containers/food/snacks/monkeycube/proc/Unwrap(mob/user)
	icon_state = "monkeycube"
	desc = "Just add water!"
	user << "<span class='notice'>You unwrap the cube.</span>"
	wrapped = 0

/obj/item/weapon/reagent_containers/food/snacks/monkeycube/wrapped
	desc = "Still wrapped in some paper."
	icon_state = "monkeycubewrap"
	wrapped = 1

/obj/item/weapon/reagent_containers/food/snacks/enchiladas
	name = "enchiladas"
	desc = "Viva La Mexico!"
	icon_state = "enchiladas"
	list_reagents = list("nutriment" = 1, "vitamin" = 2)
	bitesize = 4
	filling_color = "#FFA07A"

/obj/item/weapon/reagent_containers/food/snacks/stewedsoymeat
	name = "stewed soy meat"
	desc = "Even non-vegetarians will LOVE this!"
	icon_state = "stewedsoymeat"
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 1)
	filling_color = "#D2691E"

/obj/item/weapon/reagent_containers/food/snacks/stewedsoymeat/New()
	..()
	eatverb = pick("slurp","sip","suck","inhale","drink")

/obj/item/weapon/reagent_containers/food/snacks/boiledspiderleg
	name = "boiled spider leg"
	desc = "A giant spider's leg that's still twitching after being cooked. Gross!"
	icon_state = "spiderlegcooked"
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 1, "capsaicin" = 2, "vitamin" = 2)
	filling_color = "#000000"

/obj/item/weapon/reagent_containers/food/snacks/spidereggsham
	name = "green eggs and ham"
	desc = "Would you eat them on a train? Would you eat them on a plane? Would you eat them on a state of the art corporate deathtrap floating through space?"
	icon_state = "spidereggsham"
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 1, "vitamin" = 3)
	bitesize = 4
	filling_color = "#7FFF00"

/obj/item/weapon/reagent_containers/food/snacks/sashimi
	name = "carp sashimi"
	desc = "Celebrate surviving attack from hostile alien lifeforms by hospitalising yourself."
	icon_state = "sashimi"
	list_reagents = list("nutriment" = 1, "capsaicin" = 4, "vitamin" = 4)
	filling_color = "#FA8072"