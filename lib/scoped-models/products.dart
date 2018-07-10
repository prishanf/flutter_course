import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import './connected-products.dart';

class ProductsModel extends ConnectedProducts {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (selProductIndex == null) {
      return null;
    }
    return products[selProductIndex];
  }

/*void addProduct(Product product) {
    products.add(product);
    selectedProductIndex = null;
  }*/
  
  void updateProduct( String title, String description, double price, String image) {
    final updateProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: authenticatedUser.email,
        userId: authenticatedUser.id);
    products[selProductIndex] = updateProduct;
    selProductIndex = null;
  }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    selProductIndex = null;
  }

  void toggleProductFavoriteStatus() {
    print(toggleProductFavoriteStatus);
    print(products[selProductIndex].isFavorite);
    final bool isCurrentlyFavorite = products[selProductIndex].isFavorite;
    final bool newFavouriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavouriteStatus);
    products[selProductIndex] = updateProduct;
    print(products[selProductIndex].isFavorite);
    selProductIndex = null;

    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
