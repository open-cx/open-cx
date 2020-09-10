import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/view/Pages/secondary_page_view.dart';
import 'package:open_cx/networking/redux/action_creators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:toast/toast.dart';

class SetBeaconPage extends StatefulWidget {
  @override
  _SetBeaconPageState createState() => _SetBeaconPageState();
}

class _SetBeaconPageState extends State<SetBeaconPage> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    return SecondaryPageView(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.only(
                  top: query.height * 0.03, bottom: query.height * 0.04),
              child: Text('Choose a beacon',
                  style: Theme.of(context).textTheme.body1),
            ),
          ),
          buildOption(Icons.phonelink_ring, 'YOUR PHONE', 0),
          Center(
            child: Text(
              'OR',
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .apply(fontSizeDelta: -5, fontWeightDelta: 2),
            ),
          ),
          buildOption(Icons.watch, 'EXTERNAL BEACON', 1),
          buildButton()
        ],
      ),
    );
  }

  buildOption(IconData icon, String text, int value) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2  ),
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.body2,
          ),
          Radio(
            activeColor: Theme.of(context).colorScheme.primary,
            value: value,
            groupValue: this.value,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
            },
          )
        ],
      ),
    );
  }

  buildButton() {
    return FlatButton(
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          'Continue',
          style: Theme.of(context).textTheme.button.apply(fontSizeDelta: -5),
        ),
      ),
      onPressed: () {
        if(value == 0){
          StoreProvider.of<AppState>(context).dispatch(selectOwnDevice());
          Navigator.popUntil(context, ModalRoute.withName('/Settings'));
          Toast.show('Added own device as emitting service', context);
        } else{
          Navigator.pushNamed(context, '/BluetoothBeaconSelection');
        }
      },
    );
  }
}
