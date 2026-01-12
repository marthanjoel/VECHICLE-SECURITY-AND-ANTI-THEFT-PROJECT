# VECHICLE-SECURITY-AND-ANTI-THEFT-PROJECT


Vibration Sensor Vehicle Alert System
Project Overview

This project is a Vehicle Alert System that detects any knocks or vibrations on a vehicle and alerts immediately. It helps prevent unauthorized access or theft. The system uses a vibration sensor to detect shocks, a yellow LED to show the system is normal, a red LED to indicate an alert, and a buzzer to sound an alarm.

Components Used

The system uses a vibration sensor to detect knocks or impacts. A yellow LED indicates that the system is normal. A red LED and buzzer turn on when a vibration is detected. An Arduino microcontroller controls the sensor and triggers the LEDs and buzzer. Resistors are used with the LEDs to prevent damage.

Circuit Connections

The vibration sensor is connected to pin 2 on the Arduino. The buzzer is connected to pin 8. The yellow LED is connected to pin 12 and the red LED to pin 13, with their negative legs connected to GND. The vibration sensor and buzzer are powered by 5V from the Arduino.

Working Principle

When the system is powered, the yellow LED is ON, showing that the system is normal. If the vibration sensor detects a knock, the red LED turns ON, the yellow LED turns OFF, and the buzzer sounds for 2 seconds. After 2 seconds, the system returns to normal. The Serial Monitor also prints the system status as either “System Normal” or “ALERT! Vibration Detected!”

Demo Instructions

Power the system. The yellow LED is ON, and the red LED and buzzer are OFF.

Tap or shake the vibration sensor. The red LED lights up, the yellow LED turns OFF, and the buzzer sounds for 2 seconds.

Release the sensor. The system returns to normal, with the yellow LED ON and the red LED OFF.

Observe the Serial Monitor for real-time status updates.

Applications

This system can be used as a vehicle anti-theft alarm, to detect impacts on parked vehicles, or extended with GSM alerts or remote notifications for advanced security.
