import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


String getTenantId() {
  return "1337";
}

final Center tenantWidget = Center(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tenant Id: ", style: TextStyle(fontSize: 20)),
          Text(getTenantId(), style: TextStyle(fontSize: 20)),
        ])
);

final myController = TextEditingController();


class UserIdWidget extends StatefulWidget {

  @override
  _UserIdWidgetState createState() => _UserIdWidgetState();

}

class _UserIdWidgetState extends State<UserIdWidget> {
  final userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    userIdController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    userIdController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Text field value: ${userIdController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child:
              Text("User Id: ", style: TextStyle(fontSize: 20))),
              Flexible(child:
              TextField(
                controller: userIdController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a User ID'
                ),
              )
              ),
            ])
    );
  }

}

final Center userActivityWidget = Center(
    child: Column(children: [
      Text("id"),
      Text("lastActivityAt"),
      Text("firstActivityAt"),
    ],)
);

final Column userScreenWidget = Column(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: <Widget>[tenantWidget, UserIdWidget(), userActivityWidget],
);