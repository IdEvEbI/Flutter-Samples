import 'package:flutter/material.dart';
// 引入 english_word 包
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.green), home: RandomWords());
  }
}

class RandomWordsState extends State {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _listTitleStyle = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('单词列表'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final list = _saved.map(
          (e) => ListTile(title: Text(e.asPascalCase, style: _listTitleStyle)));
      final children =
          ListTile.divideTiles(tiles: list, context: context).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('收藏单词'),
        ),
        body: ListView(children: children, padding: EdgeInsets.all(16)),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        itemBuilder: (BuildContext _context, int i) {
          // 奇数行返回分割线
          if (i.isOdd) {
            return Divider();
          }

          final idx = i ~/ 2; // ~/ 表示除以 2 的商

          // 缓冲 10 个单词对
          if (idx >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          print('Item Builder $idx - ' + _suggestions[idx].asPascalCase);
          return _buildRow(_suggestions[idx]);
        },
        padding: EdgeInsets.all(16));
  }

  Widget _buildRow(WordPair pair) {
    final bool alreaySaved = _saved.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: _listTitleStyle),
      trailing: Icon(
        alreaySaved ? Icons.favorite : Icons.favorite_border,
        color: alreaySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreaySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
