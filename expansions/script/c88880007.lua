--婆娑罗
function c88880007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)

	--distory
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(88880007,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c88880007.condition)
	e4:SetCost(c88880007.cost)
	e4:SetTarget(c88880007.target1)
	e4:SetOperation(c88880007.operation)
	c:RegisterEffect(e4)
end

function c88880007.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c88880007.afilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c88880007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	
	local rg=Duel.SelectReleaseGroup(tp,c88880007.afilter,1,1,nil,tp)
	e:SetLabel(rg:GetFirst():GetLevel())
	Duel.Release(rg,REASON_COST)
	
end

function c88880007.afilter(c,tp)   
	return c:IsReleasable() and Duel.IsExistingMatchingCard(c88880007.bfilter,tp,0,LOCATION_MZONE,1,nil,c:GetLevel()) and not c:IsType(TYPE_TOKEN) 
		and not c:IsType(TYPE_XYZ)
end

function c88880007.bfilter(c,l)
	return c:GetLevel() > l and c:IsFaceup() and not c:IsType(TYPE_XYZ)
end

function c88880007.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,1-tp,LOCATION_MZONE)
end
function c88880007.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c88880007.bfilter,tp,0,LOCATION_MZONE,1,1,nil,e:GetLabel())
	if g:GetCount()>0 then
		local tc = g:GetFirst()
		Duel.Destroy(tc,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end