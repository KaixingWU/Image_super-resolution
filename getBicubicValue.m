function o=getBicubicValue(x,y,A)
    x2 = x * x;
    x3 = x2 * x;
    y2 = y * y;
    y3 = y2 * y;

    o=(A(1,1) + A(1,2) * y + A(1,3) * y2 + A(1,4) * y3) + (A(2,1) + A(2,2) * y + A(2,3) * y2 + A(2,4) * y3) * x + (A(3,1) + A(3,2) * y + A(3,3) * y2 + A(3,4) * y3) * x2 +(A(4,1) + A(4,2) * y + A(4,3) * y2 + A(4,4) * y3) * x3;

