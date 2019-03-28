% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Nieves','Sanchez','Victor','X150375').
alumno_prode('Carmona','Ayllon','Alejandro','X150251').
alumno_prode('Morgera','Perez','Daniel','X150284').

% ---------------------------------------------------------
% ---------------------- Auxiliares -----------------------
% lowerEq/2 Dice si X es menor o igual que Y
lowerEq(X,X).
lowerEq(0,X) :- X\=0.		% min(0,X) = X
lowerEq(s(X),s(Y)) :-
	lowerEq(X,Y).

% compPiezas/2 Compara si la pieza1 es menor que la pieza2 en anchura y profundidad.
compPiezas(pieza(AN1,_,P1,_),pieza(AN2,_,P2,_)):-
	lowerEq(AN1,AN2),
	lowerEq(P1,P2).

% tamanio/2 Compara la lista (primer argumento) tiene el tamaño del segundo argumento.
tamanio([],0).
tamanio([_|Xs],s(N)) :-
	tamanio(Xs,N).

% --------------------- Principales ----------------------
% esTorre/1 predicado que se verifica si se cumplen las condiciones para ser una torre.
esTorre([pieza(_,_,_,_)]).
esTorre([pieza(AN1,AL1,P1,C1),pieza(AN2,AL2,P2,C2)|Piezas]):-
	compPiezas(pieza(AN1,AL1,P1,C1),pieza(AN2,AL2,P2,C2)),
	esTorre([pieza(AN2,AL2,P2,C2)|Piezas]).

% alturaTorre/2 predicado que verifica si el primer argumento es una torre, y el segundo argumento es la altura de la torre.
alturaTorre([],0).
alturaTorre(Piezas,Tamanio):-
	esTorre(Piezas),
	tamanio(Piezas,Tamanio).
