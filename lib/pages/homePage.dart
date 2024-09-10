import 'package:autopecas/pages/clientesPage.dart';
import 'package:autopecas/pages/colaboradoresPage.dart';
import 'package:autopecas/pages/fornecedorPage.dart';
import 'package:autopecas/pages/produtosPage.dart';
import 'package:autopecas/pages/updateItem.dart';
import 'package:autopecas/pages/update.dart';
import 'package:autopecas/pages/vendasPage.dart';
import 'package:autopecas/widgets/custom_drawer.dart';
import 'package:autopecas/pages/addCategoriaPage.dart';
import 'package:autopecas/pages/vendasPage.dart';
import 'package:flutter/material.dart';
import 'categoriaPage.dart';
import 'delete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<bool> _getData() async {
    await Future.delayed(Duration(seconds: 5));
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      "Carregando",
                      style: TextStyle(
                        color: Colors.black, fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              default :
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text(
                      "Erro ao Carregar Dados",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                else {
                  return _homePage(context);
                }
            }
          }


      ),
    );
  }
  }

PageController _pageController = PageController();


Widget _homePage(BuildContext context){
    return PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            appBar:AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
              title:
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 100)),
                  Text('Auto',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
                  Text('Sport',style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600
                  ),)
                ],

              ),
            ),
            backgroundColor: Colors.black,
            body: categoriaPage(),
            drawer: CustomDrawer(_pageController),
          ),
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],
//Fazer pagina de categoria onde sers cadastradas as categorias
                ),
              ),
              drawer: CustomDrawer(_pageController),
              backgroundColor: Colors.black,
              body: ColaboradoresPage(),
          ), // segunda Page
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              body:
              Container(
                  child:
                  ClientePage()

              )
          ),//terceira page
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              body:
              Container(
                  child:
                  ProdutosPage()

              )
          ),//quarta PAge
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              body:
              Container(
                  child:
                  Fornecedorpage()

              )
          ),//quinta page
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              body:
              Container(
                  child:
                  VendasPage()

              )
          ),
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
              drawer: CustomDrawer(_pageController),
              body:
              Container(
                child:
                addCategoriaPage(),

              )
          ),
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              body:
              Container(
                  child:
                  VendasPage(),

              )
          ),
          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              backgroundColor: Colors.black,

              body:
              Container(
                child:
                UpdateItem(),
              )
          ),          Scaffold(
              appBar:AppBar(
                backgroundColor: Colors.black,
                title:
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100)),
                    Text('Auto',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),),
                    Text('Sport',style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),)
                  ],

                ),
              ),
              drawer: CustomDrawer(_pageController),
              backgroundColor: Colors.black,

              body:
              Container(
                child:
                DeletePage(),
              )
          )





        ]);


  }



