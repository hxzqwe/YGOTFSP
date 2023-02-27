--结痂的伤疤骑士
function c88880034.initial_effect(c)

	c:SetUniqueOnField(1,0,88880034)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c88880034.sdcon)
	c:RegisterEffect(e2)

	--must attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_MUST_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e5:SetValue(c88880034.atklimit)
	c:RegisterEffect(e5)

	--control
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(88880034,0))
	e6:SetCategory(CATEGORY_CONTROL)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)	
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCountLimit(1)
	e6:SetCondition(c88880034.ctcon)
	e6:SetTarget(c88880034.cttg)
	e6:SetOperation(c88880034.ctop)
	c:RegisterEffect(e6)


end
function c88880034.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0 or e:GetHandler():GetAttackedCount()>0
end
function c88880034.ctfilter(c,e)
	return c:IsFaceup() and e:GetHandler():GetBattledGroup():IsContains(c) and c:IsLocation(LOCATION_MZONE) and c:IsControler(1-e:GetHandlerPlayer())
		and c:IsCanBeEffectTarget(e)
end

function c88880034.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc==0 then return end 
	if chk==0 then return Duel.IsExistingMatchingCard(c88880034.ctfilter,tp,0,LOCATION_MZONE,1,nil,e) end
	
	local bc = Duel.SelectMatchingCard(tp,c88880034.ctfilter,tp,0,LOCATION_MZONE,1,1,nil,e):GetFirst()
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,bc,1,1-tp,LOCATION_MZONE)
end

function c88880034.ctop(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetFirstTarget()
	if c88880034.ctfilter(bc,e) then 
		Duel.GetControl(bc,tp)
	end
end

function c88880034.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE)
end
function c88880034.atklimit(e,c)
	return c==e:GetHandler()
end