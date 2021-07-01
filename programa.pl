%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Clase 12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* 
1. Modelar las bandas según su género
    ROCK --> The Beatles - Rolling Stones - Los Redondos - Divididos - Soda Stereo - Los Piojos
    POP --> Miranda! - Tan Bionica - Coldplay - One Direction - Maroon 5
    REGGAE --> Los Cafres - Nonpalidece - Los Pericos
    CUMBIA --> Los Palmeras Damas Gratis - Agapornis
*/
% genero banda
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

/* 
2. Modelar las bandas según su país de origen
    Inglaterra: The Beatles - Rolling Stones - Coldplay - One Direction
    Estados Unidos: Maroon 5
    Argentina: ...
*/
% país banda
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


%Si cumplen una condicion Y la otra, es el mismo predicado 
%Si cumplen una condicion O la otra, es el mismo nombre de predicado pero hecho dos veces   
banda(Banda):-
    origen(_,Banda).

banda(Banda):-
    esBandaDe(_,Banda).


% 3. Conocer qué bandas son nacionales y cuáles extranjeras.

esNacional(Banda):-
    origen(argentina,Banda).

esExtranjera(Banda):-
    banda(Banda),
    not(esNacional(Banda)).


% Tests %
% --> origen de una banda 
:- begin_tests(origen).
test(origen_de_una_banda):-
    origen(inglaterra, theBeatles).

test(origen_de_una_banda, fail):-
    origen(inglaterra,miranda).

test(bandas_de_un_origen, set(Banda=[rollingStones, theBeatles, coldplay, oneDirection])):-
    origen(inglaterra,Banda).
:- end_tests(origen).

% --> género de una banda 
:- begin_tests(generos).
test(banda_de_un_genero) :-
	esBandaDe(rock, losPiojos).

test(banda_no_es_de_un_genero, fail) :-
	esBandaDe(reggae, tanBionica).

test(bandas_de_un_genero, set(Banda == [losPalmeras, damasGratis, agapornis])) :-
	esBandaDe(cumbia, Banda).
:- end_tests(generos).

% --> es extranjera una banda
:- begin_tests(extranjera).
test(banda_extranjera, nondet) :-
	esExtranjera(coldplay).

test(banda_no_es_extranjera, fail) :-
	esExtranjera(damasGratis).

test(bandas_extranjeras, set(Banda == [coldplay, maroon5, rollingStones, theBeatles, oneDirection])) :-
	esExtranjera(Banda).
:- end_tests(extranjera).


/* 
5. Grilla de festivales
    COSQUIN ROCK --> Los Redondos - Divididos - Soda Stereo - Los Piojos - Los Palmeras
    LOLLAPALOOZA --> Miranda! - Tan Bionica - Coldplay - One Direction - Maroon 5
    FESTIVAL NUESTRO --> Los Cafres - Nonpalidece - Los Pericos - Damas Gratis - Agapornis
    PDEPALOOZA --> The Beatles - The Rolling Stones - Los Palmeras - Los Redondos - Coldplay
*/
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

% Verifica que TODAS las bandas que participen del festival sean nacionales
esNacAndPop(Festival):-
    participaDe(Festival,_),
    forall(participaDe(Festival,Banda), esNacional(Banda)).
%forall (ANTECEDENTE, CONSECUENTE)

%   Verifica que exista una banda que sea nacional y participe del festival
/* 
esNacAndPop(Festival):-
    participaDe(Festival, Banda),
    esNacional(Banda). 
*/ % Este caso no nos sirve.


festival(Festival):-
    participaDe(Festival,_).


% 6 b. Festival Careta -> aquel que no tiene bandas de cumbia en su grilla.

% Opcion 1 : Forall
esCareta(Festival):-
    festival(Festival),
    forall(
        participaDe(Festival,Banda),
        not(esBandaDe(cumbia,Banda))
    ). 

% Opcion 2 : No existe
esCaretaV2(Festival):-
    participaDe(Festival,_),
    not(tieneBandaDeCumbia(Festival)).

tieneBandaDeCumbia(Festival):-
    participaDe(Festival, Banda),
    esBandaDe(cumbia, Banda).


% 6.c Imperdible para un Género -> aquel que tiene todas las bandas de ese género.
esImperdiblePara(Festival, Genero):-
    esBandaDe(Genero,_),
    festival(Festival),
    forall(esBandaDe(Genero, Banda), participaDe(Festival, Banda)).


% 6.d Festival Monotemático -> aquel que sólo tiene bandas de un género.

% Opción 1: Forall
esMonotematico(Festival):-
    festival(Festival),    % existe un festival y...
    esBandaDe(Genero,_),   % existe un género y...
    forall(
        participaDe(Festival, Banda), 
        esBandaDe(Genero, Banda)
    ). % Toda banda de ese festival tiene ESE género.

% Mal hecho -> género sin ligar
esMonotematicoMALHECHO(Festival):-
    festival(Festival),    % existe un festival y...
    forall(
        participaDe(Festival, Banda), 
        esBandaDe(_, Banda)
    ). % Toda banda de ese festival tiene ALGÚN género.
    
% Opción 2: Not -> Negar el forall
esMonotematicoV2(Festival):-
    festival(Festival),
    esBandaDe(Genero,_),
    not(
        (participaDe(Festival,Banda), not(esBandaDe(Genero, Banda)))
    ).

% Opción 3: Not -> Dividir en subtareas
esMonotematicoV3(Festival):-
    festival(Festival),
    not(existenDosGenerosEn(Festival)).

existenDosGenerosEn(Festival):-
    generoDeFestival(Festival, Genero),
    generoDeFestival(Festival, OtroGenero),
    Genero \= OtroGenero.

generoDeFestival(Festival, Genero):-
    participaDe(Festival,Banda),
    esBandaDe(Genero, Banda).


% Bonus: Saber si una banda es exclusiva de un festival -> solo participa en un único festival.

% Opción 1: forall(otrosFestivales, no participa)
esExclusivaDe(Festival, Banda):-
    participaDe(Festival,Banda),
    forall((participaDe(OtroFestival,_), OtroFestival \= Festival) , not(participaDe(OtroFestival, Banda))).

% Opción 2: participa de ese festival y no participa en mas de un festival.
esExclusivaDe(Festival,Banda):-
    participaDe(Festival,Banda),
    not(participaEnMasDeUnFestival(Banda)).
    
participaEnMasDeUnFestival(Banda):-
    participaDe(OtroFestival,Banda),
    participaDe(Festival,Banda),
    OtroFestival \= Festival.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Clase 13 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hay altas chances que una persona tenga interés por las bandas que son de su nacionalidad.

% Ya contamos con:
    % origen(Pais, Banda).
    % esNacional(Banda).
    % esExtranjera(Banda)

interes(Persona, Banda) :-
    origen(Pais, Banda),
    nacionalidad(Pais, Persona).

nacionalidad(argentina, lita).
nacionalidad(inglaterra, paul).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
Por ejemplo, sabemos de los siguientes eventos:
    - losPiojos tuvieron:
        un show masivo en cosquinRock donde participaron 15 bandas y se hizo en Argentina
        un show propio en un estadio para 70.074 personas
    - damasGratis hacen un show propio en un lugar que tiene capacidad para 9.290 personas
    - oneDirection planea un vivo de instagram en su cuenta oficial: oneDirection con una duracion estimada de 2 horas y media. En su cuenta tienen 22.300.000 followers.
*/
% Queremos saber todos los eventos de una banda.
    % Presentacion pueden ser Show masivo, Show propio, Vivo de ig
    % Functor(es) -> Inidividuos compuestos (de otros individuos) 
    %               -> Son como tuplas pero con nombres
    %               -> Son individuos, no predicados, no tienen valor de verdad, son un dato

% evento(Banda, Presentacion).
% Siendo Presentacion:
    % showMasivo(Festival, CantBandas, Pais)
    % showPropio(Capacidad)
    % vivoDeIG(Cuenta, DuracionEstimada, Followers)

evento(losPiojos, showMasivo(cosquinRock, 15, argentina)).
evento(losPiojos, showPropio(70074)).
evento(damasGratis, showPropio(9290)).
evento(oneDirection, vivoDeIG(oneDirection, 2.5, 22300000)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
asistenciaAsegurada/2: persona y Presentacion 
    -> esa persona podria asistir fácilmente a una presentacion
Para los show masivos si el país coincide con tu nacionalidad
Para los vivos de instagram si se espera una duración menor a 3 horas
*/

asistenciaAsegurada(Persona, showMasivo(_, _, Pais) ) :-
    nacionalidad(Pais, Persona).

asistenciaAsegurada(_, vivoDeIG(_, DuracionEstimada, _) ) :-
    DuracionEstimada < 3.




:- begin_tests(asistencia_asegurada).
test(show_masivo_ok, nondet) :-
	asistenciaAsegurada(lita,  showMasivo(cosquinRock,15,argentina)).

test(show_masivo_fail, fail) :-
	asistenciaAsegurada(paul,  showMasivo(cosquinRock,15,argentina)).

test(vivo_de_ig, nondet) :-
	asistenciaAsegurada(lita, vivoDeIG(oneDirection, 2.5, 22300000)).

test(vivo_de_ig_fail, fail) :-
	asistenciaAsegurada(lita, vivoDeIG(oneDirection, 5, 22300000)).

test(show_propio, fail) :-
	asistenciaAsegurada(paul, showPropio(9290)).

:- end_tests(asistencia_asegurada).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% quiereVer/2: Persona y banda
    % Esto pasa cuando la banda va a presentarse en un evento para el cual la persona tiene asistencia asegurada.

quiereVer(Persona, Banda) :-
    evento(Banda, Presentacion),    % No importa el tipo de presentacion
    asistenciaAsegurada(Persona, Presentacion). % POLIMORFISMO con la presentacion




:- begin_tests(quiere_ver).

test(lita_quiere_ver, set(Banda = [losPiojos, oneDirection])) :-
	quiereVer(lita, Banda).

test(paul_quiere_ver, set(Banda = [oneDirection])) :-
	quiereVer(paul, Banda).

:- end_tests(quiere_ver).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*
asistenciaProyectada/2: Evento y Asistencia
    Para los show propios estimamos la capacidad del lugar
    Para un show masivo es 1000 veces la cantidad de bandas del festival
    Para un vivo de instagram es la centésima parte de la cantidad de seguidores dividido la duración esperada
*/

    % showMasivo(Festival, CantBandas, Pais)
    % showPropio(Capacidad)
    % vivoDeIG(Cuenta, DuracionEstimada, Followers)

% asistenciaProyectada(Presentacion, Asistencia).

asistenciaProyectada(   showPropio(Capacidad),                     Capacidad).

asistenciaProyectada(   showMasivo(_, CantBandas, _),              Asistencia) :-
    is(Asistencia, 1000 * CantBandas).

asistenciaProyectada(   vivoDeIG(_, DuracionEstimada, Followers),  Asistencia) :-
    is(Asistencia, Followers / 100 / DuracionEstimada).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% La banda más popular del momento es la que proyecta la mayor cantidad de asistencia en su evento más popular.

bandaMasPopular(BandaMasPopular) :- % máximo? forall? not?
    banda(BandaMasPopular),
    forall(bandaConEvento(Banda), tieneMasAsistencia(BandaMasPopular, Banda)).

bandaConEvento(Banda) :- evento(Banda, _).

tieneMasAsistencia(BandaConMuchaAsistencia, OtraBanda) :-
    asistenciaDePresentacion(BandaConMuchaAsistencia, AsistenciaMayor),
    asistenciaDePresentacion(OtraBanda, AsistenciaMenor),
    AsistenciaMayor >= AsistenciaMenor.

asistenciaDePresentacion(Banda, Asistencia) :-
    evento(Banda, Presentacion),
    asistenciaProyectada(Presentacion, Asistencia).
