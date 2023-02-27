--魂缚门
function c88880099.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--des
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(88880099,0))
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,88880099)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c88880099.detg)
	e4:SetOperation(c88880099.deop)
	c:RegisterEffect(e4)
	local e5 = e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6 = e4:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e6)
end
function c88880099.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,800,PLAYER_ALL,0)
end
function c88880099.deop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Destroy(eg,REASON_EFFECT)
	Duel.Damage(tp,800,REASON_EFFECT)
	Duel.Damage(1-tp,800,REASON_EFFECT)
end
