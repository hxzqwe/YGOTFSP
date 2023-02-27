--地狱征收官  都一
function c88880037.initial_effect(c)
	c:SetUniqueOnField(1,0,88880037)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880037,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c88880037.condition)
	e2:SetTarget(c88880037.damtg)
	e2:SetOperation(c88880037.damop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetCondition(c88880037.indcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c88880037.indcon(e)
	return Duel.IsExistingMatchingCard(c88880037.filter,e:GetOwnerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c88880037.condition(e,tp,eg,ep,ev,re,r,rp)
	return  Duel.IsExistingMatchingCard(c88880037.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c88880037.filter(c)
	return c:IsCode(88880039)
end
function c88880037.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c88880037.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*1000)
end
function c88880037.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c88880037.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Damage(p,ct*1000,REASON_EFFECT)
end
