--神事之兽葬
function c88880103.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END+TIMING_END_PHASE)
	e1:SetCountLimit(1,88880103+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c88880103.target)
	e1:SetOperation(c88880103.activate)
	c:RegisterEffect(e1)
end
function c88880103.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c88880103.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c88880103.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88880103.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c88880103.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,2,tp,0)
end
function c88880103.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_DRAW)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetOperation(c88880103.dactive)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		Duel.RegisterEffect(e1,tp)
	end
end

function c88880103.dactive(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(e:GetHandlerPlayer(),2,REASON_EFFECT)
end
