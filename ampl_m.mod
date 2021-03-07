set depart;
set arrivee;
set chemin;

param X {d in depart, a in arrivee};

var Y {d in depart, a in arrivee, c in chemin} binary;

minimize Fonction_obj:sum {d in depart, a in arrivee, c in chemin} X[d,a]*Y[d,a,c];

subject to contrainte_1 {c in chemin}: sum {d in depart, a in arrivee} Y[d,a,c]= 1;
subject to contrainte_2 {c in chemin}: sum {d in depart, a in arrivee} X[d,a]*Y[d,a,c]>=0.01;
subject to contrainte_3 {a in arrivee}: sum {d in depart, c in chemin} Y[d,a,c]<=1;
subject to contrainte_4 {d in depart}: sum {a in arrivee, c in chemin} Y[d,a,c]<=1;
subject to contrainte_5 {a in arrivee, c in chemin}: sum {d in depart} Y[d,a,c]= sum {d in depart} Y[d,a,c];



