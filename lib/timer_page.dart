import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});
  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  int _start = 0;
  Timer? _timer;
  final TextEditingController _controller = TextEditingController();

  void startTimer() {
    setState(() {
      _start = _controller.text.isNotEmpty ? int.tryParse(_controller.text) ?? 0 : 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Waktu Habis!'),
            content: const Text('Timer telah selesai.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  void resetTimer() {
    setState(() {
      _start = 0;
      _controller.clear();
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            color: Colors.white.withValues(
              red: 1.0,
              green: 1.0,
              blue: 1.0,
              alpha: 0.8,
            ),
            elevation: 8,
            margin: const EdgeInsets.all(16),
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Masukkan Waktu (detik):',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Contoh: 60',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Waktu Tersisa:',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    Text(
                      '$_start detik',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: startTimer,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text('Mulai Timer'),
                        ),
                        ElevatedButton(
                          onPressed: resetTimer,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text('Reset Timer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
