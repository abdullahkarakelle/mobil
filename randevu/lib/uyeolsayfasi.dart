import 'package:flutter/material.dart';
import 'main.dart';
import 'DatabaseHelper.dart';

class UyeOlSayfasi extends StatelessWidget {
  final TextEditingController kullaniciAdiKontrol = TextEditingController();
  final TextEditingController sifreKontrol = TextEditingController();
  final TextEditingController telefonNumarasiKontrol = TextEditingController();

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
              'Üye Ol',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text(
                'Anasayfa',
                style: TextStyle(color: Colors.black),
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/images/resim.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Üye Ol',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: kullaniciAdiKontrol,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: sifreKontrol,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: telefonNumarasiKontrol,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Telefon Numarası',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _veritabaniKayitEkle(context);
                    },
                    child: Text('Üye Ol'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _veritabaniKayitEkle(BuildContext context) async {
    String kullaniciAdi = kullaniciAdiKontrol.text;
    String sifre = sifreKontrol.text;
    String telefonNumarasi = telefonNumarasiKontrol.text;

    if (kullaniciAdi.isEmpty || sifre.isEmpty || telefonNumarasi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen tüm alanları doldurun')),
      );
      return;
    }

    try {
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      Map<String, dynamic> row = {
        DatabaseHelper.columnKullaniciAdi: kullaniciAdi,
        DatabaseHelper.columnSifre: sifre,
        DatabaseHelper.columnTelefonNumarasi: telefonNumarasi
      };
      int id = await databaseHelper.insertUye(row);
      print('Inserted row id: $id');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarılı')),
      );
    } catch (e) {
      print('Kayıt hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt sırasında bir hata oluştu: $e')),
      );
    }
  }
}
