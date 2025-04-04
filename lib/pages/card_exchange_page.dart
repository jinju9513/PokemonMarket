import 'package:flutter/material.dart';
import 'package:pokemon_market/pages/select_card_page.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

class CardExchangePage extends StatefulWidget {
  final String userName;
  final List<String> desiredCards;
  final List<String> ownedCards;

  const CardExchangePage({
    super.key,
    required this.userName,
    required this.desiredCards,
    required this.ownedCards,
  });

  @override
  _CardExchangePageState createState() => _CardExchangePageState();
}

class _CardExchangePageState extends State<CardExchangePage> {
  final TextEditingController _nameController = TextEditingController();
  List<String> selectedDesiredCards = [];
  List<String> selectedOwnedCards = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: CommonAppbar(
        isDarkMode: themeManager.isDarkMode,
        toggleTheme: themeManager.toggleTheme,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '카드 교환하기',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            _buildEditableTextField('닉네임', _nameController),
            const SizedBox(height: 16),
            _buildCardSelection(
              '원하는 카드',
              selectedDesiredCards,
              (selectedCard) {
                setState(() {
                  selectedDesiredCards.add(selectedCard);
                });
              },
            ),
            const SizedBox(height: 16),
            _buildCardSelection(
              '보유카드',
              selectedOwnedCards,
              (selectedCard) {
                setState(() {
                  selectedOwnedCards.add(selectedCard);
                });
              },
            ),
            const Spacer(),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableTextField(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildCardSelection(
      String label, List<String> cards, Function(String) onCardSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final selectedCardList = await Navigator.push<List<String>>(
              context,
              MaterialPageRoute(builder: (context) => const SelectCardPage()),
            );

            if (selectedCardList != null) {
              setState(() {
                cards.addAll(
                    selectedCardList.where((card) => !cards.contains(card)));
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('카드 선택', style: TextStyle(fontSize: 16)),
                if (cards.isNotEmpty)
                  Row(
                    children: cards
                        .map((card) => Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Image.asset(card, width: 40, height: 40),
                            ))
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, {
          'userName': _nameController.text,
          'desiredCards': selectedDesiredCards,
          'ownedCards': selectedOwnedCards,
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            '등록하기',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
