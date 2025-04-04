import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon_market/pages/card_trade_list.dart';
import 'package:pokemon_market/widgets/common_appbar.dart';
import 'package:pokemon_market/widgets/home_page/home_page_list.dart';
import 'package:pokemon_market/pages/product_add_page.dart';
import 'package:pokemon_market/theme/theme_manager.dart';
import 'package:pokemon_market/theme/custom_theme.dart';
import 'package:pokemon_market/pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> products = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductAddPage()),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        products.add(result);
      });
    }
  }

  void _showProductListScreen() async {
    final result = await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ProductListScreen(
          products: products,
          onAddProduct: () async {
            final newProduct = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductAddPage()),
            );
            if (newProduct != null && newProduct is Map<String, dynamic>) {
              setState(() {
                products.add(newProduct);
              });
              return newProduct;
            }
            return null;
          },
        ),
      ),
    );

    if (result != null && result is List<Map<String, dynamic>>) {
      setState(() {
        products = List.from(result);
      });
    }
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        onBackPressed: null,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDarkMode
                  ? 'assets/dark_pokeballs_bg.png'
                  : 'assets/light_pokeballs_bg.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? PokemonColors.primaryYellow.withOpacity(0.3)
                              : PokemonColors.primaryRed.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/pika.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              '포켓몬 마켓',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? PokemonColors.primaryYellow
                    : PokemonColors.primaryBlue,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: isDarkMode
                        ? PokemonColors.primaryYellow.withOpacity(0.5)
                        : PokemonColors.primaryBlue.withOpacity(0.5),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? PokemonColors.cardDark
                    : PokemonColors.cardLight,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black45 : Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildButton(
                    icon: Icons.shopping_bag_rounded,
                    label: '상품 목록',
                    color: PokemonColors.primaryRed,
                    onTap: _showProductListScreen,
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    icon: Icons.shopping_cart_rounded,
                    label: '장바구니',
                    color: PokemonColors.primaryBlue,
                    onTap: _navigateToCart,
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    icon: Icons.swap_horiz_rounded,
                    label: '카드 교환',
                    color: PokemonColors.primaryYellow,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => CardTradeList()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: color.withOpacity(0.2),
        highlightColor: color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                color.withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Future<Map<String, dynamic>?> Function() onAddProduct;

  const ProductListScreen({
    Key? key,
    required this.products,
    required this.onAddProduct,
  }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late List<Map<String, dynamic>> _localProducts;

  @override
  void initState() {
    super.initState();
    _localProducts = List<Map<String, dynamic>>.from(widget.products);
  }

  void _handleAddProduct() async {
    final newProduct = await widget.onAddProduct();
    if (newProduct != null) {
      setState(() {
        _localProducts.add(newProduct);
      });
    }
  }

  void _handleDelete(String? productId) { // String?로 변경
    setState(() {
      _localProducts.removeWhere((product) => product['id']?.toString() == productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      appBar: CommonAppbar(
        isDarkMode: isDarkMode,
        toggleTheme: themeManager.toggleTheme,
        onBackPressed: () => Navigator.of(context).pop(_localProducts),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDarkMode
                  ? 'assets/dark_pokeballs_bg.png'
                  : 'assets/light_pokeballs_bg.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? PokemonColors.cardDark
                    : PokemonColors.cardLight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black45 : Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag_rounded,
                    color: isDarkMode
                        ? PokemonColors.primaryYellow
                        : PokemonColors.primaryRed,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '상품 목록',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? PokemonColors.primaryYellow.withOpacity(0.2)
                          : PokemonColors.primaryRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_localProducts.length}개',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? PokemonColors.primaryYellow
                            : PokemonColors.primaryRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: HomePageList(
                products: _localProducts,
                onAddProduct: _handleAddProduct,
                onDelete: _handleDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}