import'package:flutter/material.dart';

import 'package:postgres/postgres.dart';
//
// Future<void> connect() async {
//
// }


class Bd_con {




  Future<List<List<dynamic>>> authentication () async {
    final List<List<dynamic>> response = await select_all(
        'usuario, senha', 'vendedor');


    return response ;
  }



    Future<List<List<dynamic>>> select (String column, String table, String restricao, String obj) async {
    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
        settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    print('Conexão estabelecida');


    final result = await conn.execute(Sql.named('SELECT $column FROM $table WHERE $restricao=$obj'));

    await conn.close();

    return result;


  }

  Future<void> connectToDatabase() async {
    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',      // Endereço do host
        port: 5432,             // Porta do PostgreSQL
        database: 'postgres',   // Nome do banco de dados
        username: 'postgres',       // Nome de usuário
        password: 'admin',       // Senha
      ),
      settings: ConnectionSettings(
        sslMode: SslMode.disable, // Ajuste se necessário
      ),
    );

    try {
      print('Conexão estabelecida com sucesso!');

      // Aqui você pode adicionar outras operações para testar a conexão

    } catch (e) {
      print('Erro ao conectar: $e');
    } finally {
      await conn.close(); // Fecha a conexão
    }
  }

  Future<List<List<dynamic>>> select_all(String column, String table) async {
    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Conexão estabelecida');

    // Executa a consulta SQL
    final result = await conn.execute(Sql.named('SELECT $column FROM $table'));

    print('Resultado da query: $result');

    await conn.close();

    // Retorna o resultado diretamente como uma lista de listas
    return result; // Cada linha é uma lista de valores
  }



  Future<bool>  cadColaboradores (String table , String nome , int cpf,String email, int tel,String login , String pass) async {

    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Conexão estabelecida');

    // Executa a consulta SQL
    final result = await conn.execute(
        'insert into $table (nome, cpf, email, telefone, usuario, senha) values (\'$nome\', \'$cpf\', \'$email\', \'$tel\', \'$login\', \'$pass\')'
    );

    print('Resultado da query: $result');

    await conn.close();

    // Retorna o resultado diretamente como uma lista de listas

    return true;
  }
  //Def para cadastro fornecedor ou cliente



  Future<bool>  cadastro (String table , String nome,) async {

    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Conexão estabelecida');

    // Executa a consulta SQL
    final result = await conn.execute(
        'insert into $table (descricao) values (\'$nome\')'
    );

    print('Resultado da query: $result');

    await conn.close();

    // Retorna o resultado diretamente como uma lista de listas

    return true;
  }


  Future<bool>  cadFornecedor (String table , String nome , int cnpj,String email, int tel,String endereco ) async {

    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Conexão estabelecida');

    // Executa a consulta SQL
    final result = await conn.execute(
        'insert into $table (nome, cnpj, email, telefone, endereco) values (\'$nome\', \'$cnpj\', \'$email\', \'$tel\', \'$endereco\')'
    );

    print('Resultado da query: $result');

    await conn.close();

    // Retorna o resultado diretamente como uma lista de listas

    return true;
  }

  Future<bool>  cadastroGeral (String table , String nome , int cpf,String email, int tel,String endereco , String placa) async {

    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Conexão estabelecida');

    // Executa a consulta SQL
    final result = await conn.execute(
        'insert into $table (nome, cpf, email, telefone, usuario, senha) values (\'$nome\', \'$cpf\', \'$email\', \'$tel\', \'$endereco\', \'$placa\')'
    );

    print('Resultado da query: $result');

    await conn.close();

    // Retorna o resultado diretamente como uma lista de listas

    return true;
  }


  Future<bool>  cadastroProduto (String table , String descricao, double preco_custo , double preco_venda, int estoque_atual , String id_fornecedor, String id_categoria) async {
    //
    final conn = await Connection.open(
      Endpoint(
        host: '192.168.100.4',
        port: 5432,
        database: 'autopecas',
        username: 'postgres',
        password: 'admin',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    print('Conexão estabelecida');

    // Executa a consulta SQL
    final result = await conn.execute(
        'INSERT INTO $table (descricao, preco_custo, preco_venda, estoque_atual, id_fornecedor, id_categoria) '
            'VALUES (\'$descricao\', \'$preco_custo\', \'$preco_venda\', \'$estoque_atual\', \'$id_fornecedor\', \'$id_categoria\')'
    );

    print('Resultado da query: $result');

    await conn.close();

    // Retorna o resultado diretamente como uma lista de listas

    return true;
  }



}

