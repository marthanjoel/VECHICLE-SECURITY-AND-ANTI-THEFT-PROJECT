# 🚗 Vehicle Security & Anti-Theft System

A smart vehicle security and anti-theft prototype built using an **Arduino UNO R3** and a **Flutter mobile/desktop application**.

The system uses a **tilt sensor** to detect unauthorized movement or tilting of the vehicle. When a disturbance is detected, the Arduino activates a visual and audible alarm and sends the security status to the Flutter application through USB serial communication.

---

## 📌 Project Overview

The Vehicle Security & Anti-Theft System is designed to provide basic electronic security monitoring for a vehicle prototype.

The Arduino continuously monitors the tilt sensor.

### Normal condition

When the vehicle is stationary:

* 🟡 Yellow LED is ON
* 🔴 Red LED is OFF
* 🔊 Buzzer is OFF
* Security status is **ARMED**
* Tilt status is **NORMAL**

### Alert condition

When the vehicle is tilted:

* 🟡 Yellow LED turns OFF
* 🔴 Red LED turns ON
* 🔊 Buzzer turns ON
* Arduino sends an alert to the Flutter application
* Flutter displays **SECURITY ALERT**
* After approximately 2 seconds, the system returns to normal

---

## 🧰 Hardware Required

| Component      |    Quantity |
| -------------- | ----------: |
| Arduino UNO R3 |           1 |
| Tilt Sensor    |           1 |
| Buzzer         |           1 |
| Yellow LED     |           1 |
| Red LED        |           1 |
| Resistors      |           2 |
| Jumper Wires   | As required |
| USB Cable      |           1 |
| Breadboard     |           1 |

---

## 🔌 Circuit Connections

| Component   | Arduino Pin |
| ----------- | ----------- |
| Tilt Sensor | D2          |
| Buzzer      | D8          |
| Yellow LED  | D12         |
| Red LED     | D13         |
| GND         | GND         |

### Tilt Sensor Logic

The sensor used in this project operates as follows:

```text
Still   → HIGH (1)
Tilted  → LOW  (0)
```

---

## 💻 Software

### Arduino

The Arduino program was developed for:

* Arduino UNO R3
* Arduino IDE
* Serial communication at **9600 baud**

### Flutter

The Flutter application provides:

* Arduino connection status
* Serial port selection
* Security status
* Tilt status
* Alarm status
* Protection status
* Real-time Arduino information

The Flutter application communicates with the Arduino through the USB serial connection.

---

## 📡 Serial Communication

The Arduino sends simple text messages to the Flutter application.

### Startup messages

```text
SECURITY:ARMED
TILT:NORMAL
ALARM:OFF
```

### When a tilt is detected

```text
SECURITY:ALERT
TILT:DETECTED
ALARM:ON
```

### When the alert ends

```text
SECURITY:ARMED
TILT:NORMAL
ALARM:OFF
```

The serial communication speed is:

```text
9600 baud
```

---

## 📱 Flutter Application

The Flutter application is located in:

```text
lib/
```

The main application interface is:

```text
lib/main.dart
```

The Arduino serial communication service is:

```text
lib/services/arduino_serial_service.dart
```

The serial service is responsible for:

* Detecting available serial ports
* Connecting to the Arduino
* Receiving Arduino messages
* Processing incoming serial data
* Sending serial commands when required
* Disconnecting from the Arduino

---

## 📂 Project Structure

```text
VECHICLE-SECURITY-AND-ANTI-THEFT-PROJECT/
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── lib/
│   ├── main.dart
│   │
│   └── services/
│       └── arduino_serial_service.dart
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
├── pubspec.lock
│
└── .github/
    └── workflows/
        └── build-apk.yml
```

---

## ⚙️ Flutter Dependencies

The project uses the `flserial` package for serial communication between Flutter and the Arduino.

Install dependencies with:

```bash
flutter pub get
```

---

## 🚀 Running the Flutter Application

Clone the project:

