# Taquexpress XD
## ¿Qué es este proyecto?
La idea es una aplicación para tomar órdenes en una taquería, esto es solamente el frontend el cual estará hecho en Dart + Rust y Flutter (en dart) como el Framework para crear la interface.

## Dependencias
Las únicas dependencias importantes son tener instalados:
* SDK de Flutter
* Dart
* Rust
Rust necesita agregar las arquitecturas necesarias para poder ejecutarse en teléfonos se puden agregar con ```rustup target add \
    aarch64-linux-android \
    aarch64-apple-ios \
    armv7-linux-androideabi \
    x86_64-linux-android \
    x86_64-apple-ios```

## Compilación
Para compilar la librería bastaría con hacer ```cargo build --target *arquitectura*``` específicando cual es la arquitectura para la cual se compilará, por lo que se tendría que repetir el comando varias veces para compilarlo en todas. Una vez compilado se tiene que mover a los directorios necesarios para que Dart pueda acceder a ellos.
Si todo fue sin problemas solo hace falta ejecutar ```flutter run``` con un teléfono conectado y tener el servidor (backend) encendido.

## Directorios en donde se guardan las librerías dinámicas
* ```packages/server_client/android/src/main/jniLibs/arm64-v8a/```
* ```packages/server_client/ios/```