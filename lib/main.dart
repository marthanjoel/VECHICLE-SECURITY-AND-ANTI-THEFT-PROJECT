import 'dart:async';

import 'package:flutter/material.dart';
import 'services/arduino_serial_service.dart';

void main() {
  runApp(const AntiSecurityApp());
}

class AntiSecurityApp extends StatelessWidget {
  const AntiSecurityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ANTI SECURITY APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const SecurityHomePage(),
    );
  }
}

class SecurityHomePage extends StatefulWidget {
  const SecurityHomePage({super.key});

  @override
  State<SecurityHomePage> createState() =>
      _SecurityHomePageState();
}

class _SecurityHomePageState extends State<SecurityHomePage> {
  final ArduinoSerialService _arduino =
      ArduinoSerialService.instance;

  StreamSubscription<String>? _subscription;

  List<String> _ports = [];

  String? _selectedPort;

  bool _isConnected = false;
  bool _isArmed = false;
  bool _disturbanceDetected = false;
  bool _alarmOn = false;

  String _connectionStatus = 'NOT CONNECTED';

  @override
  void initState() {
    super.initState();

    _subscription = _arduino.dataStream.listen(
      _handleArduinoMessage,
    );

    _scanPorts();
  }

  Future<void> _scanPorts() async {
    try {
      final ports = await _arduino.scanPorts();

      if (!mounted) return;

      setState(() {
        _ports = ports;

        if (_ports.isNotEmpty) {
          _selectedPort = _ports.first;
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _connectionStatus = 'PORT SCAN ERROR';
      });
    }
  }

  Future<void> _connectArduino() async {
    if (_selectedPort == null) {
      await _scanPorts();

      if (_selectedPort == null) {
        if (!mounted) return;

        _showMessage(
          'No Arduino serial port found.',
        );

        return;
      }
    }

    setState(() {
      _connectionStatus = 'CONNECTING...';
    });

    final success = await _arduino.connect(
      _selectedPort!,
      baudRate: 9600,
    );

    if (!mounted) return;

    setState(() {
      _isConnected = success;
      _connectionStatus =
          success ? 'ARDUINO CONNECTED' : 'CONNECTION FAILED';
    });
  }

  Future<void> _disconnectArduino() async {
    await _arduino.disconnect();

    if (!mounted) return;

    setState(() {
      _isConnected = false;
      _connectionStatus = 'NOT CONNECTED';
      _isArmed = false;
      _disturbanceDetected = false;
      _alarmOn = false;
    });
  }

  void _handleArduinoMessage(String message) {
    if (!mounted) return;

    if (message == 'ARDUINO_CONNECTED') {
      setState(() {
        _isConnected = true;
        _connectionStatus = 'ARDUINO CONNECTED';
      });

      return;
    }

    if (message == 'ARDUINO_DISCONNECTED') {
      setState(() {
        _isConnected = false;
        _connectionStatus = 'ARDUINO DISCONNECTED';
      });

      return;
    }

    if (message == 'SECURITY:ARMED') {
      setState(() {
        _isArmed = true;
      });

      return;
    }

    if (message == 'SECURITY:ALERT') {
      setState(() {
        _isArmed = true;
        _disturbanceDetected = true;
      });

      return;
    }

    if (message == 'TILT:NORMAL') {
      setState(() {
        _disturbanceDetected = false;
      });

      return;
    }

    if (message == 'TILT:DETECTED') {
      setState(() {
        _disturbanceDetected = true;
      });

      return;
    }

    if (message == 'ALARM:ON') {
      setState(() {
        _alarmOn = true;
      });

      return;
    }

    if (message == 'ALARM:OFF') {
      setState(() {
        _alarmOn = false;
      });

      return;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Color get statusColor {
    if (!_isConnected) {
      return Colors.grey;
    }

    if (_disturbanceDetected || _alarmOn) {
      return Colors.red;
    }

    if (_isArmed) {
      return Colors.green;
    }

    return Colors.grey;
  }

  IconData get statusIcon {
    if (!_isConnected) {
      return Icons.usb_off;
    }

    if (_disturbanceDetected || _alarmOn) {
      return Icons.warning_amber_rounded;
    }

    if (_isArmed) {
      return Icons.security;
    }

    return Icons.lock_open;
  }

  String get systemStatus {
    if (!_isConnected) {
      return 'ARDUINO NOT CONNECTED';
    }

    if (_disturbanceDetected || _alarmOn) {
      return 'SECURITY ALERT!';
    }

    if (_isArmed) {
      return 'SYSTEM ARMED';
    }

    return 'SYSTEM DISARMED';
  }

  String get disturbanceStatus {
    if (_disturbanceDetected) {
      return 'TILT DETECTED!';
    }

    return 'NO DISTURBANCE';
  }

  String get alertMessage {
    if (_alarmOn) {
      return 'ALARM ACTIVE';
    }

    if (_disturbanceDetected) {
      return 'VEHICLE DISTURBANCE DETECTED!';
    }

    if (_isArmed) {
      return 'VEHICLE IS SECURE';
    }

    return 'SECURITY SYSTEM IS OFF';
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'ANTI SECURITY APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 10),

              Icon(
                Icons.directions_car,
                size: 90,
                color: Colors.blue.shade700,
              ),

              const SizedBox(height: 10),

              const Text(
                'VEHICLE ANTI-THEFT SYSTEM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // CONNECTION CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          _isConnected
                              ? Icons.usb
                              : Icons.usb_off,
                          color: _isConnected
                              ? Colors.green
                              : Colors.grey,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            _connectionStatus,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      value: _selectedPort,
                      decoration: const InputDecoration(
                        labelText: 'Arduino Port',
                        border: OutlineInputBorder(),
                      ),
                      items: _ports.map(
                        (port) {
                          return DropdownMenuItem<String>(
                            value: port,
                            child: Text(port),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPort = value;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _isConnected
                            ? _disconnectArduino
                            : _connectArduino,
                        icon: Icon(
                          _isConnected
                              ? Icons.link_off
                              : Icons.link,
                        ),
                        label: Text(
                          _isConnected
                              ? 'DISCONNECT ARDUINO'
                              : 'CONNECT ARDUINO',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // SECURITY CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'SECURITY INFORMATION',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        statusIcon,
                        size: 45,
                        color: statusColor,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      systemStatus,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),

                    const Divider(height: 35),

                    SecurityInfoRow(
                      icon: Icons.warning_amber_rounded,
                      title: 'Disturbance',
                      value: disturbanceStatus,
                      color: _disturbanceDetected
                          ? Colors.red
                          : Colors.green,
                    ),

                    const SizedBox(height: 18),

                    SecurityInfoRow(
                      icon: Icons.notifications_active,
                      title: 'Alert',
                      value: alertMessage,
                      color: statusColor,
                    ),

                    const SizedBox(height: 18),

                    SecurityInfoRow(
                      icon: Icons.shield,
                      title: 'Protection',
                      value: _isArmed
                          ? 'ACTIVE'
                          : 'INACTIVE',
                      color: _isArmed
                          ? Colors.green
                          : Colors.grey,
                    ),

                    const SizedBox(height: 18),

                    SecurityInfoRow(
                      icon: Icons.volume_up,
                      title: 'Alarm',
                      value: _alarmOn
                          ? 'ON'
                          : 'OFF',
                      color: _alarmOn
                          ? Colors.red
                          : Colors.green,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'The Arduino is the source of the real sensor status.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Vehicle Security & Anti-Theft Protection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecurityInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const SecurityInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 27,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}