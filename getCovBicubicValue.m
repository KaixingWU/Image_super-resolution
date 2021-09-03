function o=getCovBicubicValue(t,a1,a2,a3,a4)
    o=0.5*[1 t t^2 t^3]*[0 2 0 0; -1 0 1 0; 2 -5 4 -1; -1 3 -3 1]*transpose([a1 a2 a3 a4]);
