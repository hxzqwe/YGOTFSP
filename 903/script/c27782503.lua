--六武衆－イロウ
function c27782503.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27782503,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c27782503.descon)
	e1:SetTarget(c27782503.destg)
	e1:SetOperation(c27782503.desop)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c27782503.desreptg)
	e2:SetOperation(c27782503.desrepop)
	c:RegisterEffect(e2)
end
function c27782503.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3d) and not c:IsCode(27782503)
end
function c27782503.descon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==Duel.GetAttacker() and d and d:IsFacedown() and d:IsDefensePos()
		and Duel.IsExistingMatchingCard(c27782503.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c27782503.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackTarget():IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttackTarget(),1,0,0)
end
function c27782503.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
function c27782503.repfilter(c,e)
	return c:IsFaceup() and c:IsSetCard(0x3d)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c27782503.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c27782503.repfilter,tp,LOCATION_MZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c27782503.repfilter,tp,LOCATION_MZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c27782503.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
