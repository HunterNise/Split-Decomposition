function a = alfa (D, A)
% function a = alfa (D, A)
%
% returns the isolation index of the split A|B
%   where B is the complement of A
%
% D = distance matrix (symmetric square matrix, size nxn)
% A = one of the parts of the split (binary vector, size 1xm)
%   the other part is obtained by taking ...
%   ... the binary complement of the vector

% calculate the indices of the elements in A ...
iA = find  (A);
% ... and in B (complement of A)
iB = find (~A);

% initialize with the maximum distance
a = max (D, [], "all");

% check only unordered couples
TA = table2array (combinations (iA, iA));
TB = table2array (combinations (iB, iB));

for rA = TA'
    t = rA (1);
    u = rA (2);

    for rB = TB'
        v = rB (1);
        w = rB (2);
        
        b = beta (D, t,u,v,w);

        if b == 0               % no need to check further
            a = 0; return
        else 
            a = min ([a, b]);
        end
    end
end

end