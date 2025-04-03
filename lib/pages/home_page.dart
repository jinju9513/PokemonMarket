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
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Image.asset('/assets/리자몽.png'),
                    Column(
                      children: [
                        CommonText(text: '피카츄'),
                        CommonText(text: '가격 : 10,000원'),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
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
