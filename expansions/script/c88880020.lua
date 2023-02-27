--百眼龙[暗同调]
function c88880020.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c88880020.sprcon)
	e2:SetOperation(c88880020.sprop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880020,2))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c88880020.srcon)
	e3:SetTarget(c88880020.srtg)
	e3:SetOperation(c88880020.srop)
	c:RegisterEffect(e3)

	--copy in use
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(88880020,0))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c88880020.copycon)
	e5:SetTarget(c88880020.copytg)
	e5:SetOperation(c88880020.copyop)
	local g = Group.CreateGroup()
	g:KeepAlive()
	e5:SetLabelObject(g) 
	c:RegisterEffect(e5)
	--indes
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetCondition(c88880020.indcon)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e7)
end

function c88880020.indfilter(c)
	return c:IsCode(51566770)
end
function c88880020.indcon(e)
	return Duel.IsExistingMatchingCard(c88880020.indfilter,e:GetOwnerPlayer(),LOCATION_GRAVE,0,1,nil) and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0 and not e:GetHandler():IsDisabled()
end
function c88880020.filter0(c)
	return c:IsSetCard(0xb)
end
function c88880020.filter2(c,e)
	return ( c:IsCode(72896270) or c:IsCode(56209279) or c:IsCode(49080532) or c:IsCode(13582837) or c:IsCode(86197239) )
		and e:GetLabelObject():FilterCount(c88880020.filter3,nil,c) == 0
		
end
function c88880020.copycon(e,tp,eg,ep,ev,re,r,rp)
	return  Duel.IsExistingMatchingCard(c88880020.filter0,tp,LOCATION_GRAVE,0,1,nil)
end
function c88880020.copytg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g = Duel.GetMatchingGroup(c88880020.filter1,tp,LOCATION_GRAVE,0,nil)
	local tc=g:GetFirst()
	while tc do
		e:GetHandler():CopyEffect(tc:GetOriginalCode(), RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc=g:GetNext()
	end
end

function c88880020.filter3(ca,cb)
	return ca:GetCode() == cb:GetCode()
end
function c88880020.copyop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c88880020.filter2,tp,LOCATION_GRAVE,0,1,nil,e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	local g = Duel.SelectMatchingCard(tp,c88880020.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if  c:IsFaceup() then
		local code=tc:GetOriginalCode()
		local cg = e:GetLabelObject()
		cg:AddCard(tc)
		e:SetLabelObject(cg)
		c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
end
function c88880020.filter1(c)
	return c:IsCode(98954375) or c:IsCode(18724123) or c:IsCode(07264861) or c:IsCode(25171661)
end



function c88880020.tgrfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c88880020.tgrfilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsSetCard(0x838) 
end
function c88880020.tgrfilter2(c)
	return not c:IsType(TYPE_TUNER) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_XYZ)
end
function c88880020.mnfilter(c,g)
	return g:IsExists(c88880020.mnfilter2,1,c,c)
end
function c88880020.mnfilter2(c,mc)
	return c:GetLevel()-mc:GetLevel()==8
end
function c88880020.fselect(g,tp,sc)
	return g:GetCount()==2
		and g:IsExists(c88880020.tgrfilter1,1,nil) and g:IsExists(c88880020.tgrfilter2,1,nil)
		and g:IsExists(c88880020.mnfilter,1,nil,g)
		and Duel.GetLocationCountFromEx(tp,tp,g,sc)>0
end
function c88880020.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c88880020.tgrfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c88880020.fselect,2,2,tp,c)
end
function c88880020.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c88880020.tgrfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c88880020.fselect,false,2,2,tp,c)
	Duel.SendtoGrave(tg,REASON_COST)
end
function c88880020.srcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY)
end
function c88880020.srfilter(c)
	return c:IsAbleToHand()
end
function c88880020.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88880020.srfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88880020.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c88880020.srfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end