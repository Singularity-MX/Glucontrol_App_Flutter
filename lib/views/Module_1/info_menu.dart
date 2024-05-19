import 'package:flutter/material.dart';
import 'package:Glucontrol/views/Module_1/registro_screen_name.dart';
import 'package:Glucontrol/views/Module_2/login.dart';

class InfoMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Image.asset(
            'lib/assets/fondoMenu.jpg', // Ruta de la imagen de fondo
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Logo en el centro

          // Contenedor con bordes redondeados y sombreado
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                height: MediaQuery.of(context).size.height *
                    0.3, // Altura del 30% de la pantalla
                width: MediaQuery.of(context)
                    .size
                    .width, // Ancho del 100% de la pantalla
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(0.25), // Color del sombreado
                      spreadRadius: 5, // Radio de difusión
                      blurRadius: 7, // Radio de desenfoque
                      offset: Offset(0, 3), // Desplazamiento en X y Y
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'GlucoSync',
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            Color.fromRGBO(34, 34, 34, 1), // Color de la línea
                        fontWeight: FontWeight.w400, // Fuente Extra Light
                      ),
                      textAlign: TextAlign.justify, // Justificar el texto
                    ),
                    SizedBox(height: 20), // Espacio entre el texto y la línea
                    Divider(
                      height: 1, // Altura de la línea
                      color: Color.fromRGBO(71, 71, 71, 1), // Color de la línea
                    ),
                    SizedBox(
                        height: 30), // Espacio entre la línea y los botones
                    ElevatedButton(
                      onPressed: () {
                        // Navegar a la página de inicio de sesión
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginApp()),
                        );
                      },
                      child: Text('Iniciar sesión', 
                         style: TextStyle(
      color: Colors.white, // Color del texto blanco
    ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 97, 199, 190),// Color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Radio de esquinas de 15
                        ),
                        minimumSize: Size(
                          MediaQuery.of(context).size.width *
                              0.7, // Ancho del 70% de la pantalla
                          43, // Altura de 43
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navegar a la página de registro
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistroScreen()),
                        );
                      },
                      child: Text('Crear una cuenta',
                         style: TextStyle(
      color: Color.fromARGB(255, 97, 199, 190), // Color del texto blanco
    ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                            54, 59, 62, 1), // Color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Radio de esquinas de 15
                        ),
                        minimumSize: Size(
                          MediaQuery.of(context).size.width *
                              0.7, // Ancho del 70% de la pantalla
                          43, // Altura de 43
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          // Texto en la parte inferior
        ],
      ),
    );
  }
}
