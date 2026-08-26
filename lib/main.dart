import 'package:flutter/material.dart';

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
  State<SecurityHomePage> createState() => _SecurityHomePageState();
}

class _SecurityHomePageState extends State<SecurityHomePage> {
  bool isArmed = false;
  bool disturbanceDetected = false;

  String get systemStatus {
    if (!isArmed) {
      return 'SYSTEM DISARMED';
    }

    if (disturbanceDetected) {
      return 'SECURITY ALERT!';
    }

    return 'SYSTEM ARMED';
  }

  String get disturbanceStatus {
    if (disturbanceDetected) {
      return 'DISTURBANCE DETECTED!';
    }

    return 'NO DISTURBANCE';
  }

  String get alertMessage {
    if (!isArmed) {
      return 'SECURITY SYSTEM IS OFF';
    }

    if (disturbanceDetected) {
      return 'VEHICLE DISTURBANCE DETECTED!';
    }

    return 'VEHICLE IS SECURE';
  }

  Color get statusColor {
    if (!isArmed) {
      return Colors.grey;
    }

    if (disturbanceDetected) {
      return Colors.red;
    }

    return Colors.green;
  }

  IconData get statusIcon {
    if (!isArmed) {
      return Icons.lock_open;
    }

    if (disturbanceDetected) {
      return Icons.warning_amber_rounded;
    }

    return Icons.security;
  }

  void toggleSecurity() {
    setState(() {
      isArmed = !isArmed;

      // Clear any previous alert when changing security state.
      disturbanceDetected = false;
    });
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

              // VEHICLE ICON
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

              const SizedBox(height: 25),

              // SECURITY INFORMATION CARD
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

                    // STATUS ICON
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

                    // SYSTEM STATUS
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

                    // DISTURBANCE STATUS
                    SecurityInfoRow(
                      icon: Icons.warning_amber_rounded,
                      title: 'Disturbance',
                      value: disturbanceStatus,
                      color: disturbanceDetected
                          ? Colors.red
                          : Colors.green,
                    ),

                    const SizedBox(height: 18),

                    // ALERT STATUS
                    SecurityInfoRow(
                      icon: Icons.notifications_active,
                      title: 'Alert',
                      value: alertMessage,
                      color: statusColor,
                    ),

                    const SizedBox(height: 18),

                    // PROTECTION STATUS
                    SecurityInfoRow(
                      icon: Icons.shield,
                      title: 'Protection',
                      value: isArmed
                          ? 'ACTIVE'
                          : 'INACTIVE',
                      color: isArmed
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ARMED / DISARMED TOGGLE BUTTON
              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton.icon(
                  onPressed: toggleSecurity,

                  icon: Icon(
                    isArmed
                        ? Icons.lock
                        : Icons.lock_open,
                    size: 27,
                  ),

                  label: Text(
                    isArmed
                        ? 'ARMED'
                        : 'DISARMED',

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: isArmed
                        ? Colors.green
                        : Colors.grey.shade700,

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // FOOTER
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


// SECURITY INFORMATION ROW
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