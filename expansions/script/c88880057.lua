--神空G
function c88880057.initial_effect(c)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c88880057.descon)
	c:RegisterEffect(e7)

	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c88880057.condition)
	e1:SetOperation(c88880057.operation)
	c:RegisterEffect(e1)
end
function c88880057.defilter(c)
	return c:IsSetCard(0x3013) and c:IsFaceup()
end
function c88880057.descon(e)
	return not Duel.IsExistingMatchingCard(c88880057.defilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end

function c88880057.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget() and Duel.GetAttackTarget():IsControler(tp)
end
function c88880057.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