```bash
git clone <YOUR-GITHUB-REPOSITORY>
```

Enter the project directory:

```bash
cd VECHICLE-SECURITY-AND-ANTI-THEFT-PROJECT
```

Install dependencies:

```bash
flutter pub get
```

Check the project:

```bash
flutter analyze
```

Run the application on Linux:

```bash
LIBGL_ALWAYS_SOFTWARE=1 flutter run -d linux
```

---

## 🔌 Connecting the Arduino

1. Connect the Arduino UNO R3 to the computer using USB.
2. Upload the Arduino security program.
3. Close the Arduino Serial Monitor.
4. Start the Flutter application.
5. Select the Arduino serial port.
6. Click **CONNECT ARDUINO**.
7. The application will receive the Arduino security messages.

On Linux, the Arduino may appear as:

```text
/dev/ttyACM0
```

---

## ⚠️ Important

Only one application should use the Arduino serial port at a time.

Therefore, close the Arduino Serial Monitor before connecting the Flutter application.

---

## 🏗️ Building the Android APK

This project includes a GitHub Actions workflow for automatically building the Android APK.

The workflow is located at:

```text
.github/workflows/build-apk.yml
```

Whenever changes are pushed to the `main` branch, GitHub Actions can build the release APK.

The APK is generated as:

```text
app-release.apk
```

The APK can be obtained from the **GitHub Actions artifact** after the workflow finishes successfully.

---

## 🔄 System Flow

```text
             ┌──────────────────┐
             │   Tilt Sensor    │
             └────────┬─────────┘
                      │
                      ▼
             ┌──────────────────┐
             │   Arduino UNO    │
             │                  │
             │  Security Logic  │
             └───────┬─────┬────┘
                     │     │
          ┌──────────┘     └──────────┐
          ▼                           ▼
   ┌─────────────┐             ┌─────────────┐
   │ Yellow LED  │             │   Red LED   │
   │   NORMAL    │             │   ALERT     │
   └─────────────┘             └─────────────┘
                     │
                     ▼
              ┌─────────────┐
              │   Buzzer    │
              │    ALERT    │
              └─────────────┘
                     │
                     ▼
              USB Serial 9600
                     │
                     ▼
             ┌──────────────────┐
             │  Flutter App     │
             │                  │
             │ Security Status  │
             │ Tilt Status      │
             │ Alarm Status     │
             │ Protection       │
             └──────────────────┘
```

---

## 🎯 Project Objectives

The main objectives of this project are:

1. Detect unauthorized vehicle movement using a tilt sensor.
2. Provide a local visual security indication.
3. Provide an audible alert when a disturbance is detected.
4. Send real-time security information to a Flutter application.
5. Demonstrate Arduino-to-Flutter serial communication.
6. Create a foundation for a larger smart vehicle control system.

---

## 🔮 Future Improvements

Possible future improvements include:

* 📱 Wireless communication between Arduino and phone
* 🔐 PIN/password-based security control
* 🔔 Customizable alarm duration
* 📍 GPS vehicle location
* 📶 GSM/SMS security notifications
* 🔋 Battery monitoring
* 📊 Security event history
* ☁️ Cloud monitoring
* 🔒 Remote arm/disarm functionality
* 🚗 Integration with the other vehicle systems

---

## 👨‍💻 Technologies Used

* **Arduino UNO R3**
* **Arduino IDE**
* **C/C++**
* **Flutter**
* **Dart**
* **flserial**
* **USB Serial Communication**
* **Git**
* **GitHub**
* **GitHub Actions**

---

## 📜 License

This project is intended primarily for educational, experimental, and prototype development purposes.

---

## 🙌 Author

**Lutwama Joel**

Electrical Installation Student

Vehicle Electronics & Smart Vehicle Systems Project

---

## ⭐ Project Status

**Status: Working Prototype ✅**

The Arduino security system has been tested with the tilt sensor, LEDs, buzzer, USB serial communication, and Flutter interface.
