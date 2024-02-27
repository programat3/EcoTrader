import 'package:enviromental_friendly/aes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';


class GetNewTool extends StatefulWidget {
  final tool_name;
  final flutterGoogleWalletPlugin = FlutterGoogleWalletPlugin();
  
  GetNewTool(this.tool_name);

  @override
  State<GetNewTool> createState() => _GetNewToolState();
}

class _GetNewToolState extends State<GetNewTool> {

  late Future<bool> _isWalletAvailable;

  @override
  void initState() {
    super.initState();
    _isWalletAvailable = Future(() async {
      await widget.flutterGoogleWalletPlugin.initWalletClient();
      return widget.flutterGoogleWalletPlugin.getWalletApiAvailabilityStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
       Center(
          child: Column(
            children: [
              FutureBuilder<bool>(
                future: _isWalletAvailable,
                builder: (BuildContext context, AsyncSnapshot<bool> available) {
                  if (available.data == true) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: SvgPicture.asset('assets/buttons/enUS_add_to_google_wallet_wallet-button.svg'),
                          onPressed: () {
                            widget.flutterGoogleWalletPlugin.savePasses(
                                jsonPass: allPasses[widget.tool_name],
                                addToGoogleWalletRequestCode: 2);
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        );
  }
}
final allPasses = [_pointerPass,_glovesPass,_magnetPass,_pliersPass,_cameraPass];
final iat = DateTime.now().millisecondsSinceEpoch ~/ 1000;

""";
