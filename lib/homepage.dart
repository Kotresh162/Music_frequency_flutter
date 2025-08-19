
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message= "Decoding...";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Detector'),
        leading: IconButton(onPressed: () {
          print("printed");
        }, icon: const Icon(Icons.home)),
        shape: const Border(
          bottom: BorderSide(
            color: Colors.red,  // Color of the bottom border
            width: 2.0,         // Thickness of the bottom border
            style: BorderStyle.solid, // Style of the border (solid, dashed, etc.)
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('upload file');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

    );
  }
}
