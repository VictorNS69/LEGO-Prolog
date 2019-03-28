% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Nieves','Sanchez','Victor','X150375').
alumno_prode('Carmona','Ayllon','Alejandro','X150251').
alumno_prode('Morgera','Perez','Daniel','X150284').

% ---------------------------------------------------------

% lowerEq/2 Dice si X es menor o igual que Y
lowerEq(X,X).
lowerEq(0,X) :- X\=0.		% min(0,X) = X
lowerEq(s(X),s(Y)) :-
	lowerEq(X,Y).

% compPiezas/2 Compara si la pieza1 es menor que la pieza2 en anchura y profundidad
compPiezas(pieza(AN1,_,P1,_),pieza(AN2,_,P2,_)):-
	lowerEq(AN1,AN2),
	lowerEq(P1,P2).
