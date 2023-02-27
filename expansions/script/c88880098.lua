--革命-戏法战斗
function c88880098.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_ATTACK)
	c:RegisterEffect(e1)

	--atk low
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_SZONE) 
	e2:SetProperty(EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c88880098.desreptg)
	e2:SetOperation(c88880098.desrepop)
	c:RegisterEffect(e2)

end

function c88880098.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackTarget() ~= nil and Duel.GetAttacker():GetPosition() == POS_FACEUP_ATTACK and Duel.GetAttackTarget():GetPosition() == POS_FACEUP_ATTACK  end 
end
function c88880098.desrepop(e,tp,eg,ep,ev,re,r,rp)

	local c=Duel.GetAttacker()
	local cb = Duel.GetAttackTarget()

	if cb == nil or cb:GetAttack() == c:GetAttack() then return end
	
	local high = c
	local low = c
	if cb:GetAttack() > c:GetAttack() then 
		high = cb
	end

	if cb:GetAttack() < c:GetAttack() then 
		low = cb
	end

	if high:IsRelateToBattle() then 
		if low:IsRelateToBattle() then	

			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
			e1:SetCountLimit(1)
			e1:SetValue(c88880098.valcon)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			low:RegisterEffect(e1)

			local e4=Effect.CreateEffect(e:GetHandler())
			e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e4:SetCode(EVENT_BATTLED)
			e4:SetOperation(c88880098.desop)
			e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			low:RegisterEffect(e4)

		end 
	end
end
function c88880098.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if tc and tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c88880098.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end