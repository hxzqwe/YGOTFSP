--天空核心
function c88880049.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c88880049.valcon)
	c:RegisterEffect(e1)
	--destroyed
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880049,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c88880049.thcon)
	e2:SetTarget(c88880049.thtg)
	e2:SetOperation(c88880049.thop)
	c:RegisterEffect(e2)

end
function c88880049.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c88880049.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c88880049.filter(c)
	return c:IsCode(88880050) or c:IsCode(88880051) or c:IsCode(88880054) or c:IsCode(88880057) or c:IsCode(88880058)
end
function c88880049.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,5,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND)

	if Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,0,1,nil) then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	end 
end
function c88880049.filterdis(c)
	return c:GetCode()
end
function c88880049.thop(e,tp,eg,ep,ev,re,r,rp)
	local ag=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	if ag:GetCount()>0 then
		Duel.Destroy(ag,REASON_EFFECT)
	end

	Duel.BreakEffect()   
	if(Duel.GetLocationCount(tp,LOCATION_MZONE) == 5) then
		local g=Duel.GetMatchingGroup(c88880049.filter,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,nil) 
		if g:GetClassCount(c88880049.filterdis) == 5 then	   
			local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,1,1,nil,88880050)
			local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,1,1,nil,88880051)
			g:Merge(Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,1,1,nil,88880054))
			g:Merge(Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,1,1,nil,88880057))
			g:Merge(Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,1,1,nil,88880058))
			if g1:GetCount() == 1 and g:GetCount() == 4 then
				Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
				
				local tc=g:GetFirst()
				while tc do
					Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
					tc=g:GetNext()
				end
				Duel.SpecialSummonComplete()
			end  
		end
	end
end