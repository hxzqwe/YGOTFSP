--[暗同调]暗黑航母
function c88880021.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c88880021.sprcon)
	e7:SetOperation(c88880021.sprop)
	c:RegisterEffect(e7)

	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88880021,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c88880021.sptg1)
	e1:SetOperation(c88880021.spop1)
	c:RegisterEffect(e1)

end
function c88880021.spfilter1(c,e,tp)
	return c:IsLevelAbove(8) and c:IsLevelBelow(8) and c:IsRace(RACE_MACHINE) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c88880021.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c88880021.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c88880021.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c88880021.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c88880021.spop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end


function c88880021.tgrfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1) 
end
function c88880021.tgrfilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0x838) 
end
function c88880021.tgrfilter2(c)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c88880021.mnfilter(c,g)
	return g:IsExists(c88880021.mnfilter2,1,c,c)
end
function c88880021.mnfilter2(c,mc)
	return c:GetLevel()-mc:GetLevel()==8
end
function c88880021.fselect(g,tp,sc)
	return g:GetCount()==2
		and g:IsExists(c88880021.tgrfilter1,1,nil) and g:IsExists(c88880021.tgrfilter2,1,nil)
		and g:IsExists(c88880021.mnfilter,1,nil,g)
		and Duel.GetLocationCountFromEx(tp,tp,g,sc)>0
end
function c88880021.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c88880021.tgrfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c88880021.fselect,2,2,tp,c)
end
function c88880021.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c88880021.tgrfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c88880021.fselect,false,2,2,tp,c)
	Duel.SendtoGrave(tg,REASON_COST)
end
