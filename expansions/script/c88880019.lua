--怪物猫
function c88880019.initial_effect(c)
	--destory
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c88880019.atkcon)
	e2:SetOperation(c88880019.atkop)
	c:RegisterEffect(e2)

	--grave get
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88880019,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c88880019.sumtg)
	e1:SetOperation(c88880019.sumop)
	c:RegisterEffect(e1)
end

function c88880019.sumfilter(c,e,tp)
	return (c:IsCode(88880011) or c:IsCode(88880013))  and c:IsAbleToHand()
end
function c88880019.sumtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c88880019.sumfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c88880019.sumfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c88880019.sumfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c88880019.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end

function c88880019.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and not c:IsType(TYPE_XYZ)
end
function c88880019.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsCode(88880013)
end
function c88880019.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local sg = Duel.GetMatchingGroup(c88880019.filter,tp,0,LOCATION_MZONE,nil)
		local count = Duel.Destroy(sg,REASON_EFFECT)
		Duel.Damage(1-tp,count*800,REASON_EFFECT)
	end
end