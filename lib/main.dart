import 'package:flutter/material.dart';

import 'transform.dart';
import 'platformviews.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Android Platform View Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('APV Debug Demo')),
        body: Center(
            child: Column(children: [
          ElevatedButton(
              child: const Text('Basic'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransformWidget(
                          title: 'Basic', viewType: PlatformViewType.kBasic)),
                );
              }),
          ElevatedButton(
              child: const Text('Input'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransformWidget(
                          title: 'Input', viewType: PlatformViewType.kInput)),
                );
              }),
          ElevatedButton(
              child: const Text('Maps'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransformWidget(
                          title: 'Maps', viewType: PlatformViewType.kMap)),
                );
              }),
        ])));
  }
}
