import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/custom_route.dart';
import 'package:shop/views/auth_screen.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/home_screen.dart';
import 'package:shop/views/orders_screen.dart';
import 'package:shop/views/product_datail_screen.dart';
import 'package:shop/views/product_form_screen.dart';
import 'package:shop/views/products_overview_screen.dart';
import 'package:shop/views/products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(),
            update: (_, auth, products) => Products(
                  auth.token,
                  auth.localId,
                  products.items,
                )),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(),
            update: (_, auth, orders) => Orders(
                  auth.token,
                  auth.localId,
                  orders.items,
                )),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            TargetPlatform.android: CustomPageTransitionsBuilder(),
          }),
        ),
        home: const HomeScreeen(),
        routes: {
          AppRoutes.AUTH: (_) => const AuthScreen(),
          AppRoutes.HOME: (_) => const ProductOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (_) => const ProductDetailScreen(),
          AppRoutes.PRODUCT_FORM: (_) => const ProductScreen(),
          AppRoutes.CART_DETAIL: (_) => const CartScreen(),
          AppRoutes.ORDERS: (_) => const OrdersScreen(),
          AppRoutes.PRODUCTS: (_) => const ProductsScreen(),
        },
      ),
    );
  }
}
