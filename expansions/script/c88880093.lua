--新生代化石騎士 スカルポーン
function c88880093.initial_effect(c)
	aux.AddCodeList(c,88880091)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_ROCK),c88880093.matfilter,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c88880093.splimit)
	c:RegisterEffect(e1)

end
function c88880093.matfilter(c)
	return c:GetLevel()>0 and c:IsLevelBelow(4)
end
function c88880093.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(88880091) or not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
