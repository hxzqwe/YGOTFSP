--忘我画派
function c88880003.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)	
	e2:SetTarget(c88880003.sptg)
	e2:SetOperation(c88880003.spop)
	e2:SetCountLimit(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--cannot direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c88880003.atktarget)
	c:RegisterEffect(e4)

	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetCondition(c88880003.descon)
	e5:SetTarget(c88880003.destg)
	e5:SetOperation(c88880003.desop)
	c:RegisterEffect(e5)

end

function c88880003.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c88880003.desfilter(c)
	return c:IsCode(88880004)
end
function c88880003.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c88880003.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c88880003.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c88880003.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end


function c88880003.atktarget(e,c)
	return not c:IsCode(88880004)
end
function c88880003.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not eg:GetFirst():IsCode(88880004) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c88880003.opfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsDestructable() and not c:IsCode(88880004) 
end
function c88880003.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c88880003.opfilter,nil,e)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() then
			local atk = tc:GetAttack()
			local def = tc:GetDefense()
			local pos = tc:GetPosition()
			local con = tc:GetControler()
			Duel.Destroy(tc,REASON_EFFECT)
			if Duel.IsPlayerCanSpecialSummonMonster(con,88880004,0,0x4011,atk,def,1,RACE_SPELLCASTER,ATTRIBUTE_DARK,pos,con) then
				local token=Duel.CreateToken(con,88880004)		
				Duel.SpecialSummonStep(token,0x4011,con,con,false,false,pos)				
				local e1=Effect.CreateEffect(token)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_BASE_ATTACK)
				e1:SetValue(atk)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				token:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_SET_BASE_DEFENSE)
				e2:SetValue(def)
				token:RegisterEffect(e2)			
			end 
		end   
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end