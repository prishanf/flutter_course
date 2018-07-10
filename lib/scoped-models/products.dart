import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  bool _showFavorites = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void toggleProductFavoriteStatus() {
    print(toggleProductFavoriteStatus);
    print(_products[_selectedProductIndex].isFavorite);
    final bool isCurrentlyFavorite =
        _products[_selectedProductIndex].isFavorite;
    final bool newFavouriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavouriteStatus);
    _products[_selectedProductIndex] = updateProduct;
    print(_products[_selectedProductIndex].isFavorite);
    _selectedProductIndex = null;

    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
