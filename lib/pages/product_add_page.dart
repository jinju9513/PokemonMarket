import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// 상품 등록 페이지
class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _priceController.addListener(_formatPrice);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.removeListener(_formatPrice);
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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

  Future<String?> _saveImageToLocal(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String newPath = '${directory.path}/product_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final File newImage = await image.copy(newPath);
      return newImage.path;
    } catch (e) {
      print('이미지 저장 실패: $e');
      return null;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  ThemeColors _getThemeColors(bool isDark) {
    return ThemeColors(
      containerColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      textColor: isDark ? Colors.white : Colors.black,
      hintColor: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      imageAreaColor: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      imageIconColor: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
      outerContainerColor: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
    );
  }

  // 이미지 선택 위젯
  Widget _buildImageSelector(ThemeColors colors) {
    return Container(
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        color: colors.outerContainerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(-2, -2),
            blurRadius: 4,
            spreadRadius: 0.5,
          ),
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: _pickImage,
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
                        text: '이미지 선택',
                        fontSize: 18,
                        textColor: colors.imageIconColor,
                      ),
                    ],
                  ),
                )
              : null,
        ),
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
    List<TextInputFormatter>? inputFormatters,
  }) {
    final textField = TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
      return Container(
        width: MediaQuery.of(context).size.width - 48,
        decoration: BoxDecoration(
          color: colors.outerContainerColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(-2, -2),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: label,
                fontSize: 18,
                textColor: colors.textColor,
              ),
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
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        color: colors.outerContainerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(-2, -2),
            blurRadius: 4,
            spreadRadius: 0.5,
          ),
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0.5,
          ),

      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: CommonText(
                text: label,
                fontSize: 18,
                textColor: colors.textColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: colors.containerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(child: textField),
                    if (label == '가격') ...[
                      const SizedBox(width: 10),
                      CommonText(
                        text: '원',
                        fontSize: 18,
                        textColor: colors.textColor,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final colors = _getThemeColors(themeManager.isDarkMode);

    return Theme(
      data: themeManager.isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        backgroundColor: themeManager.isDarkMode ? Colors.grey.shade900 : Colors.white,
        appBar: CommonAppbar(
          isDarkMode: themeManager.isDarkMode,
          toggleTheme: themeManager.toggleTheme,
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildImageSelector(colors),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildInputField(
                    label: '상품명',
                    controller: _nameController,
                    colors: colors,
                    hintText: '상품명을 입력하세요',
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildInputField(
                    label: '가격',
                    controller: _priceController,
                    colors: colors,
                    keyboardType: TextInputType.number,
                    hintText: '가격을 입력하세요',
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildInputField(
                    label: '상세내용',
                    controller: _descriptionController,
                    colors: colors,
                    hintText: '상세내용을 입력하세요',
                    isExpanded: true,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colors.outerContainerColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: colors.textColor),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    style: IconButton.styleFrom(
                      backgroundColor: colors.containerColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '$_quantity',
                      style: TextStyle(fontSize: 16, color: colors.textColor),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: colors.textColor),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                    style: IconButton.styleFrom(
                      backgroundColor: colors.containerColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  String? imagePath;
                  if (_image != null) {
                    imagePath = await _saveImageToLocal(_image!);
                  }
                  final product = {
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': _nameController.text,
                    'price': _priceController.text,
                    'description': _descriptionController.text,
                    'quantity': _quantity,
                    'imagePath': imagePath,
                    'createdAt': DateTime.now().toIso8601String(),
                  };
                  Navigator.pop(context, product);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text('등록하기', style: TextStyle(fontSize: 16)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class ThemeColors {
  final Color containerColor;
  final Color textColor;
  final Color hintColor;
  final Color imageAreaColor;
  final Color imageIconColor;
  final Color outerContainerColor;

  const ThemeColors({
    required this.containerColor,
    required this.textColor,
    required this.hintColor,
    required this.imageAreaColor,
    required this.imageIconColor,
    required this.outerContainerColor,
  });
}
