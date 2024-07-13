function [D0, dS, adS] = split_decomp (D)
% function [D0, dS, adS] = split_decomp (D)
%
% compute the split decomposition of D
%
% D = distance matrix (symmetric square matrix, size nxn)
%
% D0 = split-prime residue (symmetric square matrix, size nxn)
% dS = d-splits (binary matrix, rows = splits, size Nxn)
% adS = isolation indices (vector, size Nx1)

n = size (D);

S{2} = [1, 0];          % start from 1|2
a{2} = alfa (D, S{2});

for k = 3 : n

    % build the new (partial) splits

    % duplicate the previous splits A|B
    S{k} = repmat (S{k-1}, 2, 1);
    sz = size (S{k});

    % for every split add the new element ...
    % ... to the left (A,k|B) or the right (A|B,k)
    c = [ones( sz(1)/2, 1); zeros( sz(1)/2, 1)];
    S{k} = [S{k}, c];

    % add the trivial split Y|k
    r = [ones( 1, sz(2)), 0];
    S{k} = [S{k}; r];

    % number of splits
    N = size (S{k}, 1);


    % compute the isolation index of every split

    % unoptimized
    % a{k} = zeros (N, 1);              % preallocation
    % for i = 1 : N
    %   a{k}(i) = alfa ( D, S{k}(i,:) );
    % end

    % optimized
    a{k} = repmat (a{k-1}, 2, 1);
        % initialize with previous indices
    half = (N-1) / 2;
    for i = 1 : half
        a{k}(i) = alfa_sx ( D, S{k}(i,:), a{k}(i) );  % A,k|B
    end
    for i = half+1 : N-1
        a{k}(i) = alfa_dx ( D, S{k}(i,:), a{k}(i) );  % A|B,k
    end
    a{k}(N) = alfa ( D, S{k}(N,:) );                  % Y|k


    % remove non d-splits

    idx = (a{k} == 0);
    S{k} (idx, :) = [];
    a{k} (idx, :) = [];
end

dS  = S{n};     % (total) d-splits ...
adS = a{n};     % ... and their indices


D0 = D;
for i = 1 : size (dS, 1)
    D0 = D0 - adS (i) * split_metric ( dS(i,:) );
end

end