import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokemon_market/widgets/common_img.dart';
import 'package:pokemon_market/widgets/common_text.dart';

class EditProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _descController;
  File? _imageFile;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name'] ?? '');
    _priceController =
        TextEditingController(text: widget.product['price']?.toString() ?? '0');
    _quantityController = TextEditingController(
        text: widget.product['quantity']?.toString() ?? '0');
    _descController =
        TextEditingController(text: widget.product['description'] ?? '');
    _imagePath = widget.product['imagePath'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CommonText(
            text: '이미지 선택',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const CommonText(
                  text: '갤러리에서 선택',
                  fontSize: 16,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const CommonText(
                  text: '카메라로 촬영',
                  fontSize: 16,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: '상품 수정',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedProduct = Map<String, dynamic>.from(widget.product);
              updatedProduct['name'] = _nameController.text;
              updatedProduct['price'] =
                  int.tryParse(_priceController.text) ?? 0;
              updatedProduct['quantity'] =
                  int.tryParse(_quantityController.text) ?? 0;
              updatedProduct['description'] = _descController.text;
              updatedProduct['imagePath'] = _imagePath;
              // id 값 확인 및 로깅
              final id = updatedProduct['id'];
              print('수정된 상품 ID: $id');
              Navigator.pop(context, updatedProduct);
            },
            child: const CommonText(
              text: '저장',
              fontSize: 20,
              textColor: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 선택 및 미리보기 (세로 길이 증가)
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  height: 500, //
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imagePath != null
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
                      : const Center(
                          child: CommonText(
                            text: '이미지를 선택하세요',
                            fontSize: 16,
                            textColor: Colors.grey,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              // 상품명
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  label: CommonText(
                    text: '상품명',
                    fontSize: 14,
                    textColor: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // 가격
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  label: CommonText(
                    text: '가격',
                    fontSize: 14,
                    textColor: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // 재고 수량
              TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  label: CommonText(
                    text: '재고 수량',
                    fontSize: 14,
                    textColor: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // 설명
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  label: CommonText(
                    text: '설명',
                    fontSize: 14,
                    textColor: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
