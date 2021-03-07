set D;
set A;
set C;

param X {d in D, a in A};

var Y {d in D, a in A, c in C} binary;

minimize Fonction_obj:sum {d in D, a in A, c in C} X[d,a]*Y[d,a,c];

subject to contrainte_1 {c in C}: sum {d in D, a in A} Y[d,a,c]= 1;
subject to contrainte_2 {c in C}: sum {d in D, a in A} X[d,a]*Y[d,a,c]>=0.01;
subject to contrainte_3 {a in A}: sum {d in D, c in C} Y[d,a,c]<=1;
subject to contrainte_4 {d in D}: sum {a in A, c in C} Y[d,a,c]<=1;
subject to contrainte_5 {a in A, c in C}: sum {d in D} Y[d,a,c]= sum {d in D} Y[d,a,c];



