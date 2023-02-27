--双重漩涡
function c88880078.initial_effect(c)
	--destroy monster
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c88880078.target1)
	e1:SetOperation(c88880078.operation1)
	c:RegisterEffect(e1)
end
function c88880078.tgfilter1(c)
	return c:IsRace(RACE_MACHINE) and c:IsFaceup()
end
function c88880078.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingTarget(c88880078.tgfilter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local pg=Duel.SelectTarget(tp,c88880078.tgfilter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
	dg:Merge(pg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,2,0,0)
end
function c88880078.operation1(e,tp,eg,ep,ev,re,r,rp)
	local pc=eg:GetFirst()
	local dc=eg:GetNext()
	if pc:IsRelateToEffect(e) and dc:IsRelateToEffect(e) then
		Duel.Destroy(pc,REASON_EFFECT)
		Duel.Destroy(dc,REASON_EFFECT)
	end
end