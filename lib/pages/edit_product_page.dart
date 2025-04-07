import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'dart:math' as math;

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late int _quantity;
  late TextEditingController _descController;
  File? _imageFile;
  String? _imagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name'] ?? '');

    // 가격에 쉼표 포맷팅 적용
    dynamic priceValue = widget.product['price'] ?? 0;
    String formattedPrice;
    if (priceValue is int) {
      formattedPrice = NumberFormat('#,###').format(priceValue);
    } else if (priceValue is String) {
      int? parsedPrice = int.tryParse(priceValue.replaceAll(',', ''));
      formattedPrice =
          parsedPrice != null ? NumberFormat('#,###').format(parsedPrice) : '0';
    } else {
      formattedPrice = '0';
    }

    _priceController = TextEditingController(text: formattedPrice);
    _priceController.addListener(_formatPrice);

    // 수량 정보를 int로 저장
    _quantity = widget.product['quantity'] ?? 0;
    if (_quantity < 1) _quantity = 1;

    _descController =
        TextEditingController(text: widget.product['description'] ?? '');
    _imagePath = widget.product['imagePath'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.removeListener(_formatPrice);
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = pickedFile.path;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showImageSourceDialog() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? PokemonColors.cardDark
                      : PokemonColors.cardLight,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: isDarkMode
                        ? PokemonColors.primaryBlue.withOpacity(0.3)
                        : PokemonColors.primaryRed.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 포켓볼 아이콘 (애니메이션)
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 700),
                      tween: Tween<double>(begin: 0, end: 2 * math.pi),
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: math.sin(value) * 0.05,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? PokemonColors.primaryBlue.withOpacity(0.1)
                              : PokemonColors.primaryRed.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/plus_logo.png',
                          width: 60,
                          height: 60,
                          color: isDarkMode
                              ? PokemonColors.primaryYellow
                              : PokemonColors.primaryRed,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 제목
                    Text(
                      '이미지 선택',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 갤러리 옵션
                    _buildImageSourceOption(
                      icon: Icons.photo_library_rounded,
                      title: '갤러리에서 선택',
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      },
                      isDarkMode: isDarkMode,
                    ),

                    const SizedBox(height: 16),

                    // 카메라 옵션
                    _buildImageSourceOption(
                      icon: Icons.camera_alt_rounded,
                      title: '카메라로 촬영',
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      },
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.black.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode
                ? PokemonColors.primaryBlue.withOpacity(0.3)
                : PokemonColors.primaryRed.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDarkMode
                  ? PokemonColors.primaryYellow
                  : PokemonColors.primaryRed,
              size: 28,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: '상품 수정',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {
                // 필수 입력값 검증
                if (_nameController.text.trim().isEmpty) {
                  _showValidationErrorDialog(context, '상품명을 입력해주세요');
                  return;
                }
                if (_priceController.text.trim().isEmpty) {
                  _showValidationErrorDialog(context, '가격을 입력해주세요');
                  return;
                }
                if (_quantity < 1) {
                  _showValidationErrorDialog(context, '재고 수량을 입력해주세요');
                  return;
                }
                if (_imagePath == null) {
                  _showValidationErrorDialog(context, '상품 이미지를 선택해주세요');
                  return;
                }

                final updatedProduct =
                    Map<String, dynamic>.from(widget.product);
                updatedProduct['name'] = _nameController.text;
                updatedProduct['price'] =
                    int.tryParse(_priceController.text.replaceAll(',', '')) ??
                        0;
                updatedProduct['quantity'] = _quantity;
                updatedProduct['description'] = _descController.text;
                updatedProduct['imagePath'] = _imagePath;
                // id 값 확인 및 로깅
                final id = updatedProduct['id'];
                print('수정된 상품 ID: $id');
                Navigator.pop(context, updatedProduct);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? PokemonColors.primaryBlue
                    : PokemonColors.primaryYellow,
                foregroundColor: isDarkMode
                    ? PokemonColors.primaryYellow
                    : PokemonColors.primaryRed,
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.save_rounded,
                    size: 20,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '저장',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    PokemonColors.backgroundDark,
                    PokemonColors.backgroundDark.withOpacity(0.8),
                  ]
                : [
                    PokemonColors.backgroundLight,
                    Colors.white,
                  ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 선택 및 미리보기
                _buildImagePreviewSection(isDarkMode),
                const SizedBox(height: 24),

                // 상품 정보 섹션
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? PokemonColors.cardDark
                        : PokemonColors.cardLight,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: isDarkMode
                          ? PokemonColors.primaryBlue.withOpacity(0.2)
                          : PokemonColors.primaryRed.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 섹션 타이틀
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: isDarkMode
                                ? PokemonColors.primaryYellow
                                : PokemonColors.primaryRed,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '상품 정보',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 상품명
                      _buildTextField(
                        controller: _nameController,
                        labelText: '상품명',
                        hintText: '상품명을 입력하세요',
                        icon: Icons.shopping_bag_outlined,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 16),

                      // 가격
                      _buildTextField(
                        controller: _priceController,
                        labelText: '상품가격',
                        hintText: '가격을 입력하세요',
                        icon: Icons.monetization_on_outlined,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        isDarkMode: isDarkMode,
                        prefix: '₩',
                      ),
                      const SizedBox(height: 16),

                      // 재고 수량
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.inventory_2_outlined,
                                  color: isDarkMode
                                      ? PokemonColors.primaryYellow
                                      : PokemonColors.primaryRed,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '수량',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 감소 버튼
                                InkWell(
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() {
                                        _quantity--;
                                      });
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.black26
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: isDarkMode
                                          ? PokemonColors.primaryYellow
                                          : PokemonColors.primaryRed,
                                    ),
                                  ),
                                ),

                                // 수량 표시
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.black12
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDarkMode
                                          ? Colors.grey.withOpacity(0.3)
                                          : Colors.grey.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    '$_quantity',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),

                                // 증가 버튼
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _quantity++;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isDarkMode
                                          ? Colors.black26
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: isDarkMode
                                          ? PokemonColors.primaryYellow
                                          : PokemonColors.primaryRed,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 설명
                      _buildTextField(
                        controller: _descController,
                        labelText: '설명',
                        hintText: '상품에 대한 설명을 입력하세요',
                        icon: Icons.description_outlined,
                        maxLines: 5,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreviewSection(bool isDarkMode) {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Container(
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? PokemonColors.cardDark : PokemonColors.cardLight,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: isDarkMode
                ? PokemonColors.primaryBlue.withOpacity(0.3)
                : PokemonColors.primaryRed.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 이미지 표시
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _imagePath != null
                      ? (_imageFile != null
                          ? Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            )
                          : CommonImg(
                              path: _imagePath!,
                              height: 300,
                              width: double.infinity,
                              boxFit: BoxFit.cover,
                            ))
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_rounded,
                                size: 70,
                                color: isDarkMode
                                    ? PokemonColors.primaryYellow
                                        .withOpacity(0.7)
                                    : PokemonColors.primaryRed.withOpacity(0.7),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '이미지를 선택하세요',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isDarkMode
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

              // 카메라 아이콘 오버레이
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? PokemonColors.primaryBlue.withOpacity(0.8)
                        : PokemonColors.primaryRed.withOpacity(0.8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? prefix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black12 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode
              ? Colors.grey.withOpacity(0.3)
              : Colors.grey.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 16,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(
            icon,
            color: isDarkMode
                ? PokemonColors.primaryYellow
                : PokemonColors.primaryRed,
          ),
          prefixText: prefix,
          prefixStyle: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
          ),
          labelStyle: TextStyle(
            color: isDarkMode ? Colors.grey : Colors.grey[700],
          ),
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode
                  ? Colors.transparent
                  : PokemonColors.primaryRed.withOpacity(0.1),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode
                  ? PokemonColors.primaryYellow
                  : PokemonColors.primaryRed,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // 가격 입력 시 쉼표 포맷팅 적용
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

  // 유효성 검증 오류 다이얼로그
  void _showValidationErrorDialog(BuildContext context, String message) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          ),
          child: FadeTransition(
            opacity: animation,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? PokemonColors.cardDark
                      : PokemonColors.cardLight,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: isDarkMode
                        ? PokemonColors.primaryBlue.withOpacity(0.3)
                        : PokemonColors.primaryRed.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 경고 아이콘
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.red.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 50,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 제목
                    Text(
                      '입력 오류',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 내용
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 확인 버튼
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? PokemonColors.primaryBlue
                              : PokemonColors.primaryYellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '확인',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
