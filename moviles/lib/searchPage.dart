import 'package:flutter/material.dart';
import 'package:moviles/domain/entities/user.dart'; // Asegúrate de importar la clase User desde el archivo correcto

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _postTypeController;
  late TextEditingController _userNameController;
  late TextEditingController _countryController;
  late TextEditingController _cityController;
  late TextEditingController _universityController;
  late TextEditingController _campusController;

  @override
  void initState() {
    super.initState();
    _postTypeController = TextEditingController();
    _userNameController = TextEditingController();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _universityController = TextEditingController();
    _campusController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _postTypeController,
                decoration: InputDecoration(labelText: 'Post Type'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _universityController,
                decoration: InputDecoration(labelText: 'University'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _campusController,
                decoration: InputDecoration(labelText: 'Campus'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes ejecutar la lógica para filtrar los posts según los criterios de búsqueda ingresados
                  // Por ejemplo, podrías usar los valores de los controladores de texto para realizar consultas a una base de datos
                  // y mostrar los resultados en una nueva pantalla o en la misma página de búsqueda.
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
