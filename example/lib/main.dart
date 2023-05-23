import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_andomie/widgets.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool selected = false;

  @override
  void initState() {
    var now = DateTime.now().subtract(const Duration(days: 1));
    Timer.periodic(const Duration(seconds: 2), (timer) {
      now = now.add(Duration(minutes: timer.tick * 5));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
            stream: items(),
            builder: (context, snapshot) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: FrameView<String>(
                  itemBackground: Colors.red,
                  items: snapshot.data ?? [],
                ),
              );
            }),
      ),
    );
  }
}

Stream<List<String>> items() {
  var list = <String>[
    "",
  ];
  var controller = StreamController<List<String>>();
  Timer.periodic(const Duration(seconds: 1), (timer) {
    if (list.length > 8) {
      list.clear();
    }
    list.add("");
    controller.add(list);
  });
  return controller.stream;
}
