function delta = split_metric (A)
% function delta = split_metric (A)
%
% returns the split metric of the split A|B
%   where B is the complement of A
%
% A = one of the parts of the split (binary vector, size 1xm)
%   the other part is obtained by taking ...
%   ... the binary complement of the vector

delta = xor (A, A');

end