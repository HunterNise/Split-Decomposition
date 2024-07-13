function b = beta (D, t,u,v,w)
% function b = beta (D, t,u,v,w)
%
% returns the beta index of the quartet t,u|v,w
%
% D = distance matrix (symmetric square matrix, size nxn)
% t,u,v,w = taxa (integer numbers between 1 and n)

s1 = D(t,u) + D(v,w);
s2 = D(t,v) + D(u,w);
s3 = D(t,w) + D(u,v);
m = max ([s1, s2, s3]);

if m == s1      % avoid unnecessary numerical cancellation
    b = 0;
else
    b = (m - s1) / 2;
end

end