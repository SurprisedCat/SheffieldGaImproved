% ranking.m      (RANK-based fitness assignment)
%
% This function performs ranking of individuals.
%
% Syntax:  FitnV = ranking(ObjV, RFun, SUBPOP)
%
% This function ranks individuals represented by their associated
% cost, to be *minimized*, and returns a column vector FitnV
% containing the corresponding individual fitnesses. For multiple
% subpopulations the ranking is performed separately for each
% subpopulation.
%
% Input parameters:
%    ObjV      - Column vector containing the objective values of the
%                individuals in the current population (cost values).
%    RFun      - (optional) If RFun is a scalar in [1, 2] linear ranking is
%                assumed and the scalar indicates the selective pressure.
%                If RFun is a 2 element vector:
%                RFun(1): SP - scalar indicating the selective pressure
%                RFun(2): RM - ranking method
%                         RM = 0: linear ranking
%                         RM = 1: non-linear ranking
%                If RFun is a vector with length(Rfun) > 2 it contains
%                the fitness to be assigned to each rank. It should have
%                the same length as ObjV. Usually RFun is monotonously
%                increasing.
%                If RFun is omitted or NaN, linear ranking
%                and a selective pressure of 2 are assumed.
%    SUBPOP    - (optional) Number of subpopulations
%                if omitted or NaN, 1 subpopulation is assumed
%
% Output parameters:
%    FitnV     - Column vector containing the fitness values of the
%                individuals in the current population.
%                

% Author:     Hartmut Pohlheim (Carlos Fonseca)
% History:    01.03.94     non-linear ranking
%             10.03.94     multiple populations

function FitnV = cxranking(ObjV, RFun, SUBPOP)

    %Identify the vector size (Nind)
    [Nind,dimension] = size(ObjV);

    %第二个参数的处理
    if nargin < 2, RFun = [] ;end %仅有一个参数，后面会有默认赋值
    if nargin > 1 % 不合理RFun的处理
        if isnan(RFun), RFun = [];end
    end
    % numel函数返回的是矩阵中元素的个数,增强性能
    if numel(RFun) == 2 % RFun 为1行2列的向量
        if RFun(2) == 1, NonLin = 1;
        elseif RFun(2) == 0, NonLin = 0;
        else error('Parameter for ranking method must be 0 or 1');
        end
    elseif numel(RFun) >2, % RFun是一个列向量，列向量和ObjV对应 
        if numel(RFun) ~= Nind, error('ObjV and RFun disagree'); end
    end

    %第三个参数分组的处理
    if nargin < 3,  SUBPOP = 1; end
    if nargin > 2,
      if isempty(SUBPOP), SUBPOP = 1;
      elseif isnan(SUBPOP), SUBPOP = 1;
      elseif length(SUBPOP) ~= 1, error('SUBPOP must be a scalar'); 
      end
    end    
    %分组必须能够整除总数
    if (Nind/SUBPOP) ~= fix(Nind/SUBPOP), error('ObjV and SUBPOP disagree'); end
    Nind = Nind/SUBPOP;  % Compute 

    % Check ranking function and use default values if necessary
    if isempty(RFun),%为空的时候，采用默认值
        % 默认值：selective pressure： 2，线性
        RFun = 2* [0:Nind-1]'/(Nind-1);
    elseif 

