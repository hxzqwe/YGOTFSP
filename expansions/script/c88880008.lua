--决斗倒计时
function c88880008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c88880008.target1)
	e1:SetOperation(c88880008.operation)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880008,0))
	e2:SetRange(LOCATION_SZONE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c88880008.setcon)
	e2:SetTarget(c88880008.settg)
	e2:SetOperation(c88880008.operation)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	--cannot activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(1,0)
	e3:SetValue(c88880008.actlimit)
	c:RegisterEffect(e3)
	--Damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetDescription(aux.Stringid(88880008,1))
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetCondition(c88880008.dgcon)
	e4:SetCost(c88880008.dgcost)
	e4:SetOperation(c88880008.dgop)
	c:RegisterEffect(e4)
end
function c88880008.actlimit(e,te,tp)
	return te:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c88880008.afilter(c)
	return (not c:IsType(TYPE_MONSTER)) and (not c:IsType(TYPE_FIELD))
end
function c88880008.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase() == PHASE_END and Duel.IsExistingMatchingCard(c88880008.afilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.SelectYesNo(tp,aux.Stringid(88880008,1)) then
		e:SetLabel(1)
		e:GetHandler():RegisterFlagEffect(88880008,RESET_PHASE+PHASE_END,0,1)
	else
		e:SetCategory(0)
		e:SetLabel(0)
	end
end
function c88880008.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c88880008.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc = g:GetFirst()
		Duel.SSet(tp,tc)
		e:GetHandler():SetCardTarget(tc)
	end
end
function c88880008.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(88880008)==0 and Duel.IsExistingMatchingCard(c88880008.afilter,tp,LOCATION_DECK,0,1,nil) end
	e:GetHandler():RegisterFlagEffect(c88880008,RESET_PHASE+PHASE_END,0,1)
end
function c88880008.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c88880008.dgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g = e:GetHandler():GetCardTarget()
	g:AddCard(e:GetHandler())
	e:SetLabel(g:GetCount())
	Duel.SendtoGrave(g,REASON_COST)
end
function c88880008.dgop(e,tp,eg,ep,ev,re,r,rp)  
	local dam = 0
	if e:GetLabel() == 2 then dam = 500 end 
	if e:GetLabel() == 3 then dam = 1500 end 
	if e:GetLabel() == 4 then dam = 3000 end 
	if e:GetLabel() == 5 then dam = 6000 end 
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
function c88880008.dgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCardTarget():GetCount() > 0
end
