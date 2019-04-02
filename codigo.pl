% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Nieves','Sanchez','Victor','X150375').
alumno_prode('Carmona','Ayllon','Alejandro','X150251').
alumno_prode('Morgera','Perez','Daniel','X150284').

% ---------------------------------------------------------
% ---------------------- Auxiliares -----------------------
% menorIgual/2 Dice si X es menor o igual que Y
menorIgual(X,X).
menorIgual(0,X) :- X\=0.
menorIgual(s(X),s(Y)) :-
	menorIgual(X,Y).

% compPiezas/2 Compara si la pieza1 es menor que la pieza2 en anchura y profundidad.
compPiezas(pieza(AN1,_,P1,_),pieza(AN2,_,P2,_)):-
	menorIgual(AN1,AN2),
	menorIgual(P1,P2).

% tamanio/2 Compara si la lista (primer argumento) tiene el tamaño del segundo argumento.
tamanio([],0).
tamanio([_|Xs],s(N)) :-
	tamanio(Xs,N).

% concatenar/3 Indica si la lista de tercer argumento es la concatenación del primer y el segundo argumento.
concatenar([],X,X).
concatenar([X|L1],L2,[X|L3]):-
        concatenar(L1,L2,L3).

% miembro/2 Indica si el primere elemento (primer argumento) está en la lista del segundo argumento
miembro(X,[X|_]).
miembro(X,[Y|Ys]) :-
	miembro(X,Ys).

% --------------------- Principales ----------------------
% esTorre/1 predicado que verifica si se cumplen las condiciones para ser una torre.
esTorre([pieza(_,_,_,_)]).
esTorre([pieza(AN1,AL1,P1,C1),pieza(AN2,AL2,P2,C2)|Piezas]):-
	compPiezas(pieza(AN1,AL1,P1,C1),pieza(AN2,AL2,P2,C2)),
	esTorre([pieza(AN2,AL2,P2,C2)|Piezas]).

% alturaTorre/2 predicado que verifica si el primer argumento es una torre, y el segundo argumento es la altura de la torre.
alturaTorre([],0).
alturaTorre(Piezas,Tamanio):-
	esTorre(Piezas),
	tamanio(Piezas,Tamanio).

% coloresTorre/2 verifica si el primer argumento es una torre y el segundo argumento es una lista con los colores de la torre.
coloresTorre(T,C) :-
	esTorre(T),
	coloresTorre_(T,C).

% coloresTorre_/2 escribe la lista de colores
coloresTorre_([],[]).
coloresTorre_([pieza(_,_,_,C)|Piezas],[C|RestoColores]):-
	coloresTorre_(Piezas,RestoColores).

% cloresIncluidos/2 predicado que verifica si los argumentos son torres y que todos los colores de la lista 1 también están en los de la lista 2.
coloresIncluidos(T1,T2):-
	coloresTorre(T1,L1),
	coloresTorre(T2,L2),
	coloresIncluidos_(L1,L2).

% coloresIncluidos_/2 compara las listas de colores, e indica si los colores de una estan incluidas en la otra
coloresIncluidos_([],_).
coloresIncluidos_([Elemento1|Resto],L2):-
	miembro(Elemento1,L2),
	coloresIncluidos_(Resto,L2).
	

