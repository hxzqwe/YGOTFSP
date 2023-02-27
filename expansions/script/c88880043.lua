--神陆C
function c88880043.initial_effect(c)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880043.descon)
	c:RegisterEffect(e7)

	--in
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCountLimit(1)
	e2:SetValue(c88880043.valcon)
	c:RegisterEffect(e2)
end
function c88880043.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880043.descon(e)
	return not Duel.IsExistingMatchingCard(c88880043.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c88880043.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
