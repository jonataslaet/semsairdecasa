import 'package:flutter/material.dart';
import 'package:mobile_flutter/controllers/google_maps_controller.dart';
import 'package:mysql_client/mysql_client.dart';

class CityListController extends StatefulWidget {
  const CityListController({Key? key}) : super(key: key);

  @override
  State<CityListController> createState() => _CityListControllerState();
}

class _CityListControllerState extends State<CityListController> {

  Future<void> _createAndManageDatabase(List<String> arguments) async {
    
    final conn = await MySQLConnection.createConnection(
        //Os dados abaixo são os setados no docker-compose.yml
        host: '192.168.48.1', //Esse IP deve ser o IPv4 local
        port: 3306,
        userName: 'laet',
        databaseName: 'dblaet',
        password: 'laet273');

    await conn.connect();

    print("Conexão com o banco realizada com sucesso.");
    print('Criando tabela de cidade...');

    await conn.execute(
      'CREATE TABLE cities (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(64), latitude double precision(10,7), longitude double precision(10,7))');

    print('Tabela criada.');
    print('Inserido cidade...');

    var result  = await conn.execute(
      "INSERT INTO cities (name, latitude, longitude) VALUES (:name, :latitude, :longitude)",
      {
        "name": 'Teresina',
        "latitude": -5.0892,
        "longitude": -42.8016,
      },
    );

    print('Cidade inserida, seu ID é: ${result.affectedRows}');
    print('Fechando conexão com o banco...');
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    _createAndManageDatabase(['']);
    return const GoogleMapsController();
  }
}