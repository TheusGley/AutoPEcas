import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../def/bd_con.dart';
import 'homePage.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {

  TextEditingController _controllerDescricao = TextEditingController();

  TextEditingController _controllerPrecoCusto= TextEditingController();

  TextEditingController _controllerPrecoVenda= TextEditingController();

  TextEditingController _controllerEstoque= TextEditingController();

  late List<String> _categorias = [' '];
  late List<String> _fornecedor = [' '];
  late String _selectedCategorias = _categorias.first;
  late String _selectedFornecedor  = _fornecedor.first;
  late Map<String,dynamic> _produtos  = {};
  late String responseQuery  ;
  late String error_message ;



  GlobalKey<FormState> _formKey  = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    _getData();
  }

  Future<bool> _getData() async {
    Bd_con connect = Bd_con();

    final List<List<dynamic>> responseCategoria = await connect.select_all('*', 'categoria');
    final List<List<dynamic>> responseFornecedor = await connect.select_all('*', 'fornecedor');

    List<String> formattedCategoria = [];
    List<String> formattedFornecedor = [];

    // Formatando a resposta para remover as chaves
    for (var row in responseCategoria) {
      formattedCategoria.add("${row[0]} - ${row[1]}");
    }
    for (var row in responseFornecedor) {
      formattedFornecedor.add("${row[0]} - ${row[1]}");
    }


    print("Resposta formatada: $formattedCategoria");
    print("Resposta formatada: $formattedFornecedor");

    setState(() {
      _categorias = formattedCategoria; // Agora contém as strings formatadas
      _fornecedor = formattedFornecedor; // Agora contém as strings formatadas

    });

    if( (formattedCategoria.isNotEmpty) && (formattedFornecedor.isNotEmpty)){
      print("Dados recebidos com sucesso!");
      return true;
    } else {
      print("Nenhum dado encontrado.");
      return false;
    }
  }



  Future<bool> _cadProdutos (String descricao, String preco_custo , String preco_venda, String estoque_atual , String id_fornecedo, String id_categoria, ) async {
    //
    int  estoque_format = int.parse(estoque_atual);
    double preco_custo_format = double.parse(preco_custo);
    double preco_venda_format = double.parse(preco_venda);

    List<String> parts = id_categoria.split('-').map((e) => e.trim()).toList();
    String idCategoria = parts[0];

    List<String> partsFornecedor = id_fornecedo.split('-').map((e) => e.trim()).toList();
    String idFornecedor = partsFornecedor[0];
    print(idCategoria + idFornecedor);


    Bd_con conn = Bd_con();
    try {
      conn.cadastroProduto(
          "produto",
          descricao,
          preco_custo_format,
          preco_venda_format,
          estoque_format,
          idFornecedor,
          idCategoria
      );
      return true ;

    }
    catch (e) {
      setState(() {
        error_message = e.toString();

      });
      return false ;

    }
  }


  String? _errorText ;
  String?  _errorName ;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.indigo,
                        width: 3,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      child: Text(
                        "Cadastre de Produto",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child:
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),

                    ],
                    keyboardType: TextInputType.name,
                    controller: _controllerDescricao,
                    decoration: InputDecoration(
                      labelText: " Descrição ",
                      labelStyle: TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child: TextFormField(
                    onChanged:(value) {},
                    controller: _controllerPrecoCusto,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: "Valor de Custo",
                      labelStyle: TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child:
                  TextFormField(
                    controller: _controllerPrecoVenda,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: " Valor de Venda",
                      labelStyle: TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Container(
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 3,
                    ),
                  ),
                  child:
                  TextFormField(
                    controller: _controllerEstoque,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: "Quantidade no estoque",
                      labelStyle: TextStyle(color: Colors.black),
                      border: null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top:20)),
              DropdownMenu<String>(
                initialSelection: _categorias.isNotEmpty ? _categorias.first : null,
                onSelected: (String? newValue) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedCategorias = newValue!;
                  });
                },
                width: 280,
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
              Padding(padding: EdgeInsets.only(top:20)),
              DropdownMenu<String>(
                initialSelection:  _fornecedor.isNotEmpty ? _fornecedor.first : null,
                onSelected: (String? newValue) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedFornecedor = newValue!;
                  });
                },
                width: 280,
                menuHeight: 400,
                // menuStyle: MenuStyle(),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                dropdownMenuEntries: _fornecedor
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                      value: value, label: value);
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.indigo,
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: () {
                    try {
                      _cadProdutos(
                          _controllerDescricao.text,
                          _controllerPrecoCusto.text,
                          _controllerPrecoVenda.text,
                          _controllerEstoque.text,
                          _selectedCategorias,
                          _selectedFornecedor);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(), // Substitua com o widget da nova página
                        ),
                      );
                    }
                    catch (e) {
                      showCancel(context, e);

                    }
                  },
                  child: Text("Enviar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      )),
                ),
              ),
            ]),
          ),
        ),
      );
  }
}
void showCancel(BuildContext context, Object e ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ocorreu um erro' + e.toString(),
          style: TextStyle(
            color: Colors.lightBlueAccent,
          ),),
        content: Text(
            "Por favor tente novamente mais tarde "),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: ()  {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}


