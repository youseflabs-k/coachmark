import 'package:flutter/material.dart';
import 'package:coachmark/coachmark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coachmark Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CoachmarkDemo(),
    );
  }
}

class CoachmarkDemo extends StatefulWidget {
  const CoachmarkDemo({super.key});

  @override
  State<CoachmarkDemo> createState() => _CoachmarkDemoState();
}

class _CoachmarkDemoState extends State<CoachmarkDemo> {
  bool _showAppBarCoachmark = false;
  bool _showCounterCoachmark = false;
  bool _showFabCoachmark = false;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _startTour() {
    setState(() {
      _showAppBarCoachmark = true;
      _showCounterCoachmark = false;
      _showFabCoachmark = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Coachmark Demo'),
        actions: [
          Coachmark(
            isVisible: _showAppBarCoachmark,
            onDismiss: () {
              setState(() {
                _showAppBarCoachmark = false;
                _showCounterCoachmark = true;
              });
            },
            config: const CoachmarkConfig(
              description: 'Tap this help icon anytime to restart the tour.',
              bubbleBackgroundColor: Colors.blue,
              highlightBorderColor: Colors.blue
            ),
            child: IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: _startTour,
              tooltip: 'Start Tour',
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Coachmark(
              isVisible: _showCounterCoachmark,
              onDismiss: () {
                setState(() {
                  _showCounterCoachmark = false;
                  _showFabCoachmark = true;
                });
              },
              config: const CoachmarkConfig(
                description: 'This shows how many times you have pressed the button.',
                highlightBorderColor: Colors.orange,
                highlightPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'You have pushed the button this many times:',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Coachmark(
        isVisible: _showFabCoachmark,
        onDismiss: () {
          setState(() {
            _showFabCoachmark = false;
          });
        },
        config: const CoachmarkConfig(
          description: 'Tap this button to increment the counter. Try it out!',
          bubbleBackgroundColor: Colors.green,
          descriptionStyle: TextStyle(color: Colors.white),
          highlightBorderColor: Colors.green,
        ),
        child: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
