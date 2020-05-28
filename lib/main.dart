import 'package:flutter/material.dart';
import 'dart:math' as rnd;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;

  List<Ders> tumDersler;

  var formKey = GlobalKey<FormState>();

  double ortalama = 0.0;

  int sayac = 0;

  @override
  void initState() {
    tumDersler = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(formKey.currentState.validate()) formKey.currentState.save();
      },
        child: Icon(Icons.add),),
      body: OrientationBuilder(builder: (context, orientation){
        if(orientation == Orientation.portrait) return uygulamaGovdesi();
        else return uygulamaGovdesiLandscape();
        },),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
            //color: Colors.pink.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (kaydedilecek){
                      dersAdi = kaydedilecek;
                      setState(() {
                        tumDersler.add(Ders(dersAdi, dersKredi, dersHarfDegeri, randomRenkOlustur()));
                        ortalama = 0;
                        ortalamayiHesapla();
                      });
                    },
                    validator: (girilenDeger){
                      if (girilenDeger.length > 0) return null;
                      else return "Ders Adı boş bırakılamaz";
                    },
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Ders Adını Giriniz",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(items: dersKredileri(), value: dersKredi, onChanged: (secilenKredi){
                            setState(() {
                              dersKredi = secilenKredi;
                            });
                          },),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(items: dersHarfDegerleri(), value: dersHarfDegeri , onChanged: (secilenHarf){
                            setState(() {
                              dersHarfDegeri = secilenHarf;
                            });
                          }),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            color: Colors.blueAccent,
            child: Center(child: Text("Ortalama: "+ortalama.toStringAsFixed(2) , style: TextStyle(fontSize: 36, color: Colors.white),),),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //color: Colors.green.shade200,
              child: ListView.builder(itemBuilder: _listeElemanlariniOlustur, itemCount: tumDersler.length ,),
            ),
          ),
        ],
      ),
    );
  }


  Widget uygulamaGovdesiLandscape() {

  }

  List<DropdownMenuItem<int>> dersKredileri() {
    List<DropdownMenuItem<int>> krediler = [];
    for(int i = 1; i <= 10; i++){
      krediler.add(DropdownMenuItem<int>(child: Text("$i Kredi", style: TextStyle(fontSize: 20),), value: i,));
    }
    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleri() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(child: Text(" AA", style: TextStyle(fontSize: 20),), value: 4,),);
    harfler.add(DropdownMenuItem(child: Text(" BA", style: TextStyle(fontSize: 20),), value: 3.5,),);
    harfler.add(DropdownMenuItem(child: Text(" BB", style: TextStyle(fontSize: 20),), value: 3,),);
    harfler.add(DropdownMenuItem(child: Text(" CB", style: TextStyle(fontSize: 20),), value: 2.5,),);
    harfler.add(DropdownMenuItem(child: Text(" CC", style: TextStyle(fontSize: 20),), value: 2,),);
    harfler.add(DropdownMenuItem(child: Text(" DC", style: TextStyle(fontSize: 20),), value: 1.5,),);
    harfler.add(DropdownMenuItem(child: Text(" DD", style: TextStyle(fontSize: 20),), value: 1,),);
    harfler.add(DropdownMenuItem(child: Text(" FF", style: TextStyle(fontSize: 20),), value: 0,),);

    return harfler;
  }


  Widget _listeElemanlariniOlustur(BuildContext context, int index) {

    sayac++;

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: tumDersler[index].renk),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: ListTile(
            trailing: Icon(Icons.chevron_right),
            leading: Icon(Icons.edit, color: tumDersler[index].renk,),
            title: Text(tumDersler[index].ad),
            subtitle: Text(tumDersler[index].kredi.toString()+" kredi ders not değeri: "+tumDersler[index].harf.toString()),
          ),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {

    double toplamNot = 0;
    double toplamKredi = 0;

    for(var oankiDers in tumDersler){
      var kredi = oankiDers.kredi;
      var harfDegeri = oankiDers.harf;

      toplamNot = toplamNot + (harfDegeri * kredi);
      toplamKredi = toplamKredi + kredi;

    }

    ortalama  = toplamNot / toplamKredi;

  }

  Color randomRenkOlustur() {
    return Color.fromARGB(255, rnd.Random().nextInt(255), rnd.Random().nextInt(255), rnd.Random().nextInt(255));
  }


}

class Ders {
  String ad;
  int kredi;
  double harf;
  Color renk;

  Ders(this.ad, this.kredi, this.harf, this.renk);
}
