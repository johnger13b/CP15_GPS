import 'package:f_gps/ui/controllers/gps.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  late GpsController controller;
  late Future<LocationPermission> _permissionStatus;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    // TODO: Asigna a _permissionStatus el futuro que obtiene el estado de los permisos.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPS Location"),
      ),
      body: FutureBuilder<LocationPermission>(
        future: _permissionStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final status = snapshot.data!;
            if (status == LocationPermission.always ||
                status == LocationPermission.whileInUse) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("LATITUD: $_latitudeText"),
                    Text("LONGITUD: $_longitudeText"),
                    Text("PRECISION: $_accuracyText"),
                    const SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // TODO: 1. Obten la ubicacion actual con controller.currentLocation
                        // TODO: 2. Obten la precision de la lectura con controller.locationAccuracy.
                        // TODO: 3. Con setState actualiza controller.location y controller.accuracy
                      },
                      child: const Text("Obtener Ubicacion"),
                    ),
                  ],
                ),
              );
            } else if (status == LocationPermission.unableToDetermine ||
                status == LocationPermission.denied) {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      // TODO: Actualiza el futuro _permissionStatus con requestPermission
                      // TODO: y setState para que el FutureBuilder vuelva a renderizarse.
                    },
                    child: const Text("Solicitar Permisos")),
              );
            } else {
              // TODO: Muestra un texto cuando el usuario a denegado el permiso permanentemente
            }
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            // TODO: Muestra un texto con el error si ocurre.
          } else {
            // TODO: Mientras el futuro se completa muestra un CircularProgressIndicator
          }
        },
      ),
    );
  }

  String get _latitudeText => // TODO: Si controller.location no es null retorna la latitud
  // de lo contratio retorna 'Desconocido'

  String get _longitudeText => // TODO: Si controller.location no es null retorna la longitud
  // de lo contratio retorna 'Desconocido'

  String get _accuracyText => // TODO: Si controller.accuracy no es null retorna _locationAccuracy!.name
  // de lo contratio retorna 'Desconocido'
}
