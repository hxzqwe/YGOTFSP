--仮面魔獣デス・ガーディウス
function c48948935.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c48948935.spcon)
	e1:SetOperation(c48948935.spop)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(48948935,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c48948935.eqcon)
	e2:SetTarget(c48948935.eqtg)
	e2:SetOperation(c48948935.eqop)
	c:RegisterEffect(e2)
end
function c48948935.spfilter(c,g,ft,tp)
	if c:IsControler(tp) and c:GetSequence()<5 then ft=ft+1 end
	return c:IsCode(13676474,86569121) and (c:IsControler(tp) or c:IsFaceup())
		and (ft>0 or g:IsExists(c48948935.mzfilter,1,c,tp))
end
function c48948935.mzfilter(c,tp)
	return c:IsControler(tp) and c:GetSequence()<5
end
function c48948935.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-2 and rg:GetCount()>1 and rg:IsExists(c48948935.spfilter,1,nil,rg,ft,tp)
end
function c48948935.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=rg:FilterSelect(tp,c48948935.spfilter,1,1,nil,rg,ft,tp)
	local tc=g1:GetFirst()
	if tc:IsControler(tp) and tc:GetSequence()<5 then ft=ft+1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	if ft>0 then
		local g2=rg:Select(tp,1,1,tc)
		g1:Merge(g2)
	else
		local g2=rg:FilterSelect(tp,c48948935.mzfilter,1,1,tc,tp)
		g1:Merge(g2)
	end
	Duel.Release(g1,REASON_COST)
end
function c48948935.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c48948935.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc:IsControler(1-tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK)
end
function c48948935.filter(c)
	return c:IsCode(22610082) and not c:IsForbidden()
end
function c48948935.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c48948935.filter,tp,LOCATION_DECK,0,1,1,nil)
		local eqc=g:GetFirst()
		if not eqc or not Duel.Equip(tp,eqc,tc) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c48948935.eqlimit)
		e1:SetLabelObject(tc)
		eqc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(eqc)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_SET_CONTROL)
		e2:SetValue(tp)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		eqc:RegisterEffect(e2)
	end
end
function c48948935.eqlimit(e,c)
	return e:GetLabelObject()==c
end
