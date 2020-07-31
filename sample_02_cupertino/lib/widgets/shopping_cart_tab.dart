import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';

class ShoppingCartTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  @override
  Widget build(BuildContext context) => Consumer<AppStateModel>(
        builder: (context, model, child) => CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('购物车'),
            ),
          ],
        ),
      );
}
