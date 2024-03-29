% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Sanchez','Nieves','Victor','X150375').
alumno_prode('Ayllon','Carmona','Alejandro','X150251').
alumno_prode('Perez','Morgera','Daniel','X150284').

% ----------------------------------------------------------------------------------------------------------------------
% ----------------------------------------------------- Auxiliares -----------------------------------------------------

% colorValido/1 Indica si es un color valido 
colorV(a). 	% Azul
colorV(am).	% Amarillo
colorV(r).	% Rojo
colorV(v).	% Verde
colorV(b).	% Vacío/Blanco/Nada

% nat(X)/1 --> X es un numero natural
nat(0).
nat(s(X)) :-
	nat(X).

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

% alturaPieza/2 Indica si la pieza (argumento1) tiene la altura del argumento2.
alturaPieza(pieza(_,A,_,_),A).

% concatenar/3 Indica si la lista de tercer argumento es la concatenación del primer y el segundo argumento.
concatenar([],X,X).
concatenar([X|L1],L2,[X|L3]):-
        concatenar(L1,L2,L3).

% miembro/2 Indica si el primere elemento (primer argumento) está en la lista del segundo argumento
miembro(X,[X|_]).
miembro(X,[_|Ys]) :-
	miembro(X,Ys).

% esPar(X)/1 --> X es Par 
esPar(0).		% 0 es Par
esPar(s(s(X))) :-	% n es Par si n-2 es Par
	esPar(X).	

% suma(X,Y,Z)/3 --> Z = X+Y
suma(0,X,X).  				% 0+X = X
suma(s(X),Y,Z) :-			% (1+X)+Y = X+(Y+1)
	suma(X,s(Y),Z).

% multiplicacion(X,Y,Z)/3 --> Z=X*Y
multiplicacion(0,X,0) :- nat(X).          % 0*X=0
multiplicacion(s(X),Y,Z) :-               % (X+1)*Y=(X*Y)+Y
	multiplicacion(X,Y,A),
	suma(A,Y,Z).
 
% contarClavos/2 Indica si el número de elementos distintos a 'b' de la lista (primer argumento) es el número del segundo argumento
contarClavos([],0).
contarClavos([b|Resto],N):-
	contarClavos(Resto,N).
contarClavos([E1|Resto],s(Resultado)):-
	E1\=b,
	colorV(E1),
	contarClavos(Resto,Resultado).
contarClavos([b|Resto],s(Resultado)):-
	contarClavos(Resto,s(Resultado)).

% menorQue/2 Dice si X es menor que Y
menorQue(0,X) :- X\=0.
menorQue(s(X),s(Y)) :-
	menorQue(X,Y).
% ----------------------------------------------------- Principales -----------------------------------------------------

% esTorre/1 predicado que verifica si se cumplen las condiciones para ser una torre.
esTorre([pieza(AN1,AL1,P1,C1)]):-
	nat(AN1),nat(AL1),nat(P1),
	colorV(C1).
esTorre([pieza(AN1,AL1,P1,C1),pieza(AN2,AL2,P2,C2)|Piezas]):-
	colorV(C1),colorV(C2),
	nat(AL1),nat(AL2),
	compPiezas(pieza(AN1,AL1,P1,C1),pieza(AN2,AL2,P2,C2)),
	esTorre([pieza(AN2,AL2,P2,C2)|Piezas]).

% alturaTorre/2 predicado que verifica si el primer argumento es una torre, y el segundo argumento es la altura de la torre.
alturaTorre([],0).
alturaTorre([pieza(_,A1,_,_)|Resto],Altura):-
	alturaTorre(Resto,Aaux),
	suma(Aaux,A1,Altura).

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
	
% esEdificioPar/1 predicado que es cierto si el argumento es un edificio que cumple que cada nivel tiene un número par de clavos
esEdificioPar([]).
esEdificioPar([L1|Resto]):-
	contarClavos(L1,R),
	esPar(R),
	esEdificioPar(Resto).

% esEdificioPiramide/1 predicado que verifica si Construccion es un edificio que cumple que cada nivel tiene ancho estrictamente mayor que el nivel de arriba.
esEdificioPiramide([L]):-
	L\=b,
	contarClavos(L,_).
esEdificioPiramide([L1|[L2|Resto]]):-
	contarClavos(L1,Clavos1),
	contarClavos(L2,Clavos2),
	menorQue(Clavos1,Clavos2),
	esEdificioPiramide([L2|Resto]).
