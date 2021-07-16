import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/views/products_overview_screen.dart';

import 'auth_screen.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen();

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of(context);
    return auth.isAuth
        ? const ProductOverviewScreen()
        : //const AuthScreen();
        FutureBuilder(
            future: auth.autoSignin(),
            builder: (ctx, AsyncSnapshot<bool> snapshot) =>
                ConnectionState.waiting == snapshot.connectionState
                    ? const Center(child: CircularProgressIndicator())
                    : snapshot.data
                        ? const ProductOverviewScreen()
                        : const AuthScreen(),
          );
  }
}
