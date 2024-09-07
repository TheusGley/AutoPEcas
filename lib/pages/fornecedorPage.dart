import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../def/bd_con.dart';
import 'homePage.dart';

class Fornecedorpage extends StatefulWidget {
  const Fornecedorpage({super.key});

  @override
  State<Fornecedorpage> createState() => _FornecedorpageState();
}

class _FornecedorpageState extends State<Fornecedorpage> {


  TextEditingController _controllerNome = TextEditingController();

  TextEditingController _controllerCNPJ= TextEditingController();

  TextEditingController _controllerEmail = TextEditingController();

  TextEditingController _controllerTelefone= TextEditingController();

  TextEditingController _controllerEndereco= TextEditingController();


  GlobalKey<FormState> _formKey  = GlobalKey<FormState>();

  Future<void> _cadFornecedor (String nome, String cnpj , String email, String tel , String endereco, ) async {

    int cnpj_format = int.parse(cnpj);
    int tel_format = int.parse(tel);

    Bd_con conn = Bd_con();
    conn.cadFornecedor("fornecedor", nome, cnpj_format, email,  tel_format, endereco,);
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
                        "Cadastre o Fornecedor",
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
                    onChanged: (value){
                      if (value.length >= 14)
                      {
                        setState(() {
                          _errorName = "Coloque apenas 14 caracteres " ;

                        });

                      }
                      else {
                        if (_errorName != null) {
                          setState(() {
                            _errorName = null;
                          });
                        }
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(14),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    controller: _controllerCNPJ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: " CNPJ ",
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
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorText: _errorName,
                      labelText: " Email",
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
                  child: TextFormField(
                    controller: _controllerTelefone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: " Telefone",
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
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _controllerEndereco,
                    decoration: InputDecoration(
                      errorText: _errorText,
                      labelText: "Endereco",
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
                      _cadFornecedor(
                          _controllerNome.text,
                          _controllerCNPJ.text,
                          _controllerEmail.text,
                          _controllerTelefone.text,
                          _controllerEndereco.text);
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


