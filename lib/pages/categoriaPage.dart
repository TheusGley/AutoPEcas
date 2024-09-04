import 'package:flutter/material.dart';

class categoriaPage extends StatefulWidget {
   categoriaPage({super.key});

  @override
  State<categoriaPage> createState() => _categoriaPageState();
}

class _categoriaPageState extends State<categoriaPage> {
   final List<String> _categorias = <String>['Freios','outros'];
   late String _selectedValue ;


   Future<bool> _getData() async {
     await Future.delayed(Duration(seconds: 5));
     return true;
   }

   @override
  Widget build(BuildContext context) {
    return Container(
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
              //_getTimes(newValue!);
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
              future: _getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: EdgeInsets.only(top: 200.0),
                      child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.hasData!) {
                  return Column(children: [
                    for (var index = 0; index < 3; index++)
                      GestureDetector(
                        onTap: (){
                        /*  Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ServicoPage( id :index, snapshot:snapshot,))
                          );*/
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical:  15.0,horizontal: 10.0),
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
                                      Text('Capacete',
                                        textAlign: TextAlign.center, style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      Text('R\$ 140,00',
                                        textAlign: TextAlign.center, style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),)

                                    ],
                                  )



                                ],
                              ),
                            )
                        ),
                      ),
                   /* Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {  },
                        child: const Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),*/
                  ]);
                } else {
                  return SizedBox(
                    child: Text("Nenhum Produto encontrado"),
                  );
                }
              })
        ],
      ),
    );
  }
}
