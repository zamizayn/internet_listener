import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off),
              SizedBox(
                height: 10,
              ),
              Text(
                'No Internet Connection',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Looks like your internet is not available. Please try switching your mobile data or Wi-Fi connection, or check your network settings and try again.",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
