import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/city_model.dart';
import 'package:mobile_flutter/repositories/city_repository.dart';

class CityListController extends StatefulWidget {
  const CityListController({Key? key}) : super(key: key);

  @override
  State<CityListController> createState() => _CityListControllerState();
}

class _CityListControllerState extends State<CityListController> {
  final cityRepository = CityRepository();

  // Lista de cidades, inicialmente vazia
  List<CityModel> _cities
  = [
    // CityModel(cityId: 1, name: 'Recife', latitude: -8.0500, longitude: -34.9000)
  ];

  bool _isLoading = true;
  // Esse método é utilizado para pegar as cidades cadastradas no banco de dados
  void _loadCities() async {
    final data = await cityRepository.getCities();
    setState(() {
      // _cities.addAll(data); //Usar este apenas quando estiver testando acrescentando à cidade já setada acima
      _cities = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCities(); // Carregando as cidades cadastradas quando a aplicação inicia
  }
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  // Esse método será executado quando for pressionado o botão de submissão de formulário
  _openCityForm(int? id) async {
    if (id != null) {
      // Se o id não for nulo, é uma submissão de edição, e busca a cidade existente
      final existingCity = _cities.firstWhere((element) => element.cityId == id);

      // Preenche os campos com os valores da cidade já existente
      _nameController.text = existingCity.name;
      _latitudeController.text = existingCity.latitude.toString();
      _longitudeController.text = existingCity.longitude.toString();
    }
    // Mostra o formulário
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_){
        // return CityForm(_submitCityForm); Posteriormente, vai substituir todo o conteúdo do return logo abaixo
        return Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // Isso vai prevenir que o teclado cubra os campos
            bottom: MediaQuery.of(context).viewInsets.bottom + 240,
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
                controller: _longitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                
                decoration: const InputDecoration(hintText: 'Longitude'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed:
                () async {
                  await _submitCityForm(
                    id,
                    _nameController.text,
                    double.parse(_latitudeController.text),
                    double.parse(_longitudeController.text)
                  );
                },
                child: const Text('Submeter'),
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> _submitCityForm(int? id, String name, double valueLatitudeController, double valueLongitudeController) async {
    print('Entrou em submitForm');
    if (id == null) {
      await cityRepository.createCity(
        name, valueLatitudeController, valueLongitudeController
      );
    } else {
      await cityRepository.updateCity(
        id, name, valueLatitudeController, valueLongitudeController
      );
    }
    _loadCities();
  }

  // Descadastra uma cidade
  void _deleteCity(int id) async {
    await cityRepository.deleteCity(id);
    _loadCities();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      _loadCities();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidades cadastradas'),
      ),
      body:
        _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :
        ListView.builder(
              itemCount: _cities.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                    title: Text(_cities[index].name),
                    subtitle: Text(_cities[index].latitude.toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _openCityForm(_cities[index].cityId),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteCity(_cities[index].cityId),
                          ),
                        ],
                      ),
                    )
                  ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _openCityForm(null),
            ),
      
    );
  }
}