import 'package:flutter/material.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

class SelectCardPage extends StatefulWidget {
  const SelectCardPage({super.key});

  @override
  State<SelectCardPage> createState() => _SelectCardPageState();
}

class _SelectCardPageState extends State<SelectCardPage> {
  final List<String> selectedCards = [];

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;
    final theme = Theme.of(context);

    final List<String> cardAssets =
        List.generate(20, (index) => 'assets/${index + 1}.png');

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: isDarkMode,
        toggleTheme: themeManager.toggleTheme,
      ),
      backgroundColor: isDarkMode ? Colors.black87 : Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: cardAssets.length,
                itemBuilder: (context, index) {
                  final card = cardAssets[index];
                  final isSelected = selectedCards.contains(card);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCards.remove(card);
                        } else {
                          selectedCards.add(card);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.amber : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Card(
                        color: isDarkMode ? Colors.white24 : Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(card, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              onPressed: selectedCards.isNotEmpty
                  ? () {
                      Navigator.pop(context, selectedCards);
                    }
                  : null,
              child: const Text(
                '등록하기',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
