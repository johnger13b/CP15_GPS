//import 'dart:html';

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
    // TO DO: Asigna a _permissionStatus el futuro que obtiene el estado de los permisos.
    _permissionStatus = controller.permissionStatus;
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
                        // TO DO: 1. Obten la ubicacion actual con controller.currentLocation
                        final location = await controller.currentLocation;
                        // TO DO: 2. Obten la precision de la lectura con controller.locationAccuracy.
                        final accuracy = await controller.locationAccuracy;
                        // TO DO: 3. Con setState actualiza controller.location y controller.accuracy
                        setState(() {
                          controller.location = location;
                          controller.accuracy = accuracy;
                        });
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
                      // TO DO: Actualiza el futuro _permissionStatus con requestPermission
                      setState(() {
                        _permissionStatus = controller.requestPermission();
                      });
                      // TO DO: y setState para que el FutureBuilder vuelva a renderizarse.
                    },
                    child: const Text("Solicitar Permisos")),
              );
            } else {
              // TO DO: Muestra un texto cuando el usuario a denegado el permiso permanentemente
              return const Center(
                child: Text("Acceso a GPS denegado permanentemente"),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            // TO DO: Muestra un texto con el error si ocurre.
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            // TO DO: Mientras el futuro se completa muestra un CircularProgressIndicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

// TO DO: Si controller.location no es null retorna la latitud
  String get _latitudeText => controller.location != null
      ? controller.location!.latitude.toString()
      : "Desconocido";
  // de lo contratio retorna 'Desconocido'

// TO DO: Si controller.location no es null retorna la longitud
  String get _longitudeText => controller.location != null
      ? controller.location!.longitude.toString()
      : "Desconocido";
  // de lo contratio retorna 'Desconocido'

// TO DO: Si controller.accuracy no es null retorna _locationAccuracy!.name
  String get _accuracyText =>
      controller.accuracy != null ? controller.accuracy!.name : "Desconocido";
  // de lo contratio retorna 'Desconocido'
}
