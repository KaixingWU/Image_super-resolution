function [o,time]=bilinearInterpolation(f,resizeFactor,imageOutput)
    % Can take for granted that reizeFactor is of form 2
    originalSize = size(f);
    newSize = originalSize * resizeFactor;
    output1 = zeros(newSize(1),newSize(2),class(f));
    tic
    for i=newSize(1):-1:1
        for j=newSize(2):-1:1
            if j==1 && i~=1
                output1(i,j) = 2 * cast(output1(i,j+1),'uint32') - cast(output1(i,j+2),'uint32');
                continue;
            end
            
            if i==1
                output1(i,j) = 2 * cast(output1(i+1,j),'uint32') - cast(output1(i+2,j),'uint32');
                continue;
            end
            
            % output1(2x,2y) = f(x, y)
            if mod(i,2)==0 && mod(j,2)==0
                x=floor(i/2);
                y=floor(j/2);
                output1(i,j) = f(x,y);
                continue;
            end
            
            % output1(2x,2y+1) = (f(x,y) + f(x,y+1))/2
            if mod(i,2)==0 && mod(j,2)==1
                x=i/2;
                y1=(j+1)/2;
                y2=(j-1)/2;
                value = (cast(f(x,y1),'uint32') + cast(f(x,y2),'uint32'))/2;
                output1(i,j) = cast(value,'like',f(2));
                continue;
            end
            
            % output1(2x+1,2y) = (f(x,y) + f(x+1,y)) / 2
            if mod(i,2)==1 && mod(j,2)==0
                x1=(i+1)/2;
                x2=(i-1)/2;
                y=j/2;
                value = (cast(f(x1,y),'uint32') + cast(f(x2,y),'uint32'))/2;
                output1(i,j) = cast(value,'like',f(2));
                continue;
            end
            
            % output1(2x+1,2y+1) = (f(x,y) + f(x+1,y) + f(x,y+1) + f(x+1,y+1)) / 4
            if mod(i,2)==1 && mod(j,2)==1
                x1=(i+1)/2;
                x2=(i-1)/2;
                y1=(j+1)/2;
                y2=(j-1)/2;
                value = (cast(f(x1,y1),'uint32') + cast(f(x2,y1),'uint32') + cast(f(x1,y2),'uint32') + cast(f(x2,y2),'uint32'))/4;
                output1(i,j) = cast(value,'like',f(2));
                continue;
            end
        end
    end    
    time = toc;
    % output1=cast(output1,'like',f);
    imwrite(output1, imageOutput);
    o=output1;
end