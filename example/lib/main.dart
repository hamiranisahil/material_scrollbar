import 'package:flutter/material.dart';
import 'package:simple_scroll_bar/material_scrollbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  List items = List.generate(40, (index) => "Child item $index ");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Scroll Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material Scroll Bar Example'),
        ),
        body: SafeArea(
          child: MaterialScrollBar(
            thumbColor: const Color(0xffe240fb),
            trackColor: const Color(0xfff0c0f8),
            thumbVisibility: true,
            thickness: 10,
            radius: const Radius.circular(10),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        title: Text(items[index]),
                      ),
                      const Divider(
                        height: 1,
                      )
                    ],
                  ),
                );
              },
              itemCount: items.length,
            ),
          ),
        ),
      ),
    );
  }
}
