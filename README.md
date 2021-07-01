# Festivales
_Continuamos el ejemplo de [la clase pasada](https://github.com/pdepjm/2021-l-clase12-not-forall) para ver de qué se trata el **polimorfismo**._

## Enunciado

![Selection_483](https://user-images.githubusercontent.com/4098184/124152855-455c5680-da6a-11eb-918c-58d9c25fda96.png)

Están en las [ppts de la clase](https://docs.google.com/presentation/d/18WbteGv1q8jbcAOjGYROKXneMogo3EqdcCuyshKLLM8/edit#slide=id.ge257e66a48_0_2581), les dejamos un resumen de la solución:
- **interes/2**: una persona tiene interés por las bandas que son de su nacionalidad.
- **evento/2**: modelar las presentaciones que tienen cada banda.
- **asistenciaAsegurada/2**: saber si una persona podria asistir fácilmente a una presentacion, que depende del tipo de presentación.
- **quiereVer/2**: Esto pasa cuando la banda va a presentarse en un evento para el cual la persona tiene asistencia asegurada.
- **asistenciaProyectada/2**: Cada tipo de presentación tiene su propio cálculo.
- **bandaMasPopular/1**: La banda más popular del momento es la que proyecta la mayor cantidad de asistencia en su evento más popular.

![image](https://user-images.githubusercontent.com/4098184/124153470-d8958c00-da6a-11eb-9ad3-b3490f9488a4.png)
