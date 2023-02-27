--高额抽卡
function c88880048.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c88880048.target)
	e1:SetOperation(c88880048.activate)
	c:RegisterEffect(e1)
end
function c88880048.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,g:GetCount())
end
function c88880048.cfilter(c)
	return not c:IsRace(RACE_MACHINE)
end
function c88880048.cfilter1(c)
	return c:IsRace(RACE_MACHINE)
end
function c88880048.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c88880048.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(g1,REASON_EFFECT)

	local g=Duel.GetMatchingGroup(c88880048.cfilter1,tp,LOCATION_MZONE,0,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT,LOCATION_GRAVE)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
