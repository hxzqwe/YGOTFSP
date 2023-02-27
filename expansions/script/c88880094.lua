--中生代化石騎士 スカルナイト
function c88880094.initial_effect(c)
	aux.AddCodeList(c,88880091)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),c88880094.matfilter,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c88880094.splimit)
	c:RegisterEffect(e1)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880094,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c88880094.atcon)
	e3:SetOperation(c88880094.atop)
	c:RegisterEffect(e3)

end
function c88880094.matfilter(c)
	return c:IsLevel(5,6)
end
function c88880094.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(88880091) or not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c88880094.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c and aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and c:IsChainAttackable()
end
function c88880094.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end

