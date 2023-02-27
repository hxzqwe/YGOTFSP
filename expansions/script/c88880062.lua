--神智A3
function c88880062.initial_effect(c)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880062.descon)
	c:RegisterEffect(e7)


	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c88880062.spcon)
	e3:SetOperation(c88880062.spop)
	c:RegisterEffect(e3)

	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PIERCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c88880062.tg)
	c:RegisterEffect(e1)
end
function c88880062.tg(e,c)
	return c:IsSetCard(0x3013)
end

function c88880062.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880062.descon(e)
	return not Duel.IsExistingMatchingCard(c88880062.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c88880062.spfilter(c,ft)
	return c:IsFaceup() and c:IsCode(88880061) and c:IsReleasable() and (ft>0 or c:GetSequence()<5)
end
function c88880062.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.IsExistingMatchingCard(c88880062.spfilter,tp,LOCATION_MZONE,0,1,nil,ft)
end
function c88880062.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88880062.spfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.Release(g,REASON_COST)
end