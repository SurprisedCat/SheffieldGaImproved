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

%~��ʾ����������治���õ�
if nargs >= 1, [~, nN] = size(Nind) ; end
if nargs >= 2, [~, nL] = size(Lind) ; end
if nargs == 3, [~, nB] = size(Base) ; end

if nN == 2 %Nind��һ����������һλNind(1)��ʾ��Ⱥ�������ڶ�λNind(2)��ʾ���򳤶ȡ�
    if(nargs == 1)%����һ������
        Lind = Nind(2);
        Nind = Nind(1);
        BaseV = cxcrtbase(Lind);
    elseif (nargs == 2 && nL == 1)%Nind��һ������,����������ʱ�򣬵ڶ���������Ȼ�ǻ���λ�Ľ�����,������һ������
        BaseV = cxcrtbase(Nind(2),Lind);
        Lind = Nind(2);%Nind(2)��ʵ�ǻ���ĳ��ȣ�Lindԭ��ֵ�ǽ�����
        Nind = Nind(1);
    elseif (nargs == 2 && nL > 1)%Nind��һ������,����������ʱ�򣬵ڶ���������Ȼ�ǻ���λ�Ľ�����,��һ������
        %BUG ԭ���Ĵ���if Lind ~= length(Lind), error('Lind and Base disagree'); end
        %����������һ���жϣ���������ĳ��Ⱥͻ������ĳ����Ƿ�һ�£����ǳ���Ӧ����Nind��2��������Lind��Lind�������ֵ��BaseV
        if Nind(2) ~= length(Lind), error('Lind and Base disagree'); end 
        BaseV = Lind ; Lind = Nind(2) ; Nind = Nind(1) ; 
    end
elseif nN == 1  %Nind��һ����������ʾ��Ⱥ����
    if (nargs == 1)%����һ������
        error('Not enough input arguments.') ;
    elseif nargs == 2 %������������Ҫ�����ڶ�λ�Ǳ�����������
        if nL == 1 %�ڶ��������Ǳ�����˵���ǻ��򳤶�
            BaseV = cxcrtbase(Lind);
        else % �ڶ�����������������ʾ���ǻ�����
            BaseV = Lind;
            Lind = nL;%�������ĳ��ȱ�ʾ����ĳ���
        end
    elseif nargs == 3 % �ڶ�λ Lind ����������λ���������Ϣ
        if nB == 1
            BaseV=cxcrtbase(Lind,Base);%����λ��������ʾ������ͳһ�Ľ���base
        elseif nB ~= Lind
            error('Lind and Base disagree') ;%����λ���������������Ƿ�ƥ��
        else
            BaseV=Base;%��׼��ʽ����һλNind���ڶ�λLind������λBaseV
        end
    end 
end

% Create a structure of random chromosomes in row wise order, dimensions
% Nind by Lind. The base of each chromosomes loci is given by the value
% of the corresponding element of the row vector base.

%BaseV(ones(Nind,1),:)��ʾ������չ�ɾ����ظ���չNind��
%floor ����ȡ��
Chrom = floor(rand(Nind,Lind).*BaseV(ones(Nind,1),:));

        
        ;
        