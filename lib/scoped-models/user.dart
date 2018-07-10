import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import './connected-products.dart';

class UserModel extends ConnectedProducts {
  void login(String email, String password) {
    authenticatedUser = User(id: 'asdas', email: email, password: password);
  }
}
