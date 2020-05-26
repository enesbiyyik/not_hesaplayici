import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
        child: Icon(Icons.add),),
      body: uygulamaGovdesi(),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              color: Colors.pink.shade200,
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onSaved: (kaydedilecek){
                        dersAdi = kaydedilecek;
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
                          child: DropdownButton<int>(items: dersKredileri(), value: dersKredi, onChanged: (secilenKredi){
                            setState(() {
                              dersKredi = secilenKredi;
                            });
                          },),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        Container(
                          child: DropdownButton<double>(items: dersHarfDegerleri(), value: dersHarfDegeri , onChanged: (secilenHarf){
                            setState(() {
                              dersHarfDegeri = secilenHarf;
                            });
                          }),
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
          ),
          Expanded(
            child: Container(
              color: Colors.green.shade200,
              child: ListView.builder(itemBuilder: , itemCount: ,),
            ),
          ),
        ],
      ),
    );
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

}

class Ders {
  String ad;
  int kredi;
  double harf;

  Ders(this.ad, );
}
