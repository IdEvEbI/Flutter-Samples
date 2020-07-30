import 'package:flutter/material.dart';

/// 搜索条
class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBar({
    @required this.controller,
    @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.red,
        height: 64,
      );
}
