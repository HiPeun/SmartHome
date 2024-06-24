import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FireDetectionScreen(),
    );
  }
}

class FireDetectionScreen extends StatefulWidget {
  @override
  _FireDetectionScreenState createState() => _FireDetectionScreenState();
}

class _FireDetectionScreenState extends State<FireDetectionScreen> {
  final String broker = '192.168.0.168'; // MQTT 브로커 IP 주소
  final String topic = 'fire_detection';
  late MqttServerClient client;
  String fireStatus = 'No fire detected';

  @override
  void initState() {
    super.initState();
    setupMqttClient();
  }

  Future<void> setupMqttClient() async {
    client = MqttServerClient(broker, '');
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .startClean();
    client.connectionMessage = connMessage;

    try {
      await client.connect();
      client.subscribe(topic, MqttQos.atMostOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>>? c) {
        if (c != null && c.isNotEmpty) {
          final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
          final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          setState(() {
            fireStatus = message;
          });
        }
      });
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  void onConnected() {
    print('Connected');
  }

  void onDisconnected() {
    print('Disconnected');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Fire Status:'),
            Text(
              fireStatus,
              style: TextStyle(
                  fontSize: 24,
                  color: fireStatus == 'Fire detected!'
                      ? Colors.red
                      : Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
