% crtbase.m - Create base vector 
%
% This function creates a vector containing the base of the loci
% in a chromosome.
%
% Syntax: BaseVec = crtbase(Lind, Base)
%
% Input Parameters:
%
%		Lind	- A scalar or vector containing the lengths
%			  of the alleles.  Sum(Lind) is the length of
%			  the corresponding chromosome.
%
%		Base	- A scalar or vector containing the base of
%			  the loci contained in the Alleles.
%
% Output Parameters:
%
%		BaseVec	- A vector whose elements correspond to the base
%			  of the loci of the associated chromosome structure.
%
%
% Author: Andrew Chipperfield
function BaseVec = cxcrtbase(Lind, Base)% Date: 19-Jan-94

[ml,LenL] = size(Lind);
if nargin <2 % 只有一个参数
    Base = 2 * ones(1,LenL);
end
[mb,LenB] = size(Base);

% check parameter consistency
if ml>1 || mb > 1 % 限定必须都是一维行向量
    error('Lind or Base is not a vector');
elseif (LenL > 1 && LenB > 1 && LenL ~= LenB) || (LenL == 1 && LenB >1)
    error('Vector dimension must agree');
elseif LenB == 1 && LenL >1
    Base = Base * ones(1,LenL);
end

BaseVec = [];
for i = 1:LenL
    BaseVec = [BaseVec, Base(i)*ones(Lind(i),1)'];
end