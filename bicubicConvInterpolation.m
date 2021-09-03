function [o,time]=bicubicConvInterpolation(g,resizeFactor,imageOutput)
% Can take for granted that reizeFactor is of form 2
    f=double(g);
    originalSize = size(f);
    newSize = originalSize * resizeFactor;
    output = zeros(newSize(1),newSize(2),class(f));
    tic
     for i=1:newSize(1)
        for j=1:newSize(2)
%             p=[f((i+1)/2,(j+1)/2) f((i+1)/2,(j+3)/2) f((i+1)/2,(j+5)/2) f((i+1)/2,(j+7)/2);
%                f((i+3)/2,(j+1)/2) f((i+3)/2,(j+3)/2) f((i+3)/2,(j+5)/2) f((i+3)/2,(j+7)/2);
%                f((i+5)/2,(j+1)/2) f((i+5)/2,(j+3)/2) f((i+5)/2,(j+5)/2) f((i+5)/2,(j+7)/2);
%                f((i+7)/2,(j+1)/2) f((i+7)/2,(j+3)/2) f((i+7)/2,(j+5)/2) f((i+7)/2,(j+7)/2)];
%            
            if i==1 || j==1 || i==2 || j==2 || i==newSize(1) || j==newSize(2) || i==newSize(1)-1 || j==newSize(2)-1 || i==3 || j==3  || j==newSize(2)-2 || i==newSize(1)-2
                output(i,j) = 255;
                continue;
            end
            
            if mod(i,2)==0 && mod(j,2)==0
                output(i,j) = f((i)/2,(j)/2);
            end
                
            if mod(i,2)==1 && mod(j,2)==1
%                 (i-3)/2,(j-3)/2
%                 f((i-3)/2,(j-3)/2)
                b0=getCovBicubicValue(1/2,f((i-3)/2,(j-3)/2), f((i-3)/2,(j-1)/2), f((i-3)/2,(j+1)/2), f((i-3)/2,(j+3)/2));
                b1=getCovBicubicValue(1/2,f((i-1)/2,(j-3)/2) ,f((i-1)/2,(j-1)/2) ,f((i-1)/2,(j+1)/2), f((i-1)/2,(j+3)/2));
                b2=getCovBicubicValue(1/2,f((i+1)/2,(j-3)/2) ,f((i+1)/2,(j-1)/2) ,f((i+1)/2,(j+1)/2), f((i+1)/2,(j+3)/2));
                b3=getCovBicubicValue(1/2, f((i+3)/2,(j-3)/2), f((i+3)/2,(j-1)/2), f((i+3)/2,(j+1)/2), f((i+3)/2,(j+3)/2));
                output(i,j) = getCovBicubicValue(1/2, b0,b1,b2,b3);
            end
               
            if mod(i,2)==1 && mod(j,2)==0
                b0=getCovBicubicValue(0,f((i-3)/2,(j-2)/2), f((i-3)/2,(j)/2), f((i-3)/2,(j+2)/2), f((i-3)/2,(j+4)/2));
                b1=getCovBicubicValue(0,f((i-1)/2,(j-2)/2) ,f((i-1)/2,(j)/2) ,f((i-1)/2,(j+2)/2), f((i-1)/2,(j+4)/2));
                b2=getCovBicubicValue(0,f((i+1)/2,(j-2)/2) ,f((i+1)/2,(j)/2) ,f((i+1)/2,(j+2)/2), f((i+1)/2,(j+4)/2));
                b3=getCovBicubicValue(0, f((i+3)/2,(j-2)/2), f((i+3)/2,(j)/2), f((i+3)/2,(j+2)/2), f((i+3)/2,(j+4)/2));
                output(i,j) = getCovBicubicValue(1/2, b0,b1,b2,b3);
            end
                
            if mod(i,2)==0 && mod(j,2)==1
                b0=getCovBicubicValue(1/2,f((i-2)/2,(j-3)/2), f((i)/2,(j-1)/2), f((i+2)/2,(j+1)/2), f((i+4)/2,(j+3)/2));
                b1=getCovBicubicValue(1/2,f((i-2)/2,(j-3)/2) ,f((i)/2,(j-1)/2) ,f((i+2)/2,(j+1)/2), f((i+4)/2,(j+3)/2));
                b2=getCovBicubicValue(1/2,f((i-2)/2,(j-3)/2) ,f((i)/2,(j-1)/2) ,f((i+2)/2,(j+1)/2), f((i+4)/2,(j+3)/2));
                b3=getCovBicubicValue(1/2, f((i-2)/2,(j-3)/2), f((i)/2,(j-1)/2), f((i+2)/2,(j+1)/2), f((i+4)/2,(j+3)/2));
                output(i,j) = getCovBicubicValue(0, b0,b1,b2,b3);
            end
        end
     end
     time = toc;
    output=cast(output,'like',g);
    imwrite(output, imageOutput);
    o=output;
                
                
                
