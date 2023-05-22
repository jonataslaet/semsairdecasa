import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/repositories/city_repository.dart';

class CityListController extends StatefulWidget {
  const CityListController({Key? key}) : super(key: key);

  @override
  State<CityListController> createState() => _CityListControllerState();
}

class _CityListControllerState extends State<CityListController> {
  // Lista de cidades, inicialmente vazia
  List<Map<String, dynamic>> _cities = [];

  bool _isLoading = true;
  // Esse método é utilizado para pegar as cidades cadastradas no banco de dados
  void _refreshCities() async {
    final data = await CityRepository.getCities();
    setState(() {
      _cities = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshCities(); // Carregando as cidades cadastradas quando a aplicação inicia
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  // Esse método será executado quando o botão de criar for pressionado
  // Também será executado quando o botão de atualizar fo pressionado
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> cria um novo item
      // id != null -> atualiza um item existente
      final existingCity =
          _cities.firstWhere((element) => element['id'] == id);
      _nameController.text = existingCity['name'];
      _latitudeController.value = existingCity['latitude'];
      _longitudeController.value = existingCity['longitude'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // Isso vai prevenir que o teclado cubra os campos
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Nome da cidade'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _latitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: 'Latitude'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _latitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) =>  _showForm(null),
                    decoration: const InputDecoration(hintText: 'Longitude'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Registra uma nova cidade
                      if (id == null) {
                        await _addCity();
                      }

                      if (id != null) {
                        await _updateCity(id);
                      }
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

// Insere uma cidade
  Future<void> _addCity() async {
    await CityRepository.createCity(_nameController.text, _latitudeController.text as Double?, _longitudeController.text as Double?);
    _refreshCities();
  }

  // Atualiza uma cidade cadastrada
  Future<void> _updateCity(int id) async {
    await CityRepository.updateCity(
        id, _nameController.text, _latitudeController.text as Double?, _longitudeController.text as Double?);
    _refreshCities();
  }

  // Descadastra uma cidade
  void _deleteCity(int id) async {
    await CityRepository.deleteCity(id);
    _refreshCities();
  }

  @override
  Widget build(BuildContext context) {
    // CityRepository.db();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidade cadastradas'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _cities.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_cities[index]['name']),
                    subtitle: Text(_cities[index]['latitude']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showForm(_cities[index]['id']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteCity(_cities[index]['id']),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}