import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';
import '../style.dart';

const double _kDateTimePickerHeight = 218;

class ShoppingCartTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) => Consumer<AppStateModel>(
        builder: (context, model, child) => CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('购物车'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            ),
          ],
        ),
      );

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate((context, index) {
      if (index > 3) {
        return null;
      }
      if (index == 3) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: _buildDateTimePicker(context),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildTextField(index),
      );
    });
  }

  Widget _buildDateTimePicker(BuildContext context) => Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    CupertinoIcons.clock,
                    color: CupertinoColors.lightBackgroundGray,
                    size: 28,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '发货日期',
                    style: Styles.deliveryTimeLabel,
                  )
                ],
              ),
              Text(
                DateFormat.yMd().format(dateTime),
                style: Styles.deliveryTimeLabel,
              ),
            ],
          ),
          Container(
            height: _kDateTimePickerHeight,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: dateTime,
              onDateTimeChanged: (value) {
                setState(() {
                  dateTime = value;
                });
              },
            ),
          ),
        ],
      );

  CupertinoTextField _buildTextField(int index) {
    if (index > 2) {
      return null;
    }

    String placeholder = '请输入';
    IconData icon;

    if (index == 0) {
      placeholder += '姓名';
      icon = CupertinoIcons.person_solid;
    } else if (index == 1) {
      placeholder += '邮箱';
      icon = CupertinoIcons.mail_solid;
    } else {
      placeholder += '地址';
      icon = CupertinoIcons.location_solid;
    }

    return CupertinoTextField(
      prefix: Icon(
        icon,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      autocorrect: false,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0, color: CupertinoColors.inactiveGray),
        ),
      ),
      placeholder: placeholder,
    );
  }
}
