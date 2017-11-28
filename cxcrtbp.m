% cxcrtbp.m - Create an initial population
%
% This function creates a binary population of given size and structure.
%
% Syntax: [Chrom Lind BaseV] = crtbp(Nind, Lind, Base)
%
% Input Parameters:
%
%		Nind	- Either a scalar containing the number of individuals
%			  in the new population or a row vector of length two
%			  containing the number of individuals and their length.
%
%		Lind	- A scalar containing the length of the individual
%			  chromosomes.
%
%		Base	- A scalar containing the base of the chromosome 
%			  elements or a row vector containing the base(s) 
%			  of the loci of the chromosomes.
%
% Output Parameters:
%
%		Chrom	- A matrix containing the random valued chromosomes 
%			  row wise.
%
%		Lind	- A scalar containing the length of the chromosome.
%
%		BaseV	- A row vector containing the base of the 
%			  chromosome loci.

% Author: Andrew Chipperfield
% Date:	19-Jan-94
function [Chrom, Lind, BaseV] = cxcrtbp(Nind, Lind, Base)
nargs = nargin;

%~表示这个变量后面不会用到
if nargs >= 1, [~, nN] = size(Nind) ; end
if nargs >= 2, [~, nL] = size(Lind) ; end
if nargs == 3, [~, nB] = size(Base) ; end

if nN == 2 %Nind是一个向量，第一位Nind(1)表示种群数量，第二位Nind(2)表示基因长度。
    if(nargs == 1)%仅有一个参数
        Lind = Nind(2);
        Nind = Nind(1);
        BaseV = cxcrtbase(Lind);
    elseif (nargs == 2 && nL == 1)%Nind是一个向量,两个参数的时候，第二个参数必然是基因位的进制数,并且是一个标量
        BaseV = cxcrtbase(Nind(2),Lind);
        Lind = Nind(2);%Nind(2)其实是基因的长度，Lind原来值是进制数
        Nind = Nind(1);
    elseif (nargs == 2 && nL > 1)%Nind是一个向量,两个参数的时候，第二个参数必然是基因位的进制数,是一个向量
        %BUG 原来的代码if Lind ~= length(Lind), error('Lind and Base disagree'); end
        %这里是想做一个判断，看看基因的长度和基向量的长度是否一致，但是长度应该是Nind（2）而不是Lind，Lind在这个分值里BaseV
        if Nind(2) ~= length(Lind), error('Lind and Base disagree'); end 
        BaseV = Lind ; Lind = Nind(2) ; Nind = Nind(1) ; 
    end
elseif nN == 1  %Nind是一个标量，表示种群数量
    if (nargs == 1)%仅有一个参数
        error('Not enough input arguments.') ;
    elseif nargs == 2 %两个参数，需要看看第二位是标量还是向量
        if nL == 1 %第二个参数是标量。说明是基因长度
            BaseV = cxcrtbase(Lind);
        else % 第二个参数是向量，表示他是基向量
            BaseV = Lind;
            Lind = nL;%基向量的长度表示基因的长度
        end
    elseif nargs == 3 % 第二位 Lind 标量，第三位基因进制信息
        if nB == 1
            BaseV=cxcrtbase(Lind,Base);%第三位标量，表示基因有统一的进制base
        elseif nB ~= Lind
            error('Lind and Base disagree') ;%第三位向量，看看长度是否匹配
        else
            BaseV=Base;%标准形式，第一位Nind，第二位Lind，第三位BaseV
        end
    end 
end

% Create a structure of random chromosomes in row wise order, dimensions
% Nind by Lind. The base of each chromosomes loci is given by the value
% of the corresponding element of the row vector base.

%BaseV(ones(Nind,1),:)表示向量扩展成矩阵，重复扩展Nind行
%floor 向下取整
Chrom = floor(rand(Nind,Lind).*BaseV(ones(Nind,1),:));

        
        ;
        