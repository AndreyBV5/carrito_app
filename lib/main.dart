import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Carrito de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Carrito de Compras'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;
  late CartController _cartController;

  @override
  void initState() {
    super.initState();
    _cartController = Get.put(CartController());
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.cleaning_services),
              onPressed: () {
                _cartQuantityItems = 0;
                cartKey.currentState!.runClearCartAnimation();
              },
            ),
            const SizedBox(width: 16),
            AddToCartIcon(
              key: cartKey,
              icon: const Icon(Icons.shopping_cart),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: ListView(
          children: List.generate(
            _products.length,
            (index) => AppListItem(
              onClick: listClick,
              index: index,
              product: _products[index],
            ),
          ),
        ),
      ),
    );
  }

  void listClick(GlobalKey widgetKey, Product product) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
    _cartController.addToCart(product);
  }
}

class AppListItem extends StatefulWidget {
  final GlobalKey widgetKey = GlobalKey();
  final int index;
  final void Function(GlobalKey, Product) onClick;
  final Product product;

  AppListItem({
    super.key,
    required this.onClick,
    required this.index,
    required this.product,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AppListItemState createState() => _AppListItemState();
}

class _AppListItemState extends State<AppListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        key: widget.widgetKey,
        width: 60,
        height: 60,
        color: Colors.transparent,
        child: Icon(widget.product.icon),
      ),
      title: Text(widget.product.name),
      subtitle: Text('₡${widget.product.price.toStringAsFixed(0)}'),
      trailing: ElevatedButton(
        onPressed: () {
          widget.onClick(widget.widgetKey, widget.product);
        },
        child: Text('Agregar al carrito'),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final IconData icon;

  Product(this.name, this.price, this.icon);
}

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItems.add(product);
  }

  int get cartCount => cartItems.length;
}

final List<Product> _products = [
  Product('Pollo a la Naranja', 6000, Icons.restaurant_menu),
  Product('Pescado al Ajillo', 4500, Icons.restaurant_menu),
  Product('Spaghetti Bolognese', 5000, Icons.restaurant_menu),
  Product('Hamburguesa con Papas', 2500, Icons.restaurant_menu),
  Product('Chifrijo', 3000, Icons.restaurant_menu),
  Product('Carne en Salsa', 4000, Icons.restaurant_menu),
];