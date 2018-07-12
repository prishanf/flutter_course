import 'package:scoped_model/scoped_model.dart';
import './connected-products.dart';

class MainModel extends Model with ConnectedProductsModel, ProductsModel, UserModel,UtilityModel {}
