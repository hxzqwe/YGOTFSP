--[暗同调]月影龙 基利亚
function c88880026.initial_effect(c)
   
	c:EnableReviveLimit()
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c88880026.sprcon)
	e7:SetOperation(c88880026.sprop)
	c:RegisterEffect(e7)


	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880026,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c88880026.spcon)
	e2:SetTarget(c88880026.sptg)
	e2:SetOperation(c88880026.spop)
	c:RegisterEffect(e2)


	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(88880026,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c88880026.descon)
	e4:SetTarget(c88880026.destg)
	e4:SetOperation(c88880026.desop)
	c:RegisterEffect(e4)
end
function c88880026.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c88880026.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c88880026.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end


function c88880026.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c88880026.spfilter(c,e,tp)
	return c:IsCode(39823987) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c88880026.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c88880026.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c88880026.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c88880026.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c88880026.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end


function c88880026.tgrfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c88880026.tgrfilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0x838) 
end
function c88880026.tgrfilter2(c)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c88880026.mnfilter(c,g)
	return g:IsExists(c88880026.mnfilter2,1,c,c)
end
function c88880026.mnfilter2(c,mc)
	return c:GetLevel()-mc:GetLevel()==6
end
function c88880026.fselect(g,tp,sc)
	return g:GetCount()==2
		and g:IsExists(c88880026.tgrfilter1,1,nil) and g:IsExists(c88880026.tgrfilter2,1,nil)
		and g:IsExists(c88880026.mnfilter,1,nil,g)
		and Duel.GetLocationCountFromEx(tp,tp,g,sc)>0
end
function c88880026.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c88880026.tgrfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c88880026.fselect,2,2,tp,c)
end
function c88880026.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c88880026.tgrfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c88880026.fselect,false,2,2,tp,c)
	Duel.SendtoGrave(tg,REASON_COST)
end
