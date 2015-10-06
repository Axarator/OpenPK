AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )


include(		"shared.lua")
include(		"sv_walljump.lua")
include(		"sv_wallslide.lua")


hook.Add("Initialize", "Set Cvars", function()
	RunConsoleCommand("sv_gravity", 300)
	RunConsoleCommand("sv_sticktoground", 0)
	RunConsoleCommand("sv_airaccelerate", 25)
	RunConsoleCommand("mp_falldamage", 0)
end)


function GM:PlayerConnect( name, ip )
    print("Player: " .. name .. ", has entered the game")
end

function GM:PlayerInitialSpawn( ply )
    print("Player: " .. ply:Nick() .. ", has spawned.")
	ply:SetModel("models/player/kleiner.mdl")
	ply:SetTeam( 1 )
	ply:ConCommand( "sv_gravity 300" )
	ply:ConCommand( "sv_sticktoground 0" )
	ply:SetWalkSpeed( 500 )
	
end

RegenerateAmount = 1
RegenerateTime = 1
RegenerateMax = 100

function RegenerateHealth()
   for k,v in pairs(player.GetAll()) do
      if v:Alive() and v:OnGround() and v:Health() < RegenerateMax then
         v:SetHealth(math.min(v:Health() + RegenerateAmount, math.max(100,RegenerateMax)))
      end
   end
   timer.Simple(RegenerateTime, RegenerateHealth)
   end
RegenerateHealth()
	






