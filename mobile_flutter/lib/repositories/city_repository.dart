import 'package:mobile_flutter/components/mysql.dart';
import 'package:mobile_flutter/models/city_model.dart';

class CityRepository {
  
  static Future<void> createTables() async {
    // Cria uma tabela
    // await mysql.conn.query(
    //   'CREATE TABLE cities (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(64), latitude double precision(10,7), longitude double precision(10,7))'
    // );
  }

  // Lê todas as cidades
  Future<List<CityModel>> getCities() async {
    print('Entrou em leitura de todos');
    var db = Mysql();
    String sql = 'select * from cities;';
    final List<CityModel> myCities = [];
    await db.getConnection().then((conn) async {
      await conn.query(sql).then((results) {
        for (var res in results) {
          final CityModel myCity = CityModel(
            cityId: res['id'],
            name: res['name'].toString(),
            latitude: res['latitude'],
            longitude: res['longitude']
          );
          myCities.add(myCity);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      // conn.close();
    });

  return myCities;
}

  // Lê uma única cidade por id
  // Não foi utilizado esse método neste aplicativo, mas deixei aqui para uso posterior
  Future<CityModel> getCity(int id) async {
    var db = Mysql();
    final List<CityModel> myCities = [];
    String sql = 'select * from cities where id = ?;';
    await db.getConnection().then((conn) async {
      await conn.query(sql, [id]).then((result) {
        for (var res in result) {
          final CityModel myCity = CityModel(
            cityId: res['id'],
            name: res['name'].toString(),
            latitude: res['latitude'],
            longitude: res['longitude']
          );
          myCities.add(myCity);
          return myCity;
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      // conn.close();
    });
    return myCities.first;
  }

  // Atualiza uma cidade por id
  Future<CityModel> updateCity(int id, String name, double latitude, double longitude) async {
    final db = Mysql();
  //  print(cityId);
    var result = await db.getConnection().then(
      (conn) async {
        await conn.query(
            'update cities set name =? , latitude =? , longitude =? where id =?',
            [name, latitude, longitude, id]);
        //await conn.close();
      },
    );
    return CityModel(cityId: result.id, name: name, latitude: latitude, longitude: longitude);
  }

  // Delete uma cidade
  Future<void> deleteCity(int id) async {
    final db = Mysql();
    print('Entrou em deleteCity');
    await db.getConnection().then((conn) async {
      await conn
          .query('delete from cities where id=?', [id]);
      // conn.close();
    }).onError((error, stackTrace) {
      print(error);
      return null;
    });
  }

  // Cria uma cidade
  Future<CityModel> createCity(String name, double latitude, double longitude) async {
    final db = Mysql();
    print('Entrou em createCity');
    var result = await db.getConnection().then(
      (conn) async {
        await conn.query(
            'insert into cities (name, latitude, longitude) values (?, ?, ?)',
            [name, latitude, longitude]);
        // //await conn.close();
      },
    );
    print(result);
    return CityModel(cityId: result.insertId, name: name, latitude: latitude, longitude: longitude);
  }
}