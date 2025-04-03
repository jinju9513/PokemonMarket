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
          
        ],
      ),
    );
  }
}
