import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  void _recuperarPreco () async {

    var url = Uri.parse("https://blockchain.info/pt/ticker");

    var response = await http.get(url);

       if (response.statusCode == 200) {
         Map<String, dynamic> retorno = json.decode( response.body );

        //  print("Resultado: ${retorno['BRL']['buy']}");

        setState(() {
          _preco = "${retorno['BRL']['buy']}";
        });

       }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(bottom: 30, top: 30),
                child: Text("R\$ " + _preco, style: TextStyle(fontSize: 35.0),),
                ),              
              ElevatedButton(
                onPressed: _recuperarPreco, 
                child: Text("Verificar", style: TextStyle(fontSize: 20),),  
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange, 
                  onPrimary: Colors.white, 
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),                
                  ), 
                             
              ),
            ],
          ),
        ),
      ),
    );
  }
}