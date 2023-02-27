--混沌爆破
function c88880047.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c88880047.condition)
	e1:SetCost(c88880047.cost)
	e1:SetTarget(c88880047.target)
	e1:SetOperation(c88880047.activate)
	c:RegisterEffect(e1)
end
function c88880047.cfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(4)
end
function c88880047.cfilter1(c)
	return c:IsRace(RACE_MACHINE) and c:IsLevelBelow(1) and c:IsAbleToGraveAsCost()
end
function c88880047.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c88880047.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
		and Duel.GetMatchingGroup(c88880047.cfilter1,tp,LOCATION_DECK,0,nil):GetCount() >= 3
end
function c88880047.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c88880047.cfilter1,tp,LOCATION_DECK,0,3,3,nil)
	Duel.SendtoGrave(tg,REASON_COST)
end
function c88880047.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp+1-tp,LOCATION_MZONE)
end
function c88880047.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c88880047.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Destroy(g,REASON_EFFECT)
	end
end