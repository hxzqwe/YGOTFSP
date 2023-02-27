--模仿
function c88880005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c88880005.target)
	e1:SetOperation(c88880005.activate)
	c:RegisterEffect(e1)
end
function c88880005.cfilter(c)
	return c:IsType(TYPE_TOKEN)
end
function c88880005.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsType(TYPE_TOKEN) end
	if chk==0 then return Duel.IsExistingTarget(c88880005.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	Duel.SelectTarget(tp,c88880005.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c88880005.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local atk = tc:GetAttack()
		local def = tc:GetDefense()
		Duel.Destroy(tc,REASON_EFFECT)
			if Duel.IsPlayerCanSpecialSummonMonster(tp,88880004,0,0x4011,atk,def,1,RACE_SPELLCASTER,ATTRIBUTE_DARK,POS_FACEUP,1-tp) then
				local token=Duel.CreateToken(1-tp,88880004)		
				Duel.SpecialSummon(token,0x4011,tp,1-tp,false,false,POS_FACEUP)				
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

				Duel.Damage(1-tp,math.ceil(atk/2),REASON_EFFECT)
			end		 
		
	end
end
