
%%%%%%%%%%%%%%%%%%
load FullI
SimpleCalcExpectedUtility(FullI)

FullINew = FullI;
FullINew.RandomFactors = ObserveEvidence(FullI.RandomFactors, [3,2], 1);
SimpleCalcExpectedUtility(FullINew)

%%%%%%%%%%%%  questions 7,8,9
clear
load TestI0;
[meu_base optdr] = OptimizeWithJointUtility(TestI0)
%meu_base = -350.43
%%% THIS IS CONFIRMED CORRECT
%%%--> (I got mv_0 = -0.96993)

TestI0New = TestI0;
TestI0New.DecisionFactors.var = [9 11];
TestI0New.DecisionFactors.card = [2 2];
TestI0New.DecisionFactors.val = [0 0 0 0];

% test 1
TestI0New.RandomFactors(10).val = [.750 .250 .001 .999 ];
[meu_t1 optdr] = OptimizeWithJointUtility(TestI0New)
%meu_t1 = 155.17
dollars_t1 =  (e^((meu_t1-meu_base)/100)) - 1
%dollars_t1 = 155.97

%%% test 2
TestI0New.RandomFactors(10).val = [.999 .001 .250 .750 ];
[meu_t2 optdr] = OptimizeWithJointUtility(TestI0New)
%meu_t2 = -216.46
dollars_t2 =  (e^((meu_t2-meu_base)/100)) - 1
%dollars_t2 =  2.8180


%%% test 3
TestI0New.RandomFactors(10).val = [.999 .001 .001 .999 ];
[meu_t3 optdr] = OptimizeWithJointUtility(TestI0New)
%meu_t3 =  323.75
dollars_t3 =  (e^((meu_t3-meu_base)/100)) - 1
%dollars_t3 =  846.15



xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
%I need some help for this question; clearly I'm doing something wrong. The following are my steps:

%<1> Redefine the decision factor –

D1 = struct('var', [9,11], 'card', [2,2], 'val', [0,0,0,0]);

TestI0.DecisionFactors = D1;

%<2> Redefine the test factor –

T1 = struct('var', [11,1], 'card', [2,2], 'val', [0.750000,0.250000,0.001000,0.999000]);

TestI0.RandomFactors(10) = T1;

%<3> Compute optimal MEU

[meu_1, optdr] = OptimizeLinearExpectations(TestI0);

%<4> Compute money value of MEU

mv_1 = exp(meu_1 / 100) - 1;

%<5> Compute VPI as (mv_1 - mv_0) where mv_0 is the money value of optimal baseline MEU. (I got mv_0 = -0.96993)

