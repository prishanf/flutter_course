import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  String _selProductId;
  bool _isLoading = false;

  Future<bool> addProduct(
      String title, String description, double price, String image) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://i.ndtvimg.com/i/2015-06/chocolate_625x350_81434346507.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    try {
      final http.Response response = await http.post(
          'https://pns-inventory-manager.firebaseio.com/products.json',
          body: json.encode(productData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
    // }).catchError((errror) {
    //   _isLoading = false;
    //   notifyListeners();
    //   return false;
    // });
    // ;
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (_selProductId == null) {
      return null;
    }
    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

/*void addProduct(Product product) {
    products.add(product);
    selectedProductIndex = null;
  }*/

  Future<Null> updateProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image':
          'https://i.ndtvimg.com/i/2015-06/chocolate_625x350_81434346507.jpg',
      'price': price,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    print('before http call');
    print(updateData);

    return http
        .put(
            'https://pns-inventory-manager.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      final updateProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products[selectedProductIndex] = updateProduct;
      notifyListeners();
    }).catchError((errror) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;
    final deletedProduct = selectedProduct.id;
    _products.removeAt(selectedProductIndex);
    _selProductId = null;
    notifyListeners();
    return http
        .delete(
      'https://pns-inventory-manager.firebaseio.com/products/${deletedProduct}.json',
    )
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((errror) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchPruducts() {
    _isLoading = true;
    notifyListeners();
    return http
        .get("https://pns-inventory-manager.firebaseio.com/products.json")
        .then<Null>((http.Response response) {
      final List<Product> fetchedProductList = [];
      print((json.decode(response.body)));
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData != null) {
        productListData.forEach((String productId, dynamic productData) {
          final Product product = Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              image: productData['image'],
              price: productData['price'],
              userEmail: productData['userEmail'],
              userId: productData['userId']);
          fetchedProductList.add(product);
        });
        _products = fetchedProductList;
      }
      _isLoading = false;
      notifyListeners();
      //_selProductId = null;
    }).catchError((errror) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = _products[selectedProductIndex].isFavorite;
    final bool newFavouriteStatus = !isCurrentlyFavorite;
    final Product updateProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavouriteStatus);
    _products[selectedProductIndex] = updateProduct;
    notifyListeners();
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: 'asdas', email: email, password: password);
  }

  Future<Map<String, dynamic>> signup(String email, String password) async {
    _isLoading =true;
    notifyListeners();
    String apiKey = 'AIzaSyA3LJnT-daYPmoyuQ5eBXeoXrxsZU-7LoQ';
    String endpoint =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${apiKey}';
    Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    Map<String, String> headers = {'Content-Type': 'application/json'};
    http.Response response = await http.post(endpoint,
        body: json.encode(authData), headers: headers);
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something Went wrong';
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists';
    }
     _isLoading =false;
    notifyListeners(); 
    return {'success': !hasError, 'message': message};
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
