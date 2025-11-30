DESCRIPCIÓN Y DOMINIO DEL PROYECTO:

Este proyecto pertenece al área automotriz, específicamente al diagnóstico de fallas en vehículos con base en sus síntomas. 
Es un sistema experto simple que imita el razonamiento básico que un mecánico puede seguir para identificar la posible causa de una falla.
Este sistema experto está desarrollado en Prolog y tiene como objetivo diagnosticar posibles fallas en automóviles basándose en síntomas reportados.
El sistema relaciona síntomas → componentes → soluciones, permitiendo identificar problemas comunes y sugerir acciones de reparación. 
Es capaz de agregar autos, agregar sintomas a los autos, y marcar como reparado los componentes para solucionar los síntomas del auto.


POSIBLES CONSULTAS:

Agregar un nuevo auto a la base de conocimientos: 
  agregar_auto(toyota_supra).
  
Eliminar un nuevo auto a la base de conocimientos: 
  eliminar_auto(toyota_supra).
  
Agregar un síntoma a un auto existente:
  agregar_sintoma(toyota_supra, no_enciende).
  
Eliminar un síntoma a un auto existente:
  eliminar_sintoma(toyota_supra, no_enciende).

Diagnósticar un auto existente: 
  diagnostico(toyota_supra).
  
Marcar como reparado un componente en un auto existente: 
  reparado(toyota_supra, bateria).

Mostrar síntomas de un auto existente: 
  mostrar_sintomas(toyota_supra).

Mostrar todos los autos regtistrados en la base de conocimientos: 
  listar_todos_autos.

Eliminar todos los datos agregados a la base de conocimientos:
  reiniciar_sistema.


