function a = alfa_sx (D, Ak, init)

iAk = find  (Ak);
iB  = find (~Ak);

a = init;
TB = table2array (combinations (iB, iB));
k = size (Ak, 2);

for t = iAk
    for rB = TB'
        v = rB (1);
        w = rB (2);

        b = beta (D, t,k,v,w);

        if b == 0
            a = 0; return
        else
            a = min ([a, b]);
        end
    end
end

end