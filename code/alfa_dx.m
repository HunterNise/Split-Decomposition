function a = alfa_dx (D, Ak, init)

iAk = find  (Ak);
iB  = find (~Ak);

a = init;
TAk = table2array (combinations (iAk, iAk));
k = size (Ak, 2);

for rAk = TAk'
    t = rAk (1);
    u = rAk (2);

    for v = iB
        b = beta (D, t,u,v,k);

        if b == 0
            a = 0; return
        else
            a = min ([a, b]);
        end
    end
end

end