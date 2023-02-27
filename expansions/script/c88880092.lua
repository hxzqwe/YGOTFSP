--タイム・ストリーム
function c88880092.initial_effect(c)
	aux.AddCodeList(c,88880091)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88880092,0))
	e1:SetCategory(CATEGORY_RELEASE+CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c88880092.target)
	e1:SetOperation(c88880092.activate)
	c:RegisterEffect(e1)
end
function c88880092.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x149) and c:IsType(TYPE_FUSION) and c:IsReleasableByEffect()
		and Duel.IsExistingMatchingCard(c88880092.ffilter,tp,LOCATION_EXTRA,0,1,nil,c:GetOriginalLevel(),e,tp,c)
end
function c88880092.ffilter(c,lv,e,tp,tc)
	return c:IsSetCard(0x149) and c:IsType(TYPE_FUSION) and c:GetOriginalLevel()==lv+2
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,true,false) and Duel.GetLocationCountFromEx(tp,tp,tc,c)>0
end
function c88880092.chkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x149) and c:IsType(TYPE_FUSION)
end
function c88880092.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsReleasableByEffect()
		and chkc:IsFaceup() and chkc:IsSetCard(0x149) and chkc:IsType(TYPE_FUSION) end
	if chk==0 then return Duel.IsExistingTarget(c88880092.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTarget(tp,c88880092.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_RELEASE,g,1,0,0)
end
function c88880092.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local lv=tc:GetOriginalLevel()
	if Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c88880092.ffilter,tp,LOCATION_EXTRA,0,1,1,nil,lv,e,tp,nil)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,SUMMON_TYPE_FUSION,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
	end
end
function c88880092.cfilter(c,e,tp)
	return c:IsSetCard(0x149) and c:IsType(TYPE_FUSION) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingTarget(c88880092.spfilter,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
