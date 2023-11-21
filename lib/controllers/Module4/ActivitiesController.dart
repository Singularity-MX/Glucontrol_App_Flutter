import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/tools/password_hash.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../configBackend.dart';

// Para acceder a la dirección del backend:
String backendUrl = ApiConfig.backendUrl;

class ActivitiesController {
  // Constructor que recibe la instancia de RegistroModel

  //enviar al backend
  String AddActJSON(String nameAct, classification) {
    //crear el JSON
    Map<String, dynamic> jsonObject = {
      "Activitie_name": nameAct,
      "Classification": classification
    };

    // Convertir el Map en una cadena JSON
    String formData = jsonEncode(jsonObject);

    return formData;
  }
}
