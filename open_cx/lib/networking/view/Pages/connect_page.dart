
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:open_cx/networking/controller/micro_bit.dart';
import 'package:open_cx/networking/model/user.dart';

class ConnectionsPage extends StatefulWidget {

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectionsPage> {
  static MicroBit microbit = new MicroBit();
  static List<int> _idsList = new List<int>();
  static bool _active = false;
  static BluetoothState _bluetoothState;
  static List<User> _connections = <User>[];

  @override
  void initState() {
    if (microbit.isConnected()) {
      microbit.subscribe(_onData);
    }
    super.initState();
  }

  Widget _buildConnections() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _connections.length,
      itemBuilder: (context, i) {
        return _buildRow(_connections[i]);
      },
    );
  }

  void _onData(List<int> bytesRead) {
    const int IdFlag = 36;

    List<int> id = new List<int>();

    for (final int byte in bytesRead) {
      if (byte == IdFlag) {
        int newId = int.parse(utf8.decode(id));
        if (!_idsList.contains(newId)) {
         /* _db.getUser(newId).then((user) {
            if (user.id != -1) {
              setState(() {
                _connections.add(user);
                _idsList.add(newId);
              });
            }
          });
          print('New id received: $newId');*/
        }
        id.clear();
      } else
        id.add(byte);
    }
  }

  Widget _buildRow(User user) {
    return ExpansionTile(
      leading: CircleAvatar(
        child: Container(),
        radius: 25.0,
      ),
      title: Text(user.name),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: Text('Interests: '),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text(
            user.interests.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildBluetoothOn() {
    if (_active) return _buildConnections();

    return Center(
      child: Text(
        'Connections disabled',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _buildBluetoothOff() {
    if (microbit.isConnected() && _bluetoothState == BluetoothState.off) {
      _idsList.clear();
      _connections.clear();

      print('Disconnecting Micro:bit');
      microbit.disconnect().then((a) => print('Micro:bit Disconnected'));
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.bluetooth_disabled,
            size: 200.0,
            color: Colors.blue,
          ),
          Text(
            'Bluetooth Adapter is ${_bluetoothState.toString().substring(15)}.',
            style: Theme.of(context)
                .primaryTextTheme
                .subhead
                .copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Future<String> _microbitDialog(BuildContext context) {
    if (!microbit.isConnected() && _bluetoothState == BluetoothState.on) {
      TextEditingController _controller = TextEditingController();

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Insert your Micro:Bit name'),
            content: TextField(
              autofocus: true,
              controller: _controller,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text.toLowerCase());
                },
                child: Text('Connect'),
              ),
            ],
          );
        },
      );
    }

    return Future.value(null);
  }

  Future<void> _errorDialog(BuildContext context, String errorMessage) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
      stream: FlutterBlue.instance.state,
      initialData: BluetoothState.unknown,
      builder: (c, snapshot) {
        _bluetoothState = snapshot.data;
        if (_bluetoothState == BluetoothState.off) _active = false;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            actions: <Widget>[
              Switch(
                value: _active,
                activeColor: Colors.teal,
                onChanged: (_bluetoothState == BluetoothState.off)
                    ? null
                    : (value) {
                        if (value && !microbit.isConnected()) {
                          _microbitDialog(context).then((name) {
                            print('Connecting...');
                            if (name != null && name != '') {
                              microbit.connect(context, name).then((connected) {
                                if (connected) {
                                  print('Connection Successful');
//                                  microbit
//                                      .writeTo(_db.getID())
//                                      .then((a) => microbit.subscribe(_onData));
                                } else {
                                  print('Connection failed');
                                  _errorDialog(context,
                                      'Microbit with name $name is not accessible. Please try again!')
                                      .then((id) { setState(() {
                                        _active = false;
                                      });});
                                }
                              });
                            } else {
                              //Comment to mock users
                              setState(() {
                                _active = false;
                              });
                            }
                          });
                        }
                        setState(() => _active = value);
                      },
              ),
            ],
          ),
          body: (_bluetoothState == BluetoothState.on)
              ? _buildBluetoothOn()
              : _buildBluetoothOff(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: (_bluetoothState == BluetoothState.on && _active)
                ? Colors.purple
                : Colors.grey,
            elevation: 2.0,
            child: Icon(Icons.refresh),
            onPressed: (_bluetoothState == BluetoothState.on && _active)
                ? () => setState(() {
                    _idsList.clear();
                    _connections.clear();
                    print('clicked');
                  })
                : null,
          )
        );
      },
    );
  }

  Widget pairButton(int id) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Center(
          child: RaisedButton(
            elevation: 5,
            disabledColor: Colors.teal,
            padding: EdgeInsets.all(8.0),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
            ),
//            onPressed: () => _db.addFriend(id),
            child:
            Text("PAIR", style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
    );
  }
}
