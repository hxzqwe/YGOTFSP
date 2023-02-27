--滑翔伞机人
function c88880081.initial_effect(c)
	--no damage hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88880081,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c88880081.con)
	e1:SetCost(c88880081.cost)
	e1:SetOperation(c88880081.op)
	c:RegisterEffect(e1)

	--no damage grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880081,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c88880081.con)
	e2:SetCost(c88880081.cost1)
	e2:SetOperation(c88880081.op)
	c:RegisterEffect(e2)
end
function c88880081.con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp and Duel.GetAttackTarget()==nil and Duel.GetBattleDamage(tp)>0 and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c88880081.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c88880081.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c88880081.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end