--雾之王城
function c88880006.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1) 
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880006,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c88880006.condition)
	e2:SetTarget(c88880006.target)
	e2:SetOperation(c88880006.activate)
	e2:SetLabel(100000)
	c:RegisterEffect(e2)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(88880006,1))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_FZONE)
	e5:SetLabelObject(e2)
	e5:SetCondition(c88880006.spcon)
	e5:SetCost(c88880006.spcost)
	e5:SetTarget(c88880006.sptg)
	e5:SetOperation(c88880006.spop)
	c:RegisterEffect(e5)

end
function c88880006.cfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsType(TYPE_MONSTER)
		and c:GetPreviousControler()==tp and c:GetControler()==tp
		and c:IsPreviousLocation(LOCATION_MZONE)
end
function c88880006.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:Filter(c88880006.cfilter,nil,e:GetHandlerPlayer()):GetCount()==1
end
function c88880006.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local bc=eg:Filter(c88880006.cfilter,nil,e:GetHandlerPlayer()):GetFirst()
	if chk==0 then
	return true end
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,bc,1,tp,LOCATION_GRAVE)
end
function c88880006.disop(e)
	return bit.lshift(0x1,e:GetLabel())
end

function c88880006.activate(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetFirstTarget()
	-- 0 1 2 3 4
	local seq = bc:GetPreviousSequence()

	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetRange(LOCATION_FZONE)
	e1:SetOperation(c88880006.disop)
	e1:SetLabel(seq)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e:GetHandler():RegisterEffect(e1)

	if seq == 0 and math.modf(e:GetLabel()/10000) % 10 == 0 then e:SetLabel(e:GetLabel()+10000) end
	if seq == 1 and math.modf(e:GetLabel()/1000) % 10 == 0 then e:SetLabel(e:GetLabel()+1000) end
	if seq == 2 and math.modf(e:GetLabel()/100) % 10 == 0 then e:SetLabel(e:GetLabel()+100) end
	if seq == 3 and math.modf(e:GetLabel()/10) % 10 == 0 then e:SetLabel(e:GetLabel()+10) end
	if seq == 4 and e:GetLabel()% 10 == 0 then e:SetLabel(e:GetLabel()+1) end   

	if not bc:IsRelateToEffect(e) then return end

	
	-- 0 1 2 3 4
	if seq>4 then return end

	local count = Duel.GetLocationCount(tp,LOCATION_MZONE)  
	if count <= 0 then return end
	if count == 1 and Duel.CheckLocation(tp,LOCATION_MZONE,seq) then return end

	Duel.SpecialSummon(bc,0,tp,tp,false,false,POS_FACEUP)

	if bc:GetSequence() == seq then 
		for nseq=0,4,1 do
			if Duel.CheckLocation(tp,LOCATION_MZONE,nseq) and nseq ~= seq then
				Duel.MoveSequence(bc,nseq)
				return
			end
		end
	end

end
function c88880006.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel() == 111111 and Duel.GetMatchingGroup(c88880006.filter,tp,LOCATION_GRAVE,0,nil):GetCount() >= 4
end
function c88880006.cfilter2(c)
	return c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c88880006.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if chk==0 then return hg:GetCount()>0 and hg:FilterCount(c88880006.cfilter2,nil)==hg:GetCount() and Duel.GetCurrentPhase()~=PHASE_MAIN2 end

	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)

	hg:AddCard(e:GetHandler())
	Duel.SendtoGrave(hg,REASON_COST)
end
function c88880006.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
	return true end
end
function c88880006.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c88880006.spop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c88880006.filter,tp,LOCATION_GRAVE,0,nil)
	if tg:GetCount()>=4 then
		Duel.BreakEffect()   
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sel=tg:Select(tp,4,4,nil)
		Duel.SendtoHand(sel,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sel)
	end
end
