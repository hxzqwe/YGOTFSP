--高速决斗技能-爷没洗卡
function c100730019.initial_effect(c)
	
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(aux.FALSE)
	c:RegisterEffect(e2)

	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100730019,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_SEARCH)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCountLimit(1,100730019+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c100730019.descon)
	e1:SetTarget(c100730019.rectg)
	e1:SetOperation(c100730019.recop)
	c:RegisterEffect(e1)
end
function c100730019.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SEARCH,nil,0,LOCATION_DECK,5)
end

function c100730019.srfilter(c)
	return c:IsAbleToHand()
end
function c100730019.recop(e,tp,eg,ep,ev,re,r,rp)

	Debug.Message("爷没洗卡！")

	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)

	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetOperation(c100730019.leaveop)
	Duel.RegisterEffect(e3,tp)

	local player = e:GetHandlerPlayer()

	local g=Duel.GetFieldGroup(player,LOCATION_HAND,0)
	if g:GetCount()~=0 then  Duel.SendtoDeck(g,nil,2,REASON_EFFECT) end
	
	Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(player,c100730019.srfilter,player,LOCATION_DECK,0,5,5,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c100730019.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100730019.leaveop(e,tp,eg,ep,ev,re,r,rp)
	local WIN_REASON_RELAY_SOUL=0x1a
	Duel.Win(1-tp,WIN_REASON_RELAY_SOUL)
end
