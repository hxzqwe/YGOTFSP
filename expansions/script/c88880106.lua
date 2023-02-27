--超巨大飞行艇 巨型兴登堡
function c88880106.initial_effect(c)
	  --special summon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SPSUMMON_PROC)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(LOCATION_HAND)
	e4:SetCondition(c88880106.spcon)
	e4:SetOperation(c88880106.spop)
	c:RegisterEffect(e4)  
  
	--change pos
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(88880106,1))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c88880106.con)
	e3:SetTarget(c88880106.target)
	e3:SetOperation(c88880106.operation)
	c:RegisterEffect(e3)
	local e5=e3:Clone()
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e5)

	--pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88880106,1))
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c88880106.poscon)
	e2:SetTarget(c88880106.postg)
	e2:SetOperation(c88880106.posop)
	c:RegisterEffect(e2)

end

function c88880106.confilter(c)
	return c:IsFaceup() and c:IsLevelAbove(10)
end
function c88880106.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c88880106.confilter,1,nil)
end
function c88880106.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(9) 
end
function c88880106.target(e,tp,eg,ep,ev,re,r,rp,chk)

	local g=Duel.GetMatchingGroup(c88880106.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c88880106.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end



function c88880106.cfilter(c,tp,ec)
	local np=c:GetPosition()
	local pp=c:GetPreviousPosition()
	return  c~=ec and np==POS_FACEUP_DEFENSE and pp==POS_FACEUP_ATTACK
end
function c88880106.poscon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c88880106.cfilter,1,nil,tp,e:GetHandler())
end

function c88880106.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c88880106.cfilter,1,nil,tp,e:GetHandler()) end
	local g=eg:Filter(c88880106.cfilter,nil,tp,e:GetHandler())
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,g,g:GetCount(),0,0)
end
function c88880106.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg = Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=sg:GetFirst()
	while tc do
		if tc:IsRelateToEffect(e) and tc:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			tc=sg:GetNext()
		end
	end
end


function c88880106.mzfilter(c,tp)
	return c:IsControler(tp) and c:IsType(TYPE_TOKEN)
end
function c88880106.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local rg=Duel.GetReleaseGroup(tp):Filter(c88880106.mzfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	return ft>-2 and rg:GetCount()>1 and (ft>0 or rg:IsExists(c88880106.mzfilter,ct,nil,tp))
end
function c88880106.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local rg=Duel.GetReleaseGroup(tp):Filter(c88880106.mzfilter,nil,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=nil
	if ft>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:Select(tp,2,2,nil)
	elseif ft==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c88880106.mzfilter,1,1,nil,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local g2=rg:Select(tp,1,1,g:GetFirst())
		g:Merge(g2)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		g=rg:FilterSelect(tp,c88880106.mzfilter,2,2,nil,tp)
	end
	Duel.Release(g,REASON_COST)
end