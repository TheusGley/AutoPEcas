import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:autopecas/def/bd_con.dart';

class categoriaPage extends StatefulWidget {
   categoriaPage({super.key});

  @override
  State<categoriaPage> createState() => _categoriaPageState();
}


class _categoriaPageState extends State<categoriaPage> {
   late List<String> _categorias = [' '];
   late String _selectedValue ;
   late Map<String,dynamic> _produtos  = {};
   late String responseQuery  ;

   Future<bool>? _futureData;

   @override
   void initState() {
     super.initState();
     _futureData =_getData();
   }

   Future<bool> _getData() async {
     Bd_con connect = Bd_con();
     print("Iniciando requisição ao banco...");

     final List<List<dynamic>> response = await connect.select_all('*', 'categoria');
     List<String> formattedResponse = [];

     // Formatando a resposta para remover as chaves
     for (var row in response) {
       formattedResponse.add("${row[0]} - ${row[1]}");
     }

     print("Resposta formatada: $formattedResponse");

     setState(() {
       _categorias = formattedResponse; // Agora contém as strings formatadas
     });

     if (formattedResponse.isNotEmpty) {
       print("Dados recebidos com sucesso!");
       return true;
     } else {
       print("Nenhum dado encontrado.");
       return false;
     }
   }


   Future<bool> _getProdutos(String newValue) async{
     Bd_con connect = Bd_con();

     List<String> parts = newValue.split('-').map((e) => e.trim()).toList();

     // O primeiro valor é o que está antes da vírgula
     String idCategoria = parts[0];
     print(idCategoria);

       // Inicializa o mapa para evitar erros de null
       _produtos = {};

       // Map<String, dynamic> where = {'id_categoria': newValue};
       final List<List<dynamic>> produtoResponse = await connect.select('descricao, preco_venda', 'produto', 'id_categoria', idCategoria);

       // Verifica se obteve algum resultado
       if (produtoResponse.isEmpty) {
         print("Nenhuma categoria encontrada.");
         return false;
       }

       // Preenche o mapa _produtos
       for (var row in produtoResponse) {
         _produtos[row[0]] = row[1]; // Assume que row[0] é a descrição e row[1] o preço
       }

       print("Produtos carregados: $_produtos");

     setState(() {
       _futureData = Future.value(true);
     });

     return true;
     }
   @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
           Padding(padding: EdgeInsets.only(top:20, bottom: 20),
           child: Text("Categorias",style: TextStyle(
             fontSize: 28,
             color: Colors.white,
             fontStyle: FontStyle.italic,
             fontWeight: FontWeight.w700,
           ),),),
            DropdownMenu<String>(
              initialSelection: _categorias.first,
              onSelected: (String? newValue) {
                // This is called when the user selects an item.
                setState(() {
                  _selectedValue = newValue!;
                });

                _getProdutos(newValue!);
              },
              width: 230,
              menuHeight: 400,
              // menuStyle: MenuStyle(),
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              dropdownMenuEntries: _categorias
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                    value: value, label: value);
              }).toList(),
            ),
            FutureBuilder<bool>(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Exibir indicador de carregamento enquanto a conexão é estabelecida
                  return Padding(
                    padding: EdgeInsets.only(top: 200.0),
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  // Se houve um erro na consulta, exibir uma mensagem de erro
                  return Text("Erro ao buscar dados");
                }

                if (_produtos != null && _produtos.isNotEmpty) {
                  // Exibir os produtos quando a conexão for bem-sucedida
                  return Column(
                    children: [
                      for (var index = 0; index < _produtos.length; index++)
                        GestureDetector(
                          onTap: () {
                            // Código para navegação ou ações no clique
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.indigo,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Text(_produtos.keys.elementAt(index).toString(), // Nome do produto
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(_produtos.values.elementAt(index).toString(), // Preço fictício
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  // Caso nenhum dado seja encontrado
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo,
                      ),
                    child: SizedBox(
                      child: Text("Nenhum Produto encontrado"),
                    ),
                  ),
                  );
                }
              },
            )        ],
        ),
      ),
    );
  }
}


