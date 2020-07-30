import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'search_bar.dart';
import '../style.dart';

/// 搜索标签页
class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchTabState();
}

/// 搜索标签状态
class _SearchTabState extends State<SearchTab> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController()
      ..addListener(() {
        setState(() {
          _terms = _controller.text;
        });
      });
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: SearchBar(
                controller: _controller,
                focusNode: _focusNode,
              ),
            )
          ],
        ),
      ),
    );
  }
}
