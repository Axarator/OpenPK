GM.Name = "Open Parkour"
GM.Author = "Axarator"
GM.Email = "N/A"
GM.Website = "N/A"

util.PrecacheModel("models/player/kleiner.mdl")

function GM:Initialize()
	self.BaseClass.Initialize( self )
end

team.SetUp( 1, "Parkour", Color(254,241,223))
