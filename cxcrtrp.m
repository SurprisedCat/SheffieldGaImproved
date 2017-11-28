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
    %下面这句明显是个错误，nargin是个函数，不能赋值。注释掉，不需要
    % BUG
    %if nargs > 2, nargin = 2; end

    [mN, nN] = size(Nind);
    [mF, Nvar] = size(FieldDR);
    
    %Nind必须是个标量，表示种群个数
    if (mN ~= 1 & nN ~= 1), error('Nind has to be a scalar'); end
    % FieldDR必须是个2行矩阵，第一行为下界，第二行为上界
    if mF ~= 2, error('FieldDR must be a matrix with 2 rows'); end
   
   %  Compute Matrix with Range of variables and Matrix with Lower value
   % 用来生成制定范围的随机数，使用matlab自带的repmat函数代替工具箱中的rep函数
   % repmat（arg1,arg2）函数：将矩阵arg1,扩展行arg2(1)次，列arg2(2)次
   Range = repmat((FieldDR(2,:)-FieldDR(1,:)),[Nind 1]);
   Lower = repmat(FieldDR(1,:), [Nind 1]);
   
   % Create initial population
   % Each row contains one individual, the values of each variable uniformly
   % distributed between lower and upper bound (given by FieldDR)
   Chrom = rand(Nind,Nvar) .* Range + Lower;


% End of function

   
   
   
   