import 'package:flutter/material.dart';

import '../def/bd_con.dart';
import 'homePage.dart';

class VendasPage extends StatefulWidget {
  const VendasPage({super.key});

  @override
  State<VendasPage> createState() => _VendasPageState();
}

GlobalKey<FormState> _formKey  = GlobalKey<FormState>();


TextEditingController _controllerValorTotal = TextEditingController();
TextEditingController _dateController = TextEditingController();


late List<String> _cliente = [' '];
late List<String> _formaPagamento = [' '];
late List<String> _vendedor= [' '];
late List<String> _status= ['Pago ', 'Andamento', 'Perdida'];
late DateTime? _selectedDate = DateTime.now();
late String _selectedCliente = _cliente.first;
late String _selectedFormaPag = _formaPagamento.first;
late String _selectedVendedor  = _vendedor.first;
late String _selectedstatus = _status.first;
List<String> InitialValue = [' '];




class _VendasPageState extends State<VendasPage> {

  @override
  void initState() {
    _getData();
  }


  Future<void> _cadVendas( DateTime data, String status,String valorTotal, String cliente,String pagamento, String vendedor) async {
    double valorTotalFormat = double.parse(valorTotal);

    List<String> parts = cliente.split('-').map((e) => e.trim()).toList();
    String clienteID = parts[0];

    List<String> parts2 = pagamento.split('-').map((e) => e.trim()).toList();
    String pagamentoID = parts2[0];

    List<String> parts3 = vendedor.split('-').map((e) => e.trim()).toList();
    String vendedorID = parts3[0];

    Bd_con conn = Bd_con();
    conn.cadVendas(
        "venda",
        data,
        valorTotalFormat,
        status,
        int.parse(clienteID),
        int.parse(pagamentoID),
        int.parse(vendedorID)
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),  // Define a data mínima
      lastDate: DateTime(2100),   // Define a data máxima
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        // Formata a data manualmente (yyyy-MM-dd)
        _dateController.text = "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }
  Future<bool> _getData() async {
    Bd_con connect = Bd_con();

    final List<List<dynamic>> responseCliente = await connect.select_all(
        '*', 'cliente');
    final List<List<dynamic>> responseFormaPag = await connect.select_all(
        '*', 'forma_pagamento');
    final List<List<dynamic>> responseVendedor = await connect.select_all(
        '*', 'vendedor');


    List<String> formattedCliente = [];
    List<String> formattedFormaPag = [];
    List<String> formattedVendedor = [];

    for (var row in responseCliente) {
      formattedCliente.add("${row[0]} - ${row[1]}");
    }
    for (var row in responseFormaPag) {
      formattedFormaPag.add("${row[0]} - ${row[1]}");
    }
    for (var row in responseVendedor) {
      formattedVendedor.add("${row[0]} - ${row[1]}");
    }


    print("Resposta formatada: $formattedCliente");
    print("Resposta formatada: $formattedFormaPag");
    print("Resposta formatada: $formattedVendedor");


    setState(() {
      _cliente = formattedCliente; // Agora contém so o IDs
      _formaPagamento = formattedFormaPag;
      _vendedor = formattedVendedor;
    });

    if ((formattedCliente.isNotEmpty) && (formattedFormaPag.isNotEmpty)) {
      print("Dados recebidos com sucesso!");
      return true;
    } else {
      print("Nenhum dado encontrado.");
      return false;
    }
  }


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
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: Text(
                        "Faça uma venda",
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
                    controller: _dateController,
                    decoration: InputDecoration(
                      iconColor: Colors.black,
                      icon: Icon(Icons.calendar_today),
                      labelText: "Selecione a data",
                    ),
                    readOnly: true,  // Impede que o usuário digite manualmente
                    onTap: () => _selectDate(context),  // Mostra o seletor de data
                  ),
                ),
              ),Padding(
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

                    keyboardType: TextInputType.number,
                    controller: _controllerValorTotal,
                    decoration: InputDecoration(
                      labelText: " Valor Total ",
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
                  child:
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
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
                    dropdownMenuEntries: _status
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
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
                    dropdownMenuEntries: _cliente
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
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
                    dropdownMenuEntries: _formaPagamento
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                  DropdownMenu<String>(
                    initialSelection: InitialValue.first,
                    onSelected: (String? newValue) {
                      // This is called when the user selects an item.
                      setState(() {
                        _selectedstatus = newValue!;
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
                    dropdownMenuEntries: _vendedor
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
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
                      _cadVendas(
                          _selectedDate!,
                          _selectedstatus,
                          _controllerValorTotal.text,
                          _selectedCliente,
                          _selectedFormaPag,
                          _selectedVendedor
                          );
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
