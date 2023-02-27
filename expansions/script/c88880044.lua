--神陆G
function c88880044.initial_effect(c)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880044.descon)
	c:RegisterEffect(e7)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880044,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c88880044.cbcon)
	e2:SetOperation(c88880044.cbop)
	c:RegisterEffect(e2)
end
function c88880044.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880044.descon(e)
	return not Duel.IsExistingMatchingCard(c88880044.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c88880044.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and bt~=e:GetHandler() and bt:IsControler(tp)
end
function c88880044.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local at=Duel.GetAttacker()
		if at:IsAttackable() and not at:IsImmuneToEffect(e) and not c:IsImmuneToEffect(e) then
			Duel.CalculateDamage(at,c)
		end
	end
end