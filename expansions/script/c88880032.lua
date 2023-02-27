--DT 灾祸
function c88880032.initial_effect(c)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetValue(c88880032.synlimit)
	c:RegisterEffect(e6)
	--
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetCode(88880032)
	c:RegisterEffect(e7)

	--destory
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880032,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c88880032.spcon)
	e3:SetTarget(c88880032.sptg)
	e3:SetOperation(c88880032.spop)
	c:RegisterEffect(e3)
end
function c88880032.synlimit(e,c)
	if not c then return false end
	return not aux.IsMaterialListSetCard(c,0x838)
end

function c88880032.spcon(e,tp,eg,ep,ev,re,r,rp)
	 return re and re:GetHandler():IsSetCard(0x839)
end
function c88880032.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,0,1-tp,1)
end
function c88880032.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(88880032,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
