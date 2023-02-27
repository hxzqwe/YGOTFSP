--[暗同调]漆黑之朱姆沃尔特
function c88880024.initial_effect(c)
	
	c:EnableReviveLimit()
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c88880024.sprcon)
	e7:SetOperation(c88880024.sprop)
	c:RegisterEffect(e7)

	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)

	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880024,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c88880024.atcon)
	e2:SetTarget(c88880024.attg)
	e2:SetOperation(c88880024.atop)
	c:RegisterEffect(e2)
end
function c88880024.atcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:GetAttack()>e:GetHandler():GetAttack()
end
function c88880024.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():GetBattleTarget():CreateEffectRelation(e)
end
function c88880024.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() or tc:IsFacedown() or not tc:IsRelateToEffect(e)
		or tc:GetAttack()<=c:GetAttack() then return end
	
	 Duel.DiscardDeck(1-tp,math.ceil((tc:GetAttack() - c:GetAttack()) / 100),REASON_EFFECT)
	
end


function c88880024.tgrfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c88880024.tgrfilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0x838) 
end
function c88880024.tgrfilter2(c)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c88880024.mnfilter(c,g)
	return g:IsExists(c88880024.mnfilter2,1,c,c)
end
function c88880024.mnfilter2(c,mc)
	return c:GetLevel()-mc:GetLevel()==4
end
function c88880024.fselect(g,tp,sc)
	return g:GetCount()==2
		and g:IsExists(c88880024.tgrfilter1,1,nil) and g:IsExists(c88880024.tgrfilter2,1,nil)
		and g:IsExists(c88880024.mnfilter,1,nil,g)
		and Duel.GetLocationCountFromEx(tp,tp,g,sc)>0
end
function c88880024.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c88880024.tgrfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c88880024.fselect,2,2,tp,c)
end
function c88880024.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c88880024.tgrfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c88880024.fselect,false,2,2,tp,c)
	Duel.SendtoGrave(tg,REASON_COST)
end
