--junheng
function c88880078.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c88880078.condition)
	e1:SetTarget(c88880078.target)
	e1:SetOperation(c88880078.activate)
	c:RegisterEffect(e1)
end
function c88880078.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return eg:GetCount()==1 and ec:IsPreviousControler(tp) and ec:IsRace(RACE_BEAST)
		and bit.band(ec:GetPreviousRaceOnField(),RACE_BEAST)~=0
		and ec==Duel.GetAttackTarget() and ec:IsLocation(LOCATION_GRAVE) and ec:IsReason(REASON_BATTLE)
end
function c88880078.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
		and tc:IsCanBeEffectTarget(e) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
	end
	Duel.SetTargetCard(tc)

	local ec=tc:GetReasonCard()
	e:SetLabelObject(ec)

	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c88880078.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.BreakEffect()
		local ec = e:GetLabelObject()
		if ec:IsRelateToBattle() then Duel.Remove(ec,REASON_EFFECT) end
	end
end