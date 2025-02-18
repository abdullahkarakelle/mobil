import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'DatabaseHelper.dart';

void main() {
  runApp(MaterialApp(
    home: RandevuSayfasi(),
  ));
}

class RandevuSayfasi extends StatefulWidget {
  @override
  _RandevuSayfasiState createState() => _RandevuSayfasiState();
}

class _RandevuSayfasiState extends State<RandevuSayfasi> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late int _uyeId; // Üye ID'sini tutacak değişken
  List<String> _availableTimes = [
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay(hour: 10, minute: 0);

    _uyeId = 1;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      selectableDayPredicate: (DateTime date) {
        return date.weekday != DateTime.sunday;
      },
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _confirmAppointment(BuildContext context) {
    _saveAppointment(); // Randevuyu kaydet
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Randevu Al"),
          content: Text(
              "Randevunuz ${DateFormat('dd-MM-yyyy').format(_selectedDate)} tarihinde saat ${_selectedTime.format(context)} olarak alınmıştır."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveAppointment() async {
    String tarih = DateFormat('yyyy-MM-dd').format(_selectedDate);
    String saat = _selectedTime.format(context);

    Map<String, dynamic> randevu = {
      'UyeId': _uyeId,
      'Tarih': tarih,
      'Saat': saat,
    };

    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    await databaseHelper.insertRandevu(randevu);
  }

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
              'Randevu Al',
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/anakuaforr.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
              children: [
          Positioned.fill(
          child: Container(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      Center(
        child: Container(
            width: 250,
            height: 400
          ,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tarih Seçiniz:',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
              ),
              SizedBox(height: 10),
              Text(
                'Saat Seçiniz:',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(height: 10),
              DropdownButton<TimeOfDay>(
                value: _selectedTime,
                onChanged: (TimeOfDay? value) {
                  if (value != null) {
                    setState(() {
                      _selectedTime = value;
                    });
                  }
                },
                items: _availableTimes.map((String time) {
                  final parts = time.split(':');
                  final hour = int.parse(parts[0]);
                  final minute = int.parse(parts[1]);
                  return DropdownMenuItem<TimeOfDay>(
                    value: TimeOfDay(hour: hour, minute: minute),
                    child: Text(time),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _confirmAppointment(context),
                child: Text(
                  'Randevu Al',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
              ],
          ),
        ),
      ),
    );
  }
}
