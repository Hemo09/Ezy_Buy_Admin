import 'package:ezy_buy_adminn/features/dashboard/presenation/view/dashboard_page.dart';
import 'package:ezy_buy_adminn/features/dashboard/presenation/view/inner_screen/order/view/order_page.dart';
import 'package:ezy_buy_adminn/features/edit_product/data/models/prodcut_model.dart';
import 'package:ezy_buy_adminn/features/edit_product/presentaion/view/widgets/upload_product_screen.dart';
import 'package:ezy_buy_adminn/features/search_screen/presentaion/view/search_page.dart';
import 'package:go_router/go_router.dart';

class NamedRouteScreen {
  static const kDashboardScreen = "/";
  static const kEditProductScreen = "/kEditProductScreen";
  static const kOrderScreen = "/kOrderScreen";
  static const kSearchScreen = "/kSearchScreen";
}

class AppRoutes {
  static final routes = GoRouter(routes: [
    GoRoute(
      path: NamedRouteScreen.kDashboardScreen,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: NamedRouteScreen.kEditProductScreen,
      builder: (context, state) => UploadProduct(
        productModel: state.extra as ProductModel,
      ),
    ),
    GoRoute(
      path: NamedRouteScreen.kOrderScreen,
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: NamedRouteScreen.kSearchScreen,
      builder: (context, state) => SearchScreen(
        passedCategory: state.extra as String?,
      ),
    ),
  ]);
}
