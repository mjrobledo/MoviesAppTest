# MoviesAppTest

## creado por: Miguel de Jesus Robledo Vera

[![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white&labelColor=101010)]()

##### Aplicación desarrollada con Swift 5 .

- Soporta Portrait
- Guarda información en dispositivo para mostrar Favoritos
- Consumo de servicios Rest TheMovie

## Arquitectura

#### MVP

Se utilizaron clases de apoyo para consumir servicios o guardar datos dentro de la aplicación.
 
| Clase | Descripción | 
| ------ | ------ |
| LocalManager | Maneja las funciones para guardar y obtener información desde el teléfono | 
| RemoteDataSource | Maneja el consumo de llamadas al Api rest para obtener la información |
| Singleton | Nos permite persistencia de datos |
| Api | Configuración de Api rest |

## Observaciones:

Para guardar la información del servicio se utilizó CoreData. 
Para proyectos más grandes se puede utilizar algo mas robusto como Realm db, Firebase o alguna otra.


## Librerías

Se utilizaron varias librerías a través de Swift Package Manager

| Framework | Repositorio | 
| ------ | ------ |
| MBProgressHUD | [https://github.com/jdg/MBProgressHUD.git] |
