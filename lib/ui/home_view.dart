import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:free_code_crypto_wallet/constants/constants.dart';
import 'package:free_code_crypto_wallet/net/api_methods.dart';
import 'package:free_code_crypto_wallet/net/flutterfire.dart';
import 'package:free_code_crypto_wallet/ui/add_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double tether = 0.0;
  double ethereum = 0.0;

  @override
  void initState() {
    getValues();
    super.initState();
  }

  getValues() async {
    bitcoin = await getPrice('bitcoin');
    tether = await getPrice('tether');
    ethereum = await getPrice('ethereum');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == 'bitcoin') {
        return bitcoin * amount;
      } else if (id == 'tether') {
        return tether * amount;
      } else {
        return ethereum * amount;
      }
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('Coins')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map(
                  (document) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: kCryptoAppColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Coin: ${document.id.toUpperCase()}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    '\$${getValue(
                                      document.id,
                                      document['Amount'],
                                    ).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () async {
                                  await sellCoin(document.id);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[700]),
                                ),
                                child: const Text(
                                  'SELL',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddView()));
        },
        backgroundColor: kCryptoAppColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
