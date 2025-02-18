import 'package:flutter/material.dart';
import 'girissayfasi.dart';
import 'uyeolsayfasi.dart';
import 'yoneticigirisi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuaför Randevu Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final List<Map<String, dynamic>> hizmetler = [
    {'isim': 'Saç Kesimi', 'fiyat': 200, 'resim': 'sackesim.jpg'},
    {'isim': 'Saç Bakımı', 'fiyat': 100, 'resim': 'sacbakimi.jpg'},
    {'isim': 'Sakal Traşı', 'fiyat': 100, 'resim': 'sakaltrasi.jpg'},
    {'isim': 'Perma', 'fiyat': 500, 'resim': 'perma.jpg'},
    {'isim': 'Cilt Bakım', 'fiyat': 150, 'resim': 'ciltbakim.jpg'},
    {'isim': 'Ağda', 'fiyat': 150, 'resim': 'agda.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/assets/images/logo.jpg',
                width: 65,
                height: 65,
              ),
            ),
            Text(
              'Siyah İnci',// kuafor ismimiz
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                // Yönetici girişi butonuna basıldığında yoneticigirisi.dart sayfasına git
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YoneticiGirisi()),
                );
              },
              icon: Icon(
                Icons.login,
                size: 30,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[800]!,
                Colors.grey[200]!,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/images/fiat.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3 / 2 - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GirisSayfasi()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Giriş Yap',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UyeOlSayfasi()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Text(
                          'Üye Ol',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/hakkimizda.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hakkımızda',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Siyah İnci olarak,İstanbul un en gözde kuaförlerinden biri olup modern tasarım ve profesyonel ekibimiz ile müşteri memnuniyetini ön planda tutuyoruz.Salonumuz,son trendler ve kesim teknikleriyle her müşterinin kişisel tarzını ön plana çıkarıyor. Yüksek kaliteli ürünler ve son teknoloji ekipmanlarla donatılmış olan salonumuz,saç kesimi ve özel etkinlikler için saç tasarımı gibi geniş bir hizmet yelpazesi sunarak tarzınızı ön plana çıkarıyor.',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text(
                    'Hizmetlerimiz',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for (var hizmet in hizmetler)
                        Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/${hizmet['resim']}',
                              width: 100,
                              height: 100,
                            ),
                            Text(hizmet['isim']),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Fiyat Listesi',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hizmetler.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(hizmetler[index]['isim']),
                        trailing: Text('${hizmetler[index]['fiyat']} TL'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
