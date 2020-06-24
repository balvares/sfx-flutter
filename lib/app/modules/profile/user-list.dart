import 'package:flutter/material.dart';
import 'package:suflex/app/modules/profile/models/users.dart'; 
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class UserList extends StatefulWidget {

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  List _users = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildListTile(Users user) {

    final Text tText = Text(
      user.nome,
      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
    );

    final Text sText = Text(
      user.username,
      style: TextStyle(color: Colors.black45),
    );

    return ListTile(
      title: tText,
      subtitle: sText,
      trailing: Icon(FeatherIcons.arrowRight),
      onTap: () => {}, // todo
    );
  }

  Widget _buildListView() {

    final List list = [];

    _users.forEach((user) {
      list.add(_buildListTile(user));
    });

    return ListView.separated(
      itemCount: list.length, 
      padding: EdgeInsets.only(bottom: 80.0),
      itemBuilder: (BuildContext context, int index) => Divider(), 
      separatorBuilder: (BuildContext context, int index) => Divider(),
    ); 
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: _buildListView(),
    );
  }
}