--DT 混沌
function c88880029.initial_effect(c)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c88880029.synlimit)
	c:RegisterEffect(e6)
	--
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetCode(88880029)
	c:RegisterEffect(e7)

	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880029,0))
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c88880029.spcon)
	e3:SetTarget(c88880029.sptg)
	e3:SetOperation(c88880029.spop)
	c:RegisterEffect(e3)
end
function c88880029.synlimit(e,c)
	if not c then return false end
	return not aux.IsMaterialListSetCard(c,0x838)
end

function c88880029.spcon(e,tp,eg,ep,ev,re,r,rp)
	 return re and re:GetHandler():IsSetCard(0x839)
end
function c88880029.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,5)
end
function c88880029.spop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.DiscardDeck(p,5,REASON_EFFECT)
end
