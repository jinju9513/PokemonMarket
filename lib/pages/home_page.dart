import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';
import 'package:pokemon_market/theme/custom_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: CommonText(
            text: 'POKE',
            fontSize: 24,
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: isDarkMode ? Colors.yellow : Colors.blueGrey,
              ),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //TODO: 삼항연산자 사용해서 상품여부 확인필요
              CommonText(
                text: '상품이 없습니다.',
                fontSize: 24,
              ),
              HomePageList(),
            ],
          ),
        ),
        floatingActionButton: Fab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  FloatingActionButton Fab() {
    return FloatingActionButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor:
          isDarkMode ? darkTheme.primaryColor : lightTheme.primaryColor,
      child: Icon(
        Icons.add,
        size: 30,
        weight: 800,
      ),
    );
  }
}
