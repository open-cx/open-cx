import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/redux/action_creators.dart';
import 'package:open_cx/networking/view/Pages/secondary_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:toast/toast.dart';

class BluetoothBeaconSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(scanForDevices());
    return SecondaryPageView(
        child: StoreConnector<AppState, Map>(
      converter: (store) => store.state.content['bluetooth_devices'],
      builder: (BuildContext context, devices) {
        return ListView(
          children: buildDevices(context, devices),
        );
      },
    ));
  }

  buildDevices(BuildContext context, Map devices) {
    final List<Widget> children = List();
    children.add(Center(
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Text(
          'Choose an External Beacon',
          style: Theme.of(context).textTheme.body1.apply(fontWeightDelta: 2),
        ),
      ),
    ));
    devices.forEach((key, value) => {children.add(buildDevice(context, key))});
    return children;
  }

  Widget buildDevice(BuildContext context, key) {
    final query = MediaQuery.of(context).size;
    return Container(
      width: query.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.devices_other,
            size: query.width * 0.15,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            key,
            style: Theme.of(context).textTheme.body2,
          ),
          IconButton(
              icon: Icon(
                Icons.bluetooth,
                color: Theme.of(context).colorScheme.background,
              ),
              onPressed: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(selectNewDevice(key));
                Navigator.popUntil(context, ModalRoute.withName('/Settings'));
                Toast.show('Added $key as emitting device', context);
              })
        ],
      ),
    );
  }
}
