--[暗同调]猿魔王 塞曼
function c88880025.initial_effect(c)
	
	c:EnableReviveLimit()
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c88880025.sprcon)
	e7:SetOperation(c88880025.sprop)
	c:RegisterEffect(e7)

	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c88880025.aclimit)
	e1:SetCondition(c88880025.actcon)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880025,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c88880025.condition)
	e2:SetCost(c88880025.cost)
	e2:SetTarget(c88880025.target)
	e2:SetOperation(c88880025.activate)
	c:RegisterEffect(e2)
end
function c88880025.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c88880025.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c88880025.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp)
end
function c88880025.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c88880025.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88880025.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c88880025.cfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c88880025.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c88880025.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end

function c88880025.tgrfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1) 
end
function c88880025.tgrfilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0x838) 
end
function c88880025.tgrfilter2(c)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c88880025.mnfilter(c,g)
	return g:IsExists(c88880025.mnfilter2,1,c,c)
end
function c88880025.mnfilter2(c,mc)
	return c:GetLevel()-mc:GetLevel()==7
end
function c88880025.fselect(g,tp,sc)
	return g:GetCount()==2
		and g:IsExists(c88880025.tgrfilter1,1,nil) and g:IsExists(c88880025.tgrfilter2,1,nil)
		and g:IsExists(c88880025.mnfilter,1,nil,g)
		and Duel.GetLocationCountFromEx(tp,tp,g,sc)>0
end
function c88880025.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c88880025.tgrfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c88880025.fselect,2,2,tp,c)
end
function c88880025.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c88880025.tgrfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c88880025.fselect,false,2,2,tp,c)
	Duel.SendtoGrave(tg,REASON_COST)
end
