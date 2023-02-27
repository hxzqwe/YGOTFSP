--[暗同调]冰结之菲茨杰拉德
function c88880022.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c88880022.sprcon)
	e7:SetOperation(c88880022.sprop)
	c:RegisterEffect(e7)

	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c88880022.aclimit)
	e1:SetCondition(c88880022.actcon)
	c:RegisterEffect(e1)

	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880022,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c88880022.spcon)
	e2:SetTarget(c88880022.sptg)
	e2:SetOperation(c88880022.spop)
	c:RegisterEffect(e2)

	--destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880022,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetTarget(c88880022.target2)
	e3:SetOperation(c88880022.operation2)
	c:RegisterEffect(e3)
end
function c88880022.filter2(c)
	return c:GetAttackAnnouncedCount()==1 and c:IsCode(88880022)
end
function c88880022.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c88880022.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c88880022.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c88880022.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end

function c88880022.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c88880022.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c88880022.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end

function c88880022.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c88880022.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end

function c88880022.tgrfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1) 
end
function c88880022.tgrfilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0x838) 
end
function c88880022.tgrfilter2(c)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c88880022.mnfilter(c,g)
	return g:IsExists(c88880022.mnfilter2,1,c,c)
end
function c88880022.mnfilter2(c,mc)
	return c:GetLevel()-mc:GetLevel()==5
end
function c88880022.fselect(g,tp,sc)
	return g:GetCount()==2
		and g:IsExists(c88880022.tgrfilter1,1,nil) and g:IsExists(c88880022.tgrfilter2,1,nil)
		and g:IsExists(c88880022.mnfilter,1,nil,g)
		and Duel.GetLocationCountFromEx(tp,tp,g,sc)>0
end
function c88880022.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c88880022.tgrfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c88880022.fselect,2,2,tp,c)
end
function c88880022.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c88880022.tgrfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c88880022.fselect,false,2,2,tp,c)
	Duel.SendtoGrave(tg,REASON_COST)
end
