--风化战士
function c88880090.initial_effect(c)

	--aux.AddCodeList(c,88880091)
	--search
	--local e1=Effect.CreateEffect(c)
   -- e1:SetDescription(aux.Stringid(88880090,0))
	--e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	--e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	--e1:SetProperty(EFFECT_FLAG_DELAY)
   -- e1:SetCode(EVENT_BATTLE_DESTROYED)
	--e1:SetCountLimit(1,88880090)
	--e1:SetTarget(c88880090.thtg)
   -- e1:SetOperation(c88880090.thop)
   -- c:RegisterEffect(e1)
   -- local e1x=e1:Clone()
   -- e1x:SetCode(EVENT_TO_GRAVE)
   -- e1x:SetCondition(c88880090.thcon)
   -- c:RegisterEffect(e1x)

	--reduce atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880090,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c88880090.atkcon)
	e2:SetOperation(c88880090.atkop)
	c:RegisterEffect(e2)
end
function c88880090.thfilter(c)
	if not c:IsAbleToHand() or c:IsCode(88880090) then return false end
	return c:IsCode(88880091) or aux.IsCodeListed(c,88880091)
end
function c88880090.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c88880090.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88880090.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88880090.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c88880090.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c88880090.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c88880090.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
