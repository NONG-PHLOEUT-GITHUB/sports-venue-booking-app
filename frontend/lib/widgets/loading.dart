import 'package:flutter/material.dart';

/// Flutter code sample for [CircularProgressIndicator].
class ProgressIndicatorApp extends StatelessWidget {
  const ProgressIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProgressIndicator(),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                semanticsLabel: 'Circular progress indicator',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
