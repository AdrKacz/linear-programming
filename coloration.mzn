var int: n;

var int: a;
var int: b;
var int: c;
var int: d;
var int: e;
var int: f;

constraint a >= 1 /\ a <= n;
constraint b >= 1 /\ b <= n;
constraint c >= 1 /\ c <= n;
constraint d >= 1 /\ d <= n;
constraint e >= 1 /\ e <= n;
constraint f >= 1 /\ f <= n;

constraint a != b /\ a != c /\ a != d /\ a != e;
constraint b != a /\ b != c /\ b != d /\ b != f;
constraint c != a /\ c != b /\ c != e /\ c != f;
constraint d != a /\ d != b /\ d != e /\ d != f;
constraint e != a /\ e != c /\ e != d /\ e != f;
constraint f != b /\ f != c /\ f != d /\ f != e;

solve minimize n;