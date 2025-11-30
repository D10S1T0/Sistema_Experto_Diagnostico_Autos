:- dynamic auto_sintoma/2.
:- dynamic componente_reparado/2.

%Relacion entre sintomas y componentes
causa(no_enciende, bateria).
causa(no_enciende, alternador).
causa(no_enciende, bomba_gasolina).
causa(enciende_y_se_apaga, filtro_gasolina).
causa(enciende_y_se_apaga, bujias).
causa(tironea, bujias).
causa(tironea, filtro_aire).
causa(humo_excesivo, motor).
causa(frena_mal, sistema_frenos).
causa(ruido_motor, motor).
causa(calienta, sistema_refrigeracion).
causa(vibracion_excesiva, suspension).
causa(consumo_alto, filtro_aire).
causa(luces_tenues, sistema_electrico).
causa(cambios_duros, caja_cambios).
causa(olor_gasolina, bomba_gasolina).
causa(bateria_se_descarga, alternador).
causa(ralenti_inestable, bujias).
causa(ralenti_inestable, filtro_aire).

%Soluciones por componente
solucion(bateria, 'Recargar o reemplazar la bateria').
solucion(alternador, 'Revisar y posiblemente reemplazar el alternador').
solucion(motor, 'Diagnostico completo del motor por especialista').
solucion(filtro_aire, 'Reemplazar el filtro de aire').
solucion(filtro_gasolina, 'Reemplazar el filtro de gasolina').
solucion(bujias, 'Reemplazar las bujias y verificar cables').
solucion(sistema_frenos, 'Revisar pastillas, discos y liquido de frenos').
solucion(caja_cambios, 'Verificar nivel de aceite y sincronizacion').
solucion(sistema_refrigeracion, 'Revisar radiador, mangueras y liquido refrigerante').
solucion(suspension, 'Revisar amortiguadores y bujes de suspension').
solucion(sistema_electrico, 'Verificar cableado y conexiones electricas').
solucion(bomba_gasolina, 'Revisar y posiblemente reemplazar la bomba de gasolina').

%Autos con sintomas
auto_sintoma(toyota_corolla, no_enciende).
auto_sintoma(toyota_corolla, luces_tenues).
auto_sintoma(ford_focus, tironea).
auto_sintoma(ford_focus, ralenti_inestable).
auto_sintoma(honda_civic, frena_mal).
auto_sintoma(chevrolet_spark, calienta).
auto_sintoma(chevrolet_spark, humo_excesivo).
auto_sintoma(volkswagen_gol, cambios_duros).
auto_sintoma(nissan_sentra, bateria_se_descarga).
auto_sintoma(nissan_sentra, luces_tenues).
auto_sintoma(hyundai_accent, enciende_y_se_apaga).
auto_sintoma(fiat_palio, vibracion_excesiva).
auto_sintoma(renault_logan, ruido_motor).
auto_sintoma(mazda_3, olor_gasolina).
auto_sintoma(mazda_3, enciende_y_se_apaga).

%Reglas de diagnostico
componente_sospechoso(Auto, Componente) :-
    auto_sintoma(Auto, Sintoma),
    causa(Sintoma, Componente),
    \+ componente_reparado(Componente, Auto). 

falla_critica(Auto, Componente) :-
    auto_sintoma(Auto, no_enciende),
    causa(no_enciende, Componente).

falla_seguridad(Auto, Componente) :-
    auto_sintoma(Auto, frena_mal),
    causa(frena_mal, Componente).
falla_seguridad(Auto, Componente) :-
    auto_sintoma(Auto, vibracion_excesiva),
    causa(vibracion_excesiva, Componente).

diagnostico(Auto) :-
    write('Diagnostico: '), writeln(Auto),
    writeln('------------------------------------------------'),
    
    findall(S, auto_sintoma(Auto, S), Sintomas),
    write('Sintomas: '), writeln(Sintomas),
    
    findall(C, componente_sospechoso(Auto, C), Componentes),
    write('Posibles problemas: '), writeln(Componentes),
    
    escribir_soluciones(Componentes),
    writeln('------------------------------------------------').


escribir_soluciones([]).
escribir_soluciones([C|Cs]) :-
    solucion(C, S),
    write('Posibles soluciones para '), write(C), write(': '), writeln(S),
    escribir_soluciones(Cs).

%Agregar y elimar autos y sintomas
agregar_auto(Auto) :-
    assertz(auto_sintoma(Auto, ninguno)),
    write('Auto registrado: '), writeln(Auto).

agregar_sintoma(Auto, Sintoma) :-
    retract(auto_sintoma(Auto, ninguno)),
    assertz(auto_sintoma(Auto, Sintoma)),
    write('Sintoma agregado: '), write(Sintoma), write(' a '), writeln(Auto).

agregar_sintoma(Auto, Sintoma) :-
    assertz(auto_sintoma(Auto, Sintoma)),
    write('Sintoma agregado: '), write(Sintoma), write(' a '), writeln(Auto).

eliminar_sintoma(Auto, Sintoma) :-
    retract(auto_sintoma(Auto, Sintoma)),
    write('Sintoma eliminado: '), write(Sintoma), write(' de '), writeln(Auto).

eliminar_auto(Auto) :-
    retractall(auto_sintoma(Auto, _)),
    write('Auto eliminado: '), writeln(Auto).

%Gestion de reparaciones
reparado(Auto, Componente) :-
    assertz(componente_reparado(Componente, Auto)),
    write('Componente '), write(Componente),
    write(' reparado en '), writeln(Auto),
    eliminar_sintomas_por_componente(Auto, Componente).

eliminar_sintomas_por_componente(Auto, Componente) :-
    forall(
        causa(Sintoma, Componente),
        (   
            auto_sintoma(Auto, Sintoma),
            retract(auto_sintoma(Auto, Sintoma)),
            write('Sintoma eliminado: '), write(Sintoma), 
            write(' de '), writeln(Auto)
        )
    ).

%Consultas
mostrar_sintomas(Auto) :-
    findall(S, auto_sintoma(Auto, S), Sintomas),
    write('Auto: '), write(Auto), 
    write(' - Sintomas: '), writeln(Sintomas).

listar_todos_autos :-
    findall(A, auto_sintoma(A, _), Autos),
    writeln('Lista de autos:'),
    escribir_autos(Autos).

escribir_autos([]).
escribir_autos([A|As]) :-
    mostrar_sintomas(A),
    escribir_autos(As).

%limpiar base de conocimientos
reiniciar_sistema :-
    retractall(auto_sintoma(_, _)),
    retractall(componente_reparado(_)),
    writeln('Sistema reiniciado').
