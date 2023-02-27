--番茄天国
function c88880073.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PLANT))
	e2:SetValue(c88880073.val)
	c:RegisterEffect(e2)


	--token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(88880073,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c88880073.sptg)
	e4:SetOperation(c88880073.spop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)

end
function c88880073.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c88880073.val(e,c)
	return Duel.GetMatchingGroupCount(c88880073.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)*200
end
function c88880073.spfilter(c)
	return c:GetRace() == RACE_PLANT and c:GetOriginalCode() ~= 88880074 and c:GetPreviousLocation() == LOCATION_HAND
end
function c88880073.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c88880073.spfilter,1,nil)
	end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c88880073.spop(e,tp,eg,ep,ev,re,r,rp)
	local p = eg:GetFirst():GetControler()
	if  Duel.GetLocationCount(p,LOCATION_MZONE)>0 then
		local token=Duel.CreateToken(tp,88880074)
		Duel.SpecialSummon(token,SUMMON_TYPE_SPECIAL,p,p,false,false,POS_FACEUP)
	end 
end

