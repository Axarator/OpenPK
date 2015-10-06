CreateConVar( "pk_horiz", "300" , 268435456, "Horizontal walljump force" )
CreateConVar( "pk_vert", "300" , 268435456, "Vertical walljump force" )
CreateConVar( "pk_wjtime", "0.05" , 268435456, "Delay before you can jump on the wall again." )
CreateConVar( "pk_wjdecay", "0.05" , 268435456, "Don't worry about this value" )
CreateConVar( "pk_wjdecal", "0" , 268435456, "Mark left from walljumping. 0 = None, RedGlowFade is a nice one, but you can use ones like Blood too!" )


function WallJump(ply, key)	
	if !ply:KeyDown(IN_JUMP) then return end
	if (CurTime() < ply:GetNWInt("WalljumpTimer")) then return end
	pk_vert = GetConVarString("pk_vert")
	pk_horiz = GetConVarString("pk_horiz")
	pk_wjtime = GetConVarString("pk_wjtime")
	pk_wjdecay = GetConVarString("pk_wjdecay")
	WALLJUMPTIME = pk_wjtime
    WALLJUMPDECAY = pk_wjdecay
	ReboundPower = pk_horiz
	ReboundPowerUp = pk_vert
	local tr = 	util.TraceLine(util.GetPlayerTrace(ply, Vector(0, 0, -1)))
	if !tr.Hit then return end
	local HitDistance = tr.HitPos:Distance(tr.StartPos)
	if (HitDistance > 8) then
		local vForward = ply:GetForward():GetNormalized()
		local vRight = ply:GetRight():GetNormalized()
		local vVelocity = Vector(0,0,0)
		local pVelocity = ply:GetVelocity()
		//if (pVelocity.z < 0) then return end
		if ply:KeyDown(IN_MOVERIGHT) then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vRight*-24)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			if (tr.Fraction < 1.0) then
				WallJumpDecal(tr)
				vVelocity = pVelocity + (vRight * ReboundPower)
				vVelocity.z = pVelocity.z + ReboundPowerUp
				ply:SetLocalVelocity(vVelocity)
				WallJumpSound(ply)
				ply:SetNWInt("WalljumpTimer", CurTime() + WALLJUMPTIME + ply:GetNWInt("WalljumpCombo") * WALLJUMPDECAY)
			end
		end
		if ply:KeyDown(IN_MOVELEFT) then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vRight*24)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			if (tr.Fraction < 1.0) then
				WallJumpDecal(tr)
				vVelocity = pVelocity + (vRight * -ReboundPower)
				vVelocity.z = pVelocity.z + ReboundPowerUp
				ply:SetLocalVelocity(vVelocity)
				WallJumpSound(ply)
				ply:SetNWInt("WalljumpTimer", CurTime() + WALLJUMPTIME + ply:GetNWInt("WalljumpCombo") * WALLJUMPDECAY)
			end
		end
		if ply:KeyDown(IN_BACK) then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vForward*24)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			if (tr.Fraction < 1.0) then
				WallJumpDecal(tr)
				vVelocity = pVelocity + (vForward * -ReboundPower)
				vVelocity.z = pVelocity.z + ReboundPowerUp
				ply:SetLocalVelocity(vVelocity)
				WallJumpSound(ply)
				ply:SetNWInt("WalljumpTimer", CurTime() + WALLJUMPTIME + ply:GetNWInt("WalljumpCombo") * WALLJUMPDECAY)
			end
		end
		/*if ply:KeyDown(IN_FORWARD) and ply:OnGround() then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vForward*24)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			if (tr.Fraction < 1.0) then
				//vVelocity = pVelocity + (vForward * -ReboundPower)
				vVelocity.z = pVelocity.z + ReboundPowerUp * 0.5
				ply:SetLocalVelocity(vVelocity)
				WallJumpSound(ply)
				ply:SetNWInt("WalljumpTimer", CurTime() + WALLJUMPTIME + ply:GetNWInt("WalljumpCombo") * WALLJUMPDECAY)
			end
		end*/
		if ply:KeyDown(IN_FORWARD) then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vForward*-24)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			if (tr.Fraction < 1.0) then
				WallJumpDecal(tr)
				vVelocity = pVelocity + (vForward * ReboundPower)
				vVelocity.z = pVelocity.z + ReboundPowerUp
				ply:SetLocalVelocity(vVelocity)
				WallJumpSound(ply)
				ply:SetNWInt("WalljumpTimer", CurTime() + WALLJUMPTIME + ply:GetNWInt("WalljumpCombo") * WALLJUMPDECAY)
			end
		end
	end
end
hook.Add("KeyPress", "WallJump", WallJump)

function WallJumpSound(ply)
	ply:EmitSound("/physics/concrete/rock_impact_hard" .. math.random(1, 6) .. ".wav", math.Rand(90, 110), math.Rand(60, 80))
	WallJumpCombo(ply)
end
function WallJumpCombo(ply)
	ply:SetNWInt("WalljumpCombo", ply:GetNWInt("WalljumpCombo") + 1)
	//if (ply:GetNWInt("WalljumpCombo") > 1) then ply:PrintMessage(HUD_PRINTCENTER, "WALLJUMP x" .. ply:GetNWInt("WalljumpCombo")) end
end
function WallJumpDecal(tr)
    pk_wjdecal = GetConVarString("pk_wjdecal")
	util.Decal(pk_wjdecal, tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal)
end