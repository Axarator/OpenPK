include( "shared.lua" )

surface.CreateFont( "OPK_FontSmall", { font = "Trebuchet18", size = 16, weight = 700, antialias = true } )
surface.CreateFont( "OPK_FontMed", { font = "Trebuchet18", size = 24, weight = 700, antialias = true } )
surface.CreateFont( "OPK_FontBig", { font = "Trebuchet18", size = 50, weight = 700, antialias = true } )


 function GM:HUDPaint()
local Ply = LocalPlayer()
local Spec = Ply:GetObserverTarget()
if IsValid( Spec ) and Spec:IsPlayer() then
Ply = Spec
end 


local Vel = Ply:GetVelocity()
local Speed = math.Round( Vector( Vel.x, Vel.y, 0 ):Length() / 10 )
if Speed < 8 then Speed = 0 end
draw.RoundedBox( 1, 40, ScrH()-200, 300, 40, Color( 240, 240, 240, 150 ) )
draw.RoundedBox( 1, 40, ScrH()-200, 40, 40, Color( 0, 119, 255, 150 ) )
draw.SimpleTextOutlined( Speed, "OPK_FontMed", 200, ScrH() - 180, Color( 245, 245, 245 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 44, 62, 80 ) )
draw.SimpleTextOutlined( 'Speed', "OPK_FontMed", 60, ScrH() - 180, Color( 245, 245, 245 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 44, 62, 80 ) )
end










