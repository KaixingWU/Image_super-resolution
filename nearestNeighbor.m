function [o,time]=nearestNeighbor(f, resizeFactor, imageOutput)
    % Can take for granted that reizeFactor is of form 2^n
    originalSize = size(f);
    newSize = originalSize * resizeFactor;
    output1 = zeros(newSize(1),newSize(2),class(f));
    tic
    for i=1:newSize(1)
        for j=1:newSize(2)
            x=max(floor(i/2),1);
            y=max(floor(j/2),1);
            x=cast(x,'like',f(1));
            y=cast(y,'like',f(2));
            output1(i,j) = f(x,y);
        end
    end
    time = toc;
    imwrite(output1, imageOutput);
    o=output1;
end