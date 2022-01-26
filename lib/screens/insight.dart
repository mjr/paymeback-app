import 'package:flutter/material.dart';

import 'package:paymeback/auth/provider.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 40,
              ),
              const Text(
                'Insights',
                textAlign: TextAlign.center,
              ),
              IconButton(
                  onPressed: () {
                    final auth = AuthProvider();
                    auth.setUser(context, null);
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 196,
                  width: 196,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                      width: 3,
                      color: Colors.green,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "R\$ 50,00",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
