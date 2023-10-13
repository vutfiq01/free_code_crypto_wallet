import 'package:flutter/material.dart';
import 'package:free_code_crypto_wallet/constants/constants.dart';
import 'package:free_code_crypto_wallet/net/flutterfire.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    'bitcoin',
    'tether',
    'ethereum',
  ];

  String dropDownValue = 'bitcoin';

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton(
            value: dropDownValue,
            items: coins.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              },
            ).toList(),
            onChanged: (String? value) {
              setState(
                () {
                  dropDownValue = value!;
                },
              );
            },
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Coin Amount',
                labelStyle: TextStyle(color: kCryptoAppColor),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width / 1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: kCryptoAppColor,
            ),
            child: MaterialButton(
              onPressed: () async {
                await addCoin(dropDownValue, _amountController.text);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
