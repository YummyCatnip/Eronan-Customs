--Contaminet Worm
function c918902322.initial_effect(c)
	--Change Name
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(57844634,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c918902322.sptg)
	e1:SetOperation(c918902322.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--Add to Hand
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(87475570,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c918902322.thcost)
	e4:SetTarget(c918902322.thtg)
	e4:SetOperation(c918902322.thop)
	c:RegisterEffect(e4)
end
function c918902322.spfilter(c,e,tp)
	return c:IsCode(918902322) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK,1-tp)
end
function c918902322.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c918902322.spfilter,e:GetHandler():GetControler(),LOCATION_DECK,0,1,nil,e,tp) end
end
function c918902322.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetMatchingGroup(c918902322.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	Duel.BreakEffect()
	Duel.SpecialSummonStep(g:GetFirst(),0,tp,1-tp,false,false,POS_FACEUP)
	if ft>1 and g:GetCount()>1 and Duel.SelectYesNo(tp,aux.Stringid(525110,1)) then
		Duel.SpecialSummonStep(g:GetNext(),0,tp,1-tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c918902322.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c918902322.thfilter(c)
	return c:IsCode(912389041) and c:IsAbleToHand()
end
function c918902322.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c918902322.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c918902322.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c918902322.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end