import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: 'POKE',
          fontSize: 24,
        ),
      ),
      body: Column(
        children: [
          // 여기에 다른 위젯들을 추가할 수 있습니다
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Icon(
          Icons.add,
          size: 30,
          weight: 800,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
