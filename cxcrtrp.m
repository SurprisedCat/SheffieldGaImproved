% cxcrtrp.m        (CReaTe an initial (Real-value) Population)
%
% This function creates a population of given size of random real-values. 
%
% Syntax:       Chrom = crtrp(Nind,FieldDR);
%
% Input parameters:
%    Nind      - A scalar containing the number of individuals in the new 
%                population.
%
%    FieldDR   - A matrix of size 2 by number of variables describing the
%                boundaries of each variable. It has the following structure:
%                [lower_bound;   (vector with lower bound for each veriable)
%                 upper_bound]   (vector with upper bound for each veriable)
%                [lower_bound_var_1  lower_bound_var_2 ... lower_bound_var_Nvar;
%                 upper_bound_var_1  upper_bound_var_2 ... upper_bound_var_Nvar]
%                example - each individuals consists of 4 variables:
%                FieldDR = [-100 -50 -30 -20;   % lower bound
%                            100  50  30  20]   % upper bound
%              
% Output parameter:
%    Chrom     - A matrix containing the random valued individuals of the
%                new population of size Nind by number of variables.

% Author:     Hartmut Pohlheim
% History:    23.11.93     file created
%             25.02.94     clean up, check parameter consistency

function Chrom = cxcrtrp(Nind,FieldDR)

    nargs = nargin

    % Check parameter consistency
    if nargs < 2, error('parameter FieldDR missing'); end
    %������������Ǹ�����nargin�Ǹ����������ܸ�ֵ��ע�͵�������Ҫ
    % BUG
    %if nargs > 2, nargin = 2; end

    [mN, nN] = size(Nind);
    [mF, Nvar] = size(FieldDR);
    
    %Nind�����Ǹ���������ʾ��Ⱥ����
    if (mN ~= 1 & nN ~= 1), error('Nind has to be a scalar'); end
    % FieldDR�����Ǹ�2�о��󣬵�һ��Ϊ�½磬�ڶ���Ϊ�Ͻ�
    if mF ~= 2, error('FieldDR must be a matrix with 2 rows'); end
   
   %  Compute Matrix with Range of variables and Matrix with Lower value
   % ���������ƶ���Χ���������ʹ��matlab�Դ���repmat�������湤�����е�rep����
   % repmat��arg1,arg2��������������arg1,��չ��arg2(1)�Σ���arg2(2)��
   Range = repmat((FieldDR(2,:)-FieldDR(1,:)),[Nind 1]);
   Lower = repmat(FieldDR(1,:), [Nind 1]);
   
   % Create initial population
   % Each row contains one individual, the values of each variable uniformly
   % distributed between lower and upper bound (given by FieldDR)
   Chrom = rand(Nind,Nvar) .* Range + Lower;


% End of function

   
   
   
   