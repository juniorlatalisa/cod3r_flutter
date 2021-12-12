import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).load(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Text('Nenhum local cadastrado'),
                    builder: (ctx, gp, ch) => gp.count == 0
                        ? Center(child: ch)
                        : ListView.builder(
                            itemCount: gp.count,
                            itemBuilder: (ctx, i) {
                              final item = gp.get(i);
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(item.image),
                                ),
                                title: Text(item.title),
                                subtitle: Text(item.location.address),
                                onTap: () => Navigator.of(context).pushNamed(
                                  AppRoutes.PLACE_DETAIL,
                                  arguments: item,
                                ),
                              );
                            },
                          ),
                  ),
      ),
    );
  }
}
