--神智G3
function c88880065.initial_effect(c)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880065.descon)
	c:RegisterEffect(e7)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880065,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c88880065.cbcon)
	e2:SetOperation(c88880065.cbop)
	c:RegisterEffect(e2)

	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c88880065.valcon)
	c:RegisterEffect(e1)

	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SPSUMMON_PROC)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c88880065.spcon)
	e3:SetOperation(c88880065.spop)
	c:RegisterEffect(e3)

end
function c88880065.spfilter(c,ft)
	return c:IsFaceup() and c:IsCode(88880064) and c:IsReleasable() and (ft>0 or c:GetSequence()<5)
end
function c88880065.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.IsExistingMatchingCard(c88880065.spfilter,tp,LOCATION_MZONE,0,1,nil,ft)
end
function c88880065.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88880065.spfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.Release(g,REASON_COST)
end

function c88880065.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c88880065.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880065.descon(e)
	return not Duel.IsExistingMatchingCard(c88880065.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c88880065.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return r~=REASON_REPLACE and bt~=e:GetHandler() and bt:IsControler(tp)
end
function c88880065.cbop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local at=Duel.GetAttacker()
		if at:IsAttackable() and not at:IsImmuneToEffect(e) and not c:IsImmuneToEffect(e) then
			Duel.CalculateDamage(at,c)
		end
	end
end