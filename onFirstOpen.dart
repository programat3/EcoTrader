import 'package:enviromental_friendly/main.dart';
import 'package:enviromental_friendly/tool/toolRoulette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';


class OnFirstOpen extends StatelessWidget {
  final avaibleTools;
  const OnFirstOpen(this.avaibleTools);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
        onPopInvoked: (didPop){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyNavigation(width, height)));
        },
        child: MaterialApp(
        localizationsDelegates: const [I18nGoogleWallet.delegate],
      home: 
        Container(
          color: Colors.blueGrey,
          child: ToolPickerRoulette(avaibleTools, true)),
      ),
    );
  }
}