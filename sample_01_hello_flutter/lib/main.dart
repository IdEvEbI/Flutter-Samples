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
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _listTitleStyle = const TextStyle(fontSize: 20);

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

          // 缓冲 10 个单词对
          if (idx >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          print('Item Builder $idx - ' + _suggestions[idx].asPascalCase);
          return _buildRow(_suggestions[idx]);
        },
        padding: EdgeInsets.all(16.0));
  }

  Widget _buildRow(WordPair pair) {
    final bool alreaySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(pair.asPascalCase, style: _listTitleStyle),
      trailing: new Icon(
        alreaySaved ? Icons.favorite : Icons.favorite_border,
        color: alreaySaved ? Colors.red : null,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
