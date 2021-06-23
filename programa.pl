% 1. Modelar las bandas según su género
%Genero, banda

% 2. Modelar las bandas según su género
% Pais, banda

% 3. Conocer qué bandas son nacionales y cuáles extranjeras.

% 4. Conocer qué bandas no se llevan bien: esto sucede cuando son de distinto género.

% Tests %

% 5. Grilla de festivales

% 6 a. Festival Nac & Pop -> aquel para el que todas las bandas son nacionales.

% 6 b. Festival Careta -> aquel que no tiene bandas de cumbia en su grilla.

% 6.c Imperdible para un Género -> aquel que tiene todas las bandas de ese género.

% 6.d Festival Monotemático -> aquel que sólo tiene bandas de un género.

% Bonus: Saber si una banda es exclusiva de un festival -> aquella que sólo participa en ese festival.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1. Modelar las bandas según su género
%Genero, banda
esBandaDe(rock, theBeatles).
esBandaDe(rock, rollingStones).
esBandaDe(rock, losRedondos).
esBandaDe(rock, divididos).
esBandaDe(rock, sodaStereo).
esBandaDe(rock, losPiojos).

esBandaDe(pop, miranda).
esBandaDe(pop, tanBionica).
esBandaDe(pop, coldplay).
esBandaDe(pop, oneDirection).
esBandaDe(pop, maroon5).

esBandaDe(reggae, losCafres).
esBandaDe(reggae, nonpalidece).
esBandaDe(reggae, losPericos).

esBandaDe(cumbia, losPalmeras).
esBandaDe(cumbia, damasGratis).
esBandaDe(cumbia, agapornis).

% 2. Modelar las bandas según su género
% Pais, banda

origen(inglaterra, theBeatles).
origen(inglaterra, rollingStones).
origen(argentina, losRedondos).
origen(argentina, divididos).
origen(argentina, sodaStereo).
origen(argentina, losPiojos).

origen(argentina, miranda).
origen(argentina, tanBionica).
origen(inglaterra, coldplay).
origen(inglaterra, oneDirection).
origen(estadosUnidos, maroon5).

origen(argentina, losCafres).
origen(argentina, nonpalidece).
origen(argentina, losPericos).

origen(argentina, damasGratis).
origen(argentina, losPalmeras).
origen(argentina, agapornis).


% es Nacional 
esNacional(Banda):-
    origen(argentina,Banda).


% es extranjera
esExtranjera(Banda):-
    esBandaDe(_,Banda),
    not(esNacional(Banda)).


% Tests %

:- begin_tests(generos).
test(banda_de_un_genero) :-
	esBandaDe(rock, losPiojos).

test(banda_no_es_de_un_genero, fail) :-
	esBandaDe(reggae, tanBionica).

test(bandas_de_un_genero, set(Banda == [losPalmeras, damasGratis, agapornis])) :-
	esBandaDe(cumbia, Banda).
:- end_tests(generos).

% test extranjera %
:- begin_tests(extranjera).
test(banda_extranjera) :-
	esExtranjera(coldplay).

test(banda_no_es_extranjera, fail) :-
	esExtranjera(damasGratis).

test(bandas_extranjeras, set(Banda == [rollingStones, theBeatles, coldplay, maroon5, oneDirection])) :-
	esExtranjera(Banda).
:- end_tests(extranjera).


% 5. Grilla de Festivales

participaDe(cosquinRock, losRedondos).
participaDe(cosquinRock, divididos).
participaDe(cosquinRock, sodaStereo).
participaDe(cosquinRock, losPiojos).
participaDe(cosquinRock, losPalmeras).

participaDe(lollaPalooza, miranda).
participaDe(lollaPalooza, tanBionica).
participaDe(lollaPalooza, coldplay).
participaDe(lollaPalooza, oneDirection).
participaDe(lollaPalooza, maroon5).

participaDe(festivalNuestro, losCafres).
participaDe(festivalNuestro, nonpalidece).
participaDe(festivalNuestro, losPericos).
participaDe(festivalNuestro, damasGratis).
participaDe(festivalNuestro, agapornis).

participaDe(pdePalooza, rollingStones).
participaDe(pdePalooza, theBeatles).
participaDe(pdePalooza, losPalmeras).
participaDe(pdePalooza, losRedondos).
participaDe(pdePalooza, coldplay).

% 6 a. Festival Nac & Pop -> aquel para el que todas las bandas son nacionales.
% forall antecedente consecuente
esNacAndPop(Festival):-
    participaDe(Festival,_),
    forall(participaDe(Festival,Banda), esNacional(Banda)).    

% 6 b. Festival Careta -> es aquel que no tiene bandas de cumbia en su grilla.

% Vx (P(x) => Q(x)) 
% para todas las bandas del festival => no son bandas de cumbia
esCareta(Festival):-
    forall(participaDe(Festival, Banda), not(esBandaDe(cumbia, Banda))).

% ~Ex / (P(x) ^ ~Q(x))
% no existe una banda que participe del festival y no sea de cumbia.

esCareta(Festival):-
    not(tieneBandaDeCumbia(Festival)).

tieneBandaDeCumbia(Festival):-
    participaDe(Festival, Banda),
    esBandaDe(cumbia, Banda).

% 6.c Imperdible para un Género: es aquel que tiene todas las bandas de ese género.
esImperdiblePara(Festival, Genero):-
    participaDe(Festival,_),
    forall(esBandaDe(Genero, Banda), participaDe(Festival, Banda)).
% probar con bachata punk

% 6.d Festival Monotemático -> aquel que sólo tiene bandas de un género.
esMonotematico(Festival):-
    %participaDe(Festival,_),
    esBandaDe(Genero, _),
    forall(participaDe(Festival, Banda), esBandaDe(Genero,Banda)).

% Bonus: Saber si una banda es exclusiva de un festival -> solo participa en un único festival.
esExclusivaDe(Festival, Banda):-
    participaDe(Festival,Banda),
    forall((participaDe(OtroFestival,_), OtroFestival \= Festival) , not(participaDe(OtroFestival, Banda))).
    %forall(otrosFestivales, no participa)

% Opcion con el not.
esExclusivaDe(Festival,Banda):-
    participaDe(Festival,Banda),
    not(participaEnMasDeUnFestival(Banda)).
    
participaEnMasDeUnFestival(Banda):-
    participaDe(OtroFestival,Banda),
    participaDe(Festival,Banda),
    OtroFestival \= Festival.

 
