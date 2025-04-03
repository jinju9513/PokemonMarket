import 'package:flutter/material.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final ThemeManager _themeManager = ThemeManager();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _themeManager.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _themeManager.removeListener(_onThemeChanged);
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onThemeChanged(bool isDark) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeManager.isDarkMode;

    // 다크모드에 맞는 색상 설정
    final containerColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final imageAreaColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;
    final imageIconColor = isDark ? Colors.grey.shade300 : Colors.grey.shade700;

    return Theme(
      data: isDark ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: CommonAppbar(
          isDarkMode: isDark,
          toggleTheme: _themeManager.toggleTheme,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // 이미지 선택 영역
              GestureDetector(
                onTap: () {
                  // 이미지 선택 로직
                },
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: imageAreaColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: imageIconColor,
                        ),
                        const SizedBox(height: 10),
                        CommonText(
                          text: 'image선택',
                          fontSize: 18,
                          textColor: imageIconColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // 상품명
              Row(
                children: [
                  CommonText(
                    text: '상품이름',
                    fontSize: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '상품 이름을 입력하세요',
                          hintStyle: TextStyle(color: hintColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 상품가격
              Row(
                children: [
                  CommonText(
                    text: '상품가격',
                    fontSize: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '가격을 입력하세요',
                          hintStyle: TextStyle(color: hintColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CommonText(
                    text: '원',
                    fontSize: 18,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 상품 설명
              Container(
                height: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  expands: true,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '상품 설명을 입력하세요',
                    hintStyle: TextStyle(color: hintColor),
                  ),
                ),
              ),
              const Spacer(),
              // 등록하기 버튼
              ElevatedButton(
                onPressed: () {
                  // 등록 로직
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: CommonText(
                  text: '등록하기',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
