function tv=totalVar(f,g)
    f=double(f);
    g=double(g);
    originalSize = size(f);
    
    tv = 0.0;
    for i=1:originalSize(1)
        for j=1:originalSize(2)
            tv = tv + abs(f(i,j) - g(i,j));
        end
    end
   
    tv=tv/originalSize(1)/originalSize(2);