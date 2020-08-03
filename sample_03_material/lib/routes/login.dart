import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  Image.asset('assets/diamond.png'),
                  SizedBox(height: 16),
                  Text('界面布局示例'),
                ],
              ),
              SizedBox(height: 100),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(filled: true, labelText: '用户名：'),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(filled: true, labelText: '密 码：'),
                obscureText: true,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('取消'),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  RaisedButton(
                    child: Text('登录'),
                    onPressed: () {
                      if (_usernameController.text.trim() == 'admin' &&
                          _passwordController.text == '123') {
                        Navigator.pop(context);
                      } else {
                        print('用户名或密码错误。');
                      }
                    },
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
