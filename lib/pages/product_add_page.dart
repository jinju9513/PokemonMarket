import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  File? _image; // 선택된 이미지 저장
  int _quantity = 1; // 상품 갯수 상태

  @override
  void initState() {
    super.initState();
    _themeManager.addListener(_onThemeChanged);
    // 가격 입력 시 쉼표 포맷팅 리스너 추가
    _priceController.addListener(_formatPrice);
  }

  @override
  void dispose() {
    _themeManager.removeListener(_onThemeChanged);
    _nameController.dispose();
    _priceController.removeListener(_formatPrice);
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onThemeChanged(bool isDark) {
    setState(() {});
  }

  // 가격 포맷팅 함수
  void _formatPrice() {
    String text = _priceController.text.replaceAll(',', '');
    if (text.isNotEmpty) {
      final number = int.tryParse(text);
      if (number != null) {
        final formatter = NumberFormat('#,###');
        String formatted = formatter.format(number);
        if (formatted != _priceController.text) {
          _priceController.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }
      }
    }
  }

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // 색상 테마 getter
  ThemeColors _getThemeColors(bool isDark) {
    return ThemeColors(
      containerColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      textColor: isDark ? Colors.white : Colors.black,
      hintColor: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      imageAreaColor: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      imageIconColor: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
    );
  }

  // 이미지 선택 위젯
  Widget _buildImageSelector(ThemeColors colors) {
    return GestureDetector(
      onTap: _pickImage, // 이미지 선택 활성화
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: colors.imageAreaColor,
          borderRadius: BorderRadius.circular(12),
          image: _image != null
              ? DecorationImage(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _image == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: colors.imageIconColor,
                    ),
                    const SizedBox(height: 10),
                    CommonText(
                      text: 'image선택',
                      fontSize: 18,
                      textColor: colors.imageIconColor,
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  // 입력 필드 위젯
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required ThemeColors colors,
    TextInputType? keyboardType,
    String? hintText,
    bool isExpanded = false,
  }) {
    final textField = TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: colors.textColor),
      maxLines: isExpanded ? null : 1,
      expands: isExpanded,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(color: colors.hintColor),
      ),
    );

    if (isExpanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: label, fontSize: 18),
          const SizedBox(height: 10),
          Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.containerColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: textField,
          ),
        ],
      );
    }

    return Row(
      children: [
        CommonText(text: label, fontSize: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colors.containerColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: textField,
          ),
        ),
        if (label == '상품가격') ...[
          const SizedBox(width: 10),
          CommonText(text: '원', fontSize: 18),
        ],
      ],
    );
  }

  // 상품 갯수 조절 위젯
  Widget _buildQuantitySelector(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (_quantity > 1) {
              setState(() {
                _quantity--;
              });
            }
          },
          icon: const Icon(Icons.remove),
          color: colors.textColor,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: colors.containerColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CommonText(
            text: '$_quantity',
            fontSize: 18,
            textColor: colors.textColor,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _quantity++;
            });
          },
          icon: const Icon(Icons.add),
          color: colors.textColor,
        ),
      ],
    );
  }

  // 등록 버튼 위젯
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // 등록 로직 (예: 이미지, 이름, 가격, 설명, 갯수 데이터 처리)
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const CommonText(
        text: '등록하기',
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _themeManager.isDarkMode;
    final colors = _getThemeColors(isDark);

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
              _buildImageSelector(colors),
              const SizedBox(height: 30),
              _buildInputField(
                label: '상품이름',
                controller: _nameController,
                colors: colors,
                hintText: '상품 이름을 입력하세요',
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: '상품가격',
                controller: _priceController,
                colors: colors,
                keyboardType: TextInputType.number,
                hintText: '가격을 입력하세요',
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: '상품설명',
                controller: _descriptionController,
                colors: colors,
                hintText: '상품 설명을 입력하세요',
                isExpanded: true,
              ),
              const SizedBox(height: 20),
              _buildQuantitySelector(colors), // 상품 갯수 추가
              const Spacer(),
              _buildSubmitButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// 테마 색상을 관리하는 클래스
class ThemeColors {
  final Color containerColor;
  final Color textColor;
  final Color hintColor;
  final Color imageAreaColor;
  final Color imageIconColor;

  const ThemeColors({
    required this.containerColor,
    required this.textColor,
    required this.hintColor,
    required this.imageAreaColor,
    required this.imageIconColor,
  });
}