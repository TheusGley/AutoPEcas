import 'package:flutter/material.dart';

import '../def/bd_con.dart';
import 'homePage.dart';


class addCategoriaPage extends StatefulWidget {
  const addCategoriaPage({super.key});

  @override
  State<addCategoriaPage> createState() => _addCategoriaPageState();
}

class _addCategoriaPageState extends State<addCategoriaPage> {

  TextEditingController _controllerNome = TextEditingController();

  GlobalKey<FormState> _formKey  = GlobalKey<FormState>();

  Future<void> _cadCategoria (String nome) async {

    Bd_con conn = Bd_con();
    conn.cadastro("categoria", nome);
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
                        "Cadastre a categoria",
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
                    keyboardType: TextInputType.name,
                    controller: _controllerNome,
                    decoration: InputDecoration(
                      labelText: " Nome ",
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
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.indigo,
                    fixedSize: Size(200, 50),
                  ),
                  onPressed: () {

                    try {
                      _cadCategoria(
                          _controllerNome.text);
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
              )
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
        title: Text('Ocorreu um erro  ' + e.toString(),
          style: TextStyle(
            color: Colors.lightBlueAccent,
          ),),
        content: Text(
            "Por favor tente novamente mais tarde "),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: ()  {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}


