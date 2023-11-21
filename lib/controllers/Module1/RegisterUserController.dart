import 'package:Glucontrol/models/Module1/RegistroModel.dart';
import 'package:Glucontrol/tools/password_hash.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../configBackend.dart';

// Para acceder a la dirección del backend:
String backendUrl = ApiConfig.backendUrl;

class RegisterUserController {
  final RegistroModel registro;

  // Constructor que recibe la instancia de RegistroModel
  RegisterUserController(this.registro);

  //enviar al backend
  String CrearJson() {
    //obtiene el IMC
    double imc = getIMC(registro.altura!, registro.peso!);

    //hashea la contraseña
    String salt = "GlucontrolHash"; // Cambia esto por un valor secreto y único
    String hashedPassword = hashPassword(registro.password!, salt);

    //crear el JSON
    Map<String, dynamic> jsonObject = {
      "Nombre": registro.nombre,
      "ApellidoPaterno": registro.apellidoPaterno,
      "ApellidoMaterno": registro.apellidoMaterno,
      "FechaNacimiento": registro.fechaNacimiento,
      "Altura": registro.altura,
      "Peso": registro.peso,
      "IMC": imc,
      "Email": registro.email,
      "Pass": hashedPassword,
    };

    // Convertir el Map en una cadena JSON
    String formData = jsonEncode(jsonObject);

    return formData;
  }

  //GetIMC
  double getIMC(double altura, double peso) {
    // Convertir la altura de centímetros a metros
    double alturaEnMetros =
        altura / 100; // Suponiendo que la altura está en centímetros

    // Calcular el IMC
    double imc = peso / (alturaEnMetros * alturaEnMetros);

    return imc;
  }
}
