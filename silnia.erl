-module (silnia)
-export ([fact/1,mnoz/2]).

fact (0) -> 1;
fact (N) -> N * fact(N-1).

mnoz (X, Y) -> X * Y.
