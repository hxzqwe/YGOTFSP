--神空A3
function c88880052.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c88880052.spcon)
	e1:SetOperation(c88880052.spop)
	c:RegisterEffect(e1)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880052.descon)
	c:RegisterEffect(e7)
end
function c88880052.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880052.descon(e)
	return not Duel.IsExistingMatchingCard(c88880052.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c88880052.spfilter(c,ft)
	return c:IsFaceup() and c:IsCode(88880051) and c:IsReleasable() and (ft>0 or c:GetSequence()<5)
end
function c88880052.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.IsExistingMatchingCard(c88880052.spfilter,tp,LOCATION_MZONE,0,1,nil,ft)
end
function c88880052.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88880052.spfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.Release(g,REASON_COST)
end