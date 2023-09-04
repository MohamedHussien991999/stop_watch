import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stop_watch/modules/component/component.dart';

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isActive = false;
  Timer? _timer;
  final List<String> _recordedTimes = [];

  void _startTimer() {
    if (_isActive) return;

    _isActive = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds < 59) {
          _seconds++;
        } else {
          _seconds = 0;
          if (_minutes < 59) {
            _minutes++;
          } else {
            _minutes = 0;
            _hours++;
          }
        }
      });
    });
  }

  void _pauseTimer() {
    _isActive = false;
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _isActive = false;
      _timer!.cancel();
      if (_hours == 0 && _minutes == 0 && _seconds == 0) return;
      String recordedTime =
          '${_formatTime(_hours)} : ${_formatTime(_minutes)} : ${_formatTime(_seconds)}';
      setState(() {
        _recordedTimes.add(recordedTime);
        _hours = 0;
        _minutes = 0;
        _seconds = 0;
        _recordedTimes;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int timeValue) {
    return timeValue.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.04),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Stop Watch',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${_formatTime(_hours)} ',
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Hours',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${_formatTime(_minutes)} ',
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Minutes',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${_formatTime(_seconds)} ',
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Seconds',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (_hours == 0 &&
                                _minutes == 0 &&
                                _seconds == 0 &&
                                !_isActive)
                            ? defaultButton(_startTimer, 'Start  ')
                            : defaultButton(_startTimer, 'Resume  '),
                        defaultButton(_pauseTimer, 'Pause '),
                        defaultButton(_resetTimer, 'Reset '),
                        defaultButton(_stopTimer, 'Stop '),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Recorded Times',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: _recordedTimes.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        toRoman(index + 1),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      SizedBox(width: index == 9 ? 10 : 20),
                                      Text(
                                        _recordedTimes[index],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color:
                                                Color.fromARGB(255, 15, 10, 1)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: _recordedTimes.length,
                              shrinkWrap: true,
                            )
                          : SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'No Records Yet',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                            )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
