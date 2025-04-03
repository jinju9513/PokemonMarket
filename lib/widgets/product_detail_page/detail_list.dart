import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class DetailList extends StatelessWidget {
  const DetailList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(text: '상품명 :', fontSize: 20),
                const CommonText(text: '리자몽', fontSize: 24),
              ],
            ),
            const CommonText(text: '10,000원', fontSize: 20),
          ],
        ),
        const SizedBox(height: 60),
        const CommonText(text: '상품설명 : ', fontSize: 18),
        const CommonText(text: '&^*%^*%*!@!,#', fontSize: 22),
        const SizedBox(height: 30),
      ],
    );
  }
}
