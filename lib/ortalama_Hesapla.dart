
import 'package:flutter/material.dart';
import 'package:proje02/data_Helper.dart';
import 'package:proje02/dersler.dart';
import 'package:proje02/ortalama_goster.dart';

class OrtalamaHesapla extends StatefulWidget {

  @override
  State<OrtalamaHesapla> createState() => _OrtalamaHesaplaState();
}

class _OrtalamaHesaplaState extends State<OrtalamaHesapla> {

  List<Dersler> tumDersler = [];

  double secilen = 1;
  double secilenKredi = 1;
  String girilenDersAdi = 'Ders Adi Girilmemis';
  double krediDegeri = 1;
  double notDegeri = 4;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.numbers),
            onPressed: (){
            },
          )
        ],
        title: Center(
          child: Text("Dinamik Ortalama Hesaplama"),

        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                flex: 2,
                child: myForm(),
              ),
              Expanded(child: OrtalamaGoster(dersSayisi: tumDersler.length,ortalama: OrtalamaHesapla(),)),
            ],
          ),


          Expanded(
            child: tumDersler.length > 0

                ? ListView.builder(
              itemCount: tumDersler.length,

              itemBuilder: (context, index) => Dismissible( // saga kaydirinca dersi kaldirmak icin kullaniliyor bu "Dismissible"
                key: UniqueKey(), // listemize ekledigimiz elemena her birinden fakli birer keyler atanir.
                direction: DismissDirection.startToEnd, // yonunu belirlemedir bu.

                onDismissed: (a) {
                  setState(() { // setState ilgili widgetin buildini tetikler.

                    tumDersler.removeAt(index); // kullanici kaldirinca oanki indexte bulunan eleman silinir yani.

                  });
                },


                child: Padding(
                  padding: EdgeInsets.all(2),

                  child: Card(
                    child: ListTile(

                      title: Text(tumDersler[index].dersAdi),
                      subtitle: Text('${tumDersler[index].krediDegeri} Kredi, Not Degeri ${tumDersler[index].harfDegeri}'),

                      leading: CircleAvatar(
                        backgroundColor: Colors.pink.shade500,

                        child: Text('' + (tumDersler[index].krediDegeri *tumDersler[index].harfDegeri).toStringAsFixed(0)),

                      ),
                    ),
                  ),
                ),

              ),

            )

                : Container(
              margin: EdgeInsets.all(24),

              child: Align(
                alignment: Alignment.topCenter,

                child: Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: Center(
                    child: Text('Lutfen ders ekleyiniz',style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.pink.shade500)),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),

    );
  }




Widget  myForm() {

     return Form(
      key: formKey,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [

           Padding(
             padding: EdgeInsets.symmetric(horizontal: 8),
             child: _buildTextFormField(),
           ),
           SizedBox(height: 5,),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

               Expanded(
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8),
                   child: _buildHarfler(),
                 ),
               ),

               Expanded(
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 8),
                   child: _buildKrediler(),
                 ),
               ),

               IconButton(
                 icon: Icon(Icons.arrow_forward_ios,color: Colors.pink.shade500,),
                 onPressed: (){
                  if (formKey.currentState!.validate()) {
                     formKey.currentState!.save();

                     var eklenecekOlanDers=Dersler(girilenDersAdi, secilen, krediDegeri);
                     tumDersler.insert(0, eklenecekOlanDers);
                     OrtalamaHesapla();
                     setState(() {

                     });
                  }

                  else {

                  }
                 },
               ),

             ],
           ),


         ],
       ),
     );
  }



double OrtalamaHesapla() {

    double toplamNot=0;
    double toplamKredi=0;

    tumDersler.forEach((Dersler ders) {toplamNot=toplamNot + (ders.krediDegeri*ders.harfDegeri);
      toplamKredi=toplamKredi+ders.krediDegeri;
    });

    return toplamNot/toplamKredi;

}



 TextFormField _buildTextFormField() {

   return TextFormField(
   decoration: InputDecoration(
     hintText: "Geometri",
     hintStyle: TextStyle(color: Colors.white),

     border: OutlineInputBorder(
       borderRadius: BorderRadius.circular(24),
       borderSide: BorderSide(width: 0,style: BorderStyle.none),
     ),
     filled: true,
     fillColor: Colors.pink.shade500.withOpacity(0.6),
   ),

     onSaved: (ders){
       girilenDersAdi=ders!;
     },

     validator: (v) {
     if (v!.length<=0) {
       return "Ders Adı BOŞ Gecilemez";
     }
     else {
       return null;
     }
     },
   );

  }



  Widget _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: Colors.pink.shade500,
        borderRadius: BorderRadius.circular(24),
      ),



      child: DropdownButton<double>(
        value: secilen,
        iconEnabledColor: Colors.pink.shade500,
        elevation: 16,
        items: DataHelper.tumDersHarfleri(),
        underline: Container(), // altataki cizginin gitmesi icindir bu.

        onChanged: (dd) {

          setState(() {
            secilen = dd!;
            print(dd);
          }

          );
        },

      ),
    );

  }




  Widget _buildKrediler() {

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: Colors.pink.shade500,
        borderRadius: BorderRadius.circular(24),
      ),



      child: DropdownButton<double>(
        value: secilenKredi,
        iconEnabledColor: Colors.pink.shade500,
        elevation: 16,
        items: DataHelper.tumKrediler(),
        underline: Container(),

        onChanged: (dd) {
          setState(() {
            secilenKredi = dd!;
            print(dd);
          });
        },

      ),
    );

  }


}
