function WallSlide(ply)	
	
	JumpHeight = 50 
	

	local tr = 	util.TraceLine(util.GetPlayerTrace(ply, Vector(0, 0, -1)))
	if !tr.Hit then return end
	
	local HitDistance = tr.HitPos:Distance(tr.StartPos)
	if (HitDistance > JumpHeight) then
		local vForward = ply:GetForward():GetNormalized()
		local uVelocity = ply:GetVelocity()
		
		if ( ( ply:KeyDown(IN_ATTACK2) ) and not ( ply:IsOnGround() ) ) then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vForward*-20)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			
			if (tr.Fraction < 1.0) then
				uVelocity.z = 0.5

				ply:SetLocalVelocity(uVelocity)
				
			end



		end
		
		if ( ( ply:KeyDown(IN_ATTACK2) ) and not ( ply:IsOnGround() ) ) then
			local tracedata = {}
			tracedata.start = ply:GetPos()
			tracedata.endpos = ply:GetPos()+(vForward*900)
			tracedata.filter = ply
			local tr = util.TraceLine(tracedata)
			
			if (tr.Fraction < 1.0) then
				uVelocity.z = 0.5

				ply:SetLocalVelocity(uVelocity)
				
			end
		end

	end
end
hook.Add("KeyPress", "WallSlide", WallSlide)
