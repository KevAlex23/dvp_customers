# dvp_customers
App para clientes hecha con flutter.

## Bibliotecas y herramientas utilizadas

- [get](https://pub.dev/packages/get) (GetX State Management - Dependence Manager)
- [Hive](https://pub.dev/packages/hive) (para local storage)

GetX es una buena opción porque reduce muchísimo el boilerplate, mejora la productividad y mantiene un muy buen rendimiento al actualizar solo lo necesario. Permite manejar estado, navegación e inyección de dependencias desde un solo paquete, lo que simplifica la arquitectura y evita dependencias innecesarias. Además, tiene una curva de aprendizaje corta y facilita iterar rápido, especialmente en proyectos pequeños o medianos donde el tiempo y la claridad del código son clave.

## Folder Structure
```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```
Aquí está la estructura de carpetas de este proyecto (arquitectura limpia)
```
lib/
|- core (contains const values to use in global app)
|- data (data layer, contains all about the data management (models), repository and api resource)
|- domain (entity layer, usecases)
|- presentation (User Interface layer)
```
