/////////////////////////////////////////
////////////Service Designs//////////////
/////////////////////////////////////////

/datum/design/buffer
	name = "Floor Buffer Upgrade"
	desc = "A floor buffer that can be attached to vehicular janicarts."
	id = "buffer"
	req_tech = list("materials" = 5, "engineering" = 3, "service" = 1)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_GLASS = 200)
	build_path = /obj/item/janiupgrade
	category = list("service")

/datum/design/holosign
	name = "Holographic Sign Projector"
	desc = "A holograpic projector used to project various warning signs."
	id = "holosign"
	req_tech = list("magnets" = 3, "powerstorage" = 2, "service" = 1)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000)
	build_path = /obj/item/weapon/holosign_creator
	category = list("service")

/datum/design/flora_gun
	name = "Floral Somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells. Harmless to other organic life."
	id = "flora_gun"
	req_tech = list("materials" = 2, "biotech" = 3, "powerstorage" = 3, "service" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 500, "radium" = 20)
	build_path = /obj/item/weapon/gun/energy/floragun
	category = list("service")

/datum/design/galoshes
	name = "Galoshes"
	desc = "A pair of yellow rubber boots, designed to prevent slipping on wet surfaces."
	id = "galoshes"
	req_tech = list("materials" = 3 "service" = 3)
	build_type = PROTOLATHE
	materials = (MAT_METAL = 2000, "$uranium" = 1000)
	build_path = /obj/item/clothing/shoes/galoshes
	category = list("service")

/datum/design/soapnt
	name = "Soap"
	desc = "A Nanotrasen brand bar of soap. Smells of plasma."
	id = "soapnt"
	req_tech = ("plasma" = 2 "service" = 1)
	build_type = PROTOLATHE
	materials = (MAT_METAL = 1000, MAT_PLASMA = 1000)
	build_path = /obj/item/weapon/soap/nanotrasen
	category = list("service")

/datum/design/soapsyndie
	name = "Red Soap"
	desc = "An untrustworthy bar of soap made of strong chemical agents that dissolve blood faster."
	id = "soapsyndie"
	req_tech = ("plasma" = 2 "illegal" = 2, "service" = 1)
	build_type = PROTOLATHE
	materials = (MAT_PLASMA = 2000)
	build_path = /obj/item/weapon/soap/syndie
	category = list("service")

/datum/design/fastcart //needs to be created
	name = "Janicart SpeedBoost Module"
	desc = "An upgraded motor for the janicart which greatly improves the speed it travels."
	id = "fastcart"
	req_tech = ("materials" = 2 "programming" = 4, "magnets" = 2 "service" = 6)
	build_type = PROTOLATHE
	materials = (MAT_METAL = 2000, MAT_GOLD = 2000)
	build_path = /obj/item/devices/upgrades/fastcart
	category = list("service")

/datum/design/tankcart //needs to be created
	name = "Janicart Armor Module"
	desc = "Upgraded plating for the janicart which greatly improves the durability of it and protects the user."
	id = "tankcart"
	req_tech = ("materials" = 4 "service" = 5)
	build_type = PROTOLATHE
	materials = (MAT_METAL = 4000, MAT_PLASMA = 2000)
	build_path = /obj/item/devices/upgrades/tankcart
	category = list("service")

/datum/design/spacecart //needs to be created
	name = "Janicart Thruster Module"
	desc = "Adds a set of recharging thrusters to the janicart for those hard to reach messes in space."
	id = "spacecart"
	req_tech = ("materials" = 6, "magnets" = 4, "powerstorage" = 7, "service" = 8)
	build_type = PROTOLATHE
	materials = (MAT_METAL = 8000, "$uranium" = 4000, MAT_PLASMA = 4000)
	build_path = /obj/item/devices/upgrades/spacecart
	category = list("service")

/datum/design/whetstone
	name = "Whetstone"
	desc = "A strange stone used by many citizens of ancient Earth to sharpen metal tools."
	id = "whetstone"
	req_tech = ("materials" = 4 "service" = 3, "syndicate" = 3)
	build_type = PROTOLATHE
	materials = (MAT_METAL = 2500)
	build_path = /obj/item/weapon/kitchen/whetstone
	category = list("service")

/datum/design/borghypo
	name = "Advanced Shaker"
	desc = "A tool used to generate drinks, like the one service cyborgs use."
	id = "cyborg shaker"
	req_tech = list("materials" = 7 "programming" = 3, "powerstorage" = 4, "bluespace" = 4, "service" = 8)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 1000, MAT_DIAMOND = 2000)
	build_path = /obj/item/weapon/reagent_containers/borghypo/borgshaker/human
	category = list("service")

/datum/design/crack
	name = "Secret Spice"
	desc = "A fine white powder that makes most food and drinks taste REALLY good."
	id = "crack"
	req_tech = list("materials" = 4, "syndicate" = 3, "service" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_PLASMA = 500, MAT_GLASS = 500)
	build_path = /obj/item/weapon/reagent_containers/food/condiment/crack
	category = list("service")

/datum/design/plantbag
	name = "Plant Bag of Holding"
	desc = "A bag infused with bluespace magic to allow infinite storage of flora."
	id = "plantbag"
	req_tech = list("materials" =4 "magnets" = 4, "bluespace" = 3, "service" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 1000, MAT_DIAMOND = 2000)
	build_path = /obj/item/weapon/storage/bag/plants/holding
	category = list("service")

/datum/design/chainsaw
	name = "Chainsaw"
	desc = "A curious tool used to effectively and efficiently cuts down trees and hedges. Powered by ???."
	id = "chainsaw"
	req_tech = list("materials" = 5 "combat" = 5, "powerstorage" = 3, "syndicate" = 5, "service" = 8)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 1000, MAT_DIAMOND = 2000, MAT_PLASMA = 1000)
	build_path = /obj/item/weapon/twohanded/chainsaw
	category = list("service")

/datum/design/muffinmachine //needs to be created
	name = "Muffin Dispenser"
	desc = "A strange machine that generates unlimited muffins with the push of a button."
	id = "muffinmachine"
	req_tech = list("materials" = 6 "magnets" = 5, "programming" = 4, "powerstorage" = 4, "bluespace" = 6 "service" = 8)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 2000, MAT_DIAMOND = 4000)
	build_path = /obj/machinery/muffinmachine
	category = list("service")
