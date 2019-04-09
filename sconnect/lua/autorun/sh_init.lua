AddCSLuaFile()

sconnect = {}

sconnect.enabled = true

sconnect.config = {}
sconnect.config.connection = {
	["IP"] = "00.11.22.33:1234", //IP for the target server as a string with port included
	["HasPassword"] = true, //Whether the target server has a password or not
	["Password"] = "password", //Password for the target server - will do nothing if HasPassword is false.
}

sconnect.config.area = {
	["Pos1"] = Vector(497.683044, -1023.431946, -79.968750), //First corner of the box that will "teleport" players to other server
	["Pos2"] = Vector(-1030.294312, -1915.455811, 391.483185), //Second corner (should be opposite from the first)
}
