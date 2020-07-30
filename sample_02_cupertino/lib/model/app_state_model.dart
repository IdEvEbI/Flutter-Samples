import 'package:flutter/foundation.dart' as foundation;

import 'product.dart';
import 'products_repository.dart';

double _salesTaxRate = 0.06;
double _shippingCostPerItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  // 所有可用商品
  List<Product> _availableProducts;

  /// 当前选中商品类别
  Category _selectedCategory = Category.all;

  /// 当前购物车信息：IDs 和数量
  final _productsInCart = <int, int>{};

  Category get selectedCategory => _selectedCategory;
  Map<int, int> get productsInCart => Map.from(_productsInCart);

  /// 购物车中的商品总数
  int get totalCartQuantity => _productsInCart.values
      .fold(0, (previousValue, element) => previousValue + element);

  /// 购物车商品金额
  double get subtotalCost => _productsInCart.keys
      .map((id) => getProductById(id).price * _productsInCart[id])
      .fold(0, (previousValue, element) => previousValue + element);

  /// 购物车商品运费
  double get shippingCost =>
      _shippingCostPerItem *
      _productsInCart.values
          .fold(0.0, (previousValue, element) => previousValue + element);

  /// 购物车商品销售税
  double get tax => subtotalCost * _salesTaxRate;

  /// 购物车商品总金额（含运费和税）
  double get totalCost => subtotalCost + shippingCost + tax;

  /// 返回可用商品列表的副本（使用 category 过滤）
  List<Product> getProducts() {
    if (_availableProducts == null) {
      return [];
    }

    if (_selectedCategory == Category.all) {
      return List.from(_availableProducts);
    } else {
      return _availableProducts
          .where((p) => p.category == _selectedCategory)
          .toList();
    }
  }

  /// 搜索商品类目
  List<Product> search(String searchTerms) => getProducts()
      .where((product) =>
          product.name.toLowerCase().contains(searchTerms.toLowerCase()))
      .toList();

  /// 添加一个商品到购物车
  void addProductToCart(int productId) {
    _productsInCart[productId] = _productsInCart.containsKey(productId)
        ? _productsInCart[productId] + 1
        : 1;

    notifyListeners();
  }

  /// 从购物车删除一个商品
  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId]--;
      }
    }

    notifyListeners();
  }

  /// 按 ID 获取商品
  Product getProductById(int id) =>
      _availableProducts.firstWhere((p) => p.id == id);

  /// 清空购物车
  void clearCart() {
    _productsInCart.clear();

    notifyListeners();
  }

  /// 加载所有可用商品列表
  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(Category.all);

    notifyListeners();
  }

  /// 设置选中的分类
  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;

    notifyListeners();
  }
}
