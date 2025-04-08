# tarea_14_database
### Objectivo:
- Crear un CRUD utilizando `firebase` con el servicio de `Cloud FireStore`

### Objectivos de la tarea:
- Crear una aplicación para mostrar los productos en un **ListView**. Muestra su nombre, su precio y si está disponible en cada tarjeta.
- Cada tarjeta debe de tener un ícono de `Editar` y de `Eliminar`. Al eliminar, debe de borrar el producto. Para editar, utiliza el formulario del siguiente punto con la información del producto cargada.
- Agrega un botón para `Crear Producto`. Debe mostrarte en una pantalla nueva un formulario para crear un producto nuevo. Al crearlo, se debe mostrar en la lista.

# Dependencies

- `firebase` para la base de datos
- `flutter` para el desarrollo de la aplicación
- `cloud_firestore` para interactuar con la base de datos de Firebase

# Ambientes necesarios
- `firebase` = 13.35.1
- `flutter` = Flutter 3.27.2
- `dart` = Dart SDK version: 3.6.1 (stable)

# Pasos para correr la aplicacion
1. Instalar las dependencias
```bash
flutter pub get
```
2. Configurar tu aplicacion con firebase.
```bash
flutterfire config
```
*Despues seleccionas tu proyecto de firebase*

3. Correr la aplicación
```bash
flutter run
```