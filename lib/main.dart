import 'package:chat_bubble/controllers/bubble_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _textFieldTEC;
  late BubbleController _bubbleCtrl;

  @override
  void initState() {
    super.initState();
    _bubbleCtrl = BubbleController();
    _textFieldTEC = TextEditingController()
      ..text = _bubbleCtrl.bubbleText.value;
  }

  @override
  void dispose() {
    _textFieldTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<String>(
            valueListenable: _bubbleCtrl.bubbleText,
            builder: (_, String bubbleText, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 4.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    constraints: BoxConstraints(
                        maxWidth: _bubbleCtrl.width + 2), // For border
                    height: _bubbleCtrl.height,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade700,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return const Text(
                                    "AUTHOR",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Text(bubbleText,
                            maxLines: _bubbleCtrl.maxLines,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bubble text:'),
                        TextField(
                          controller: _textFieldTEC,
                          onChanged: (String bubbleText) =>
                              _bubbleCtrl.resizeBubble(bubbleText),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
