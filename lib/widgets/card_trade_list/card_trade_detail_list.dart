import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_img.dart';

class CardTradeDetailList extends StatelessWidget {
  final String userName;
  final List<String> desiredCards;
  final List<String> ownedCards;

  const CardTradeDetailList({
    super.key,
    required this.userName,
    required this.desiredCards,
    required this.ownedCards,
  });

  // 전체 화면 이미지 보기 다이얼로그 (DetailList에서 재사용)
  void _showFullScreenImage(BuildContext context, String? imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: imagePath != null
                      ? CommonImg(
                          path: imagePath,
                          width: double.infinity,
                          height: double.infinity,
                          boxFit: BoxFit.contain,
                        )
                      : const CommonImg(
                          path: 'assets/placeholder.png',
                          width: double.infinity,
                          height: double.infinity,
                          boxFit: BoxFit.contain,
                        ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 현재 테마 접근

    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, // 테마 기반 카드 색상
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: theme.textTheme.bodyLarge, // 유저 이름
          ),
          const SizedBox(height: 12),
          Text(
            '원하는 카드',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _buildCardRow(context, desiredCards),
          const SizedBox(height: 16),
          Text(
            '보유카드',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _buildCardRow(context, ownedCards),
        ],
      ),
    );
  }

  Widget _buildCardRow(BuildContext context, List<String> cardPaths) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cardPaths.map((path) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => _showFullScreenImage(context, path),
              child: CommonImg(
                path: path,
                width: 60,
                height: 60,
                boxFit: BoxFit.contain,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}