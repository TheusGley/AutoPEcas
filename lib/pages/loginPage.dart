import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'homePage.dart';


class loginPage extends StatelessWidget {
   loginPage({super.key});

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

        ),
      ),
      body:_LoginPage(context),
    );


  }
  Widget _LoginPage(context) {
    return
      Material(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 40),
                child: Container(
                  width: 300,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SizedBox(
                        child: Icon(Icons.person, size: 200),
                      ),
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0),
                child:
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1
                    )
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          // controller: _controllerName,
                          decoration: InputDecoration(
                            labelText: "Email ou Usuario",
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child:
                          TextField(
                            // obscureText: _obscureText,
                            // controller: _controllerPass,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: "Senha ",
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    // setState(() {
                                    //   _obscureText =
                                    //   !_obscureText; // Alterna a visibilidade
                                    // });
                                  }),
                            ),
                          )

                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20.0, left: 20.0, right: 20.0, bottom: 35.0),
                child: ElevatedButton(onPressed: () {
                  // _fetchUserData(_controllerName.text, _controllerPass.text);
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage())
                  );
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  ),
                  child: Text(
                      "Entrar", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  )
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed:() {
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => Registerpage(),
              //     //   ),
              //     // );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.black,
              //   ),
              //   child: Text("Registre-se",
              //     style: TextStyle(
              //       color: Colors.blue,
              //       fontSize: 20,
              //     ),),
              // )
            ],
          ),
        ),
      );
  }

}
