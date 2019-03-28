% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Nieves','Sanchez','Victor','X150375').
alumno_prode('Carmona','Ayllon','Alejandro','X150251').
alumno_prode('Morgera','Perez','Daniel','X150284').

% Programa:
% lowerEq(X,Y) --> X <= Y
lowerEq(X,X).
lowerEq(0,X) :- X\=0.		% min(0,X) = X
lowerEq(s(X),s(Y)) :-
	lower(X,Y).

% compPiezas/2
compPiezas(pieza(AN1,_,P1,_),pieza(AN2,_,P2,_)):-
	lower(AN1,AN2),
	lower(P1,P2).
