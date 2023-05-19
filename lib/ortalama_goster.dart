
import 'package:flutter/material.dart';

class OrtalamaGoster extends StatelessWidget {

  final double ortalama;
  final int dersSayisi;

  OrtalamaGoster({required this.ortalama, required this.dersSayisi});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(dersSayisi > 0 ? "$dersSayisi Adet Ders Girildi" :  "Dersi Seciniz ", style: TextStyle(fontSize: 16,color: Colors.pink.shade500,fontWeight: FontWeight.bold),),
        ),
        
        Text(ortalama >= 0 ? " ${ortalama.toStringAsFixed(3)}" : "0.0",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink.shade500,fontSize: 55),),

        Text("Ortalama ", style: TextStyle(fontSize: 16,color: Colors.pink.shade500,fontWeight: FontWeight.bold),)

      ],
    );
  }
}
