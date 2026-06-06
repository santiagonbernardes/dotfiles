-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "desc:Samsung Display Corp. 0x414D",
	mode = "preferred",
	position = "auto",
	scale = 2,
})

hl.monitor({
	output = "",
	mode = "preferred",
	-- On top of the laptop screen
	position = "auto-center-up",
	scale = 1,
})
