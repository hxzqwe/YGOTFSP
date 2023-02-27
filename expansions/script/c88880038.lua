--无限贷款
function c88880038.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)

	--token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)  
	e2:SetTarget(c88880038.sptg)
	e2:SetOperation(c88880038.spop)
	c:RegisterEffect(e2)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)

	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880038,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c88880038.condition)
	e3:SetTarget(c88880038.target2)
	e3:SetOperation(c88880038.operation)
	c:RegisterEffect(e3)
end


function c88880038.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer() and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2) and  Duel.IsExistingMatchingCard(c88880038.filter,e:GetOwnerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c88880038.filter(c,e,tp)
	return  c:IsCode(88880039)
end
function c88880038.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88880038.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
	end
	
	local g1 = Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g1,REASON_EFFECT)
	
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_HAND)
end
function c88880038.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c88880038.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		
	then 


		local g2 =Duel.SelectMatchingCard(tp,c88880038.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g2,REASON_EFFECT)
	end 
end

function c88880038.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetFirst():GetControler()~=e:GetOwnerPlayer() and (not eg:GetFirst():IsCode(88880039)) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c88880038.spop(e,tp,eg,ep,ev,re,r,rp)
	local mp = e:GetOwnerPlayer()

	if Duel.IsPlayerCanSpecialSummonMonster(mp,88880039,0,0x4011,0,0,1,RACE_ROCK,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE,1-mp) then
		  local token=Duel.CreateToken(mp,88880039)  
		  Duel.SpecialSummon(token,0x4011,mp,1-mp,false,false,POS_FACEUP_DEFENSE)  

			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_EFFECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(1)
			token:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			token:RegisterEffect(e2,true)
	end

end