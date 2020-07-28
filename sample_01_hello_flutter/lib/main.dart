import 'package:flutter/material.dart';
// 引入 english_word 包
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hello Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('第一个 Flutter App'),
        ),
        body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }
}

class RandomWordsState extends State {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        itemBuilder: (BuildContext _context, int i) {
          // 奇数行返回分割线
          if (i.isOdd) {
            return new Divider();
          }

          final idx = i ~/ 2; // ~/ 表示除以 2 的商
          print('Item Builder $idx');

          return new ListTile(title: new Text(idx.toString()));
        },
        padding: EdgeInsets.all(16.0));
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
