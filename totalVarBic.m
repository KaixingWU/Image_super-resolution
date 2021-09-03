function tv=totalVarBic(f,g)
    f=double(f);
    g=double(g);
    originalSize = size(f);
    
    tv = 0.0;
    for i=4:originalSize(1)-3
        for j=4:originalSize(2)-3
            tv = tv + abs(f(i,j) - g(i,j));
        end
    end
   
    tv=tv/(originalSize(1)-6)/(originalSize(2)-6);