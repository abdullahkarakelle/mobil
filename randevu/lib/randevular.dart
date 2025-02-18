import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';

class Randevular extends StatefulWidget {
  @override
  _RandevularState createState() => _RandevularState();
}

class _RandevularState extends State<Randevular> {
  late Future<List<Map<String, dynamic>>> _uyelerFuture;

  @override
  void initState() {
    super.initState();
    _refreshUyelerListesi();
  }

  Future<void> _refreshUyelerListesi() async {
    setState(() {
      _uyelerFuture = DatabaseHelper.instance.queryAllUye();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Üyeler',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Üye Listesi',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _uyelerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Veriler alınırken bir hata oluştu.'),
                    );
                  } else {
                    List<Map<String, dynamic>> uyeler = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: uyeler.length,
                      itemBuilder: (context, index) {
                        return _buildUyeListeSatiri(uyeler[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUyeListeSatiri(Map<String, dynamic> uye) {
    return ListTile(
      title: Text(uye['KullaniciAdi']),
      subtitle: Text('Şifre: ${uye['Sifre']}, Telefon: ${uye['TelefonNumarasi']}'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await _uyeSil(uye['Id']);
          await _refreshUyelerListesi();
        },
      ),
      onTap: () {
        _showUyeDuzenleDialog(context, uye);
      },
    );
  }

  Future<void> _uyeSil(int uyeId) async {
    await DatabaseHelper.instance.deleteUye(uyeId);
  }

  Future<void> _showUyeDuzenleDialog(BuildContext context, Map<String, dynamic> uye) async {
    TextEditingController kullaniciAdiController = TextEditingController(text: uye['KullaniciAdi']);
    TextEditingController sifreController = TextEditingController(text: uye['Sifre']);
    TextEditingController telefonController = TextEditingController(text: uye['TelefonNumarasi']);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Üye Düzenle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: kullaniciAdiController,
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
              ),
              TextField(
                controller: sifreController,
                decoration: InputDecoration(labelText: 'Şifre'),
              ),
              TextField(
                controller: telefonController,
                decoration: InputDecoration(labelText: 'Telefon Numarası'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                await _uyeGuncelle(uye['Id'], kullaniciAdiController.text, sifreController.text, telefonController.text);
                await _refreshUyelerListesi();
                Navigator.of(context).pop();
              },
              child: Text('Kaydet'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uyeGuncelle(int uyeId, String kullaniciAdi, String sifre, String telefon) async {
    await DatabaseHelper.instance.updateUye(uyeId, kullaniciAdi, sifre, telefon);
  }
}
