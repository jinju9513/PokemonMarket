import 'package:flutter/material.dart';

class CardTradeDetailList extends StatelessWidget{
  final String userName;
  final List<String> desiredCards;
  final List<String> ownedCards;

const CardTradeDetailList({
  super.key, 
  required this.userName, 
  required this.desiredCards, 
  required this.ownedCards});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('원하는 카드', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              _buildCardRow(desiredCards),
              const SizedBox(height: 16),
              const Text('보유카드', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              _buildCardRow(ownedCards),
            ],
          ),
        );
    
  }
  Widget _buildCardRow(List<String> cardPaths) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: cardPaths.map((path) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.asset(path, width: 60), // 원하는 사이즈로 조절
        );
      }).toList(),
    );
  }
}