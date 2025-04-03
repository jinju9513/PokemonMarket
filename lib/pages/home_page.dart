import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            HomePageList(),
          ],
        ),
      ),
      floatingActionButton: Fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  FloatingActionButton Fab() {
    return FloatingActionButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Icon(
        Icons.add,
        size: 30,
        weight: 800,
      ),
    );
  }
}
