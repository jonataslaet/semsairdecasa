import 'package:mysql1/mysql1.dart';

class Mysql {
  /*
  Os dados abaixo são referentes ao banco de dados.
  Esses dados devem ser EXATAMENTE OS MESMOS setados ao se criar o banco de dados.
  Para essa criação foi utilizado o docker, por meio do arquivo docker-compose.yml,
  então EXATAMENTE OS MESMOS dados a seguir estão setados nesse arquivo docker-compose.yml
  */
  static String host = '192.168.48.1'; //Este é meu endereço IPv4 local (se o seu for diferente, altere aqui e no arquivo docker-compose.yml)
  static int port = 3306;
  static String db = 'dblaet';
  static String user = 'laet';
  static String password = 'laet273';

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }

}