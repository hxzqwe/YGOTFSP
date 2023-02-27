--神空C
function c88880054.initial_effect(c)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880054.descon)
	c:RegisterEffect(e7)
end
function c88880054.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880054.descon(e)
	return not Duel.IsExistingMatchingCard(c88880054.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end