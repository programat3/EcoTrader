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

final pliersData = """
{
   "type": "Paper"
}
""";
final String plierEncryptedData = EncryptData.encryptAES(pliersData, "inv3ncion2024.03");
final String _pliersPass = """
{
    "iss": "enviromentalfriendly@enviromentalfriendly.iam.gserviceaccount.com",
    "iat": $iat,
    "aud": "google",
    "typ": "savetowallet",
    "origins": [],
    "payload": {
        "genericObjects": [ {

  "id": "3388000000022319375.PLIERS003",
  "classId": "3388000000022319375.tool",
  "cardTitle": {
    "defaultValue": {
      "language": "en-US",
      "value": "You Got a new Tool"
    }
  },
  "header": {
    "defaultValue": {
      "language": "en-US",
      "value": "Pliers"
    }
  },
  "textModulesData": [
    {
      "id": "useful_for",
      "header": "Useful for",
      "body": "Paper"
    }
  ],
  "barcode": {
    "type": "QR_CODE",
    "value": "$plierEncryptedData",
    "alternateText": ""
  },
  "hexBackgroundColor": "#8FAA74",
  "heroImage": {
    "sourceUri": {
      "uri": "https://inv3ncion.cl/images/googleImages/Paper.png"
    }
  }
}
   ]
    }
  }
""";
final glovessData = """
{
   "type": "Glass"
}
""";
final String glovesEncryptedData = EncryptData.encryptAES(glovessData, "inv3ncion2024.03");
final String _glovesPass = """
{
    "iss": "enviromentalfriendly@enviromentalfriendly.iam.gserviceaccount.com",
    "iat": $iat,
    "aud": "google",
    "typ": "savetowallet",
    "origins": [],
    "payload": {
        "genericObjects": [ {

  "id": "3388000000022319375.GLOVES003",
  "classId": "3388000000022319375.tool",
  "cardTitle": {
    "defaultValue": {
      "language": "en-US",
      "value": "You Got a new Tool"
    }
  },
  "header": {
    "defaultValue": {
      "language": "en-US",
      "value": "Gloves"
    }
  },
  "textModulesData": [
    {
      "id": "useful_for",
      "header": "Useful for",
      "body": "Glass"
    }
  ],
  "barcode": {
    "type": "QR_CODE",
    "value": "$glovesEncryptedData",
    "alternateText": ""
  },
  "hexBackgroundColor": "#FF92D5",
  "heroImage": {
    "sourceUri": {
      "uri": "https://inv3ncion.cl/images/googleImages/Glass.png"
    }
  }
}
   ]
    }
  }
""";
final pointerData = """
{
   "type": "Plastic"
}
""";
final String pointerEncryptedData = EncryptData.encryptAES(pointerData, "inv3ncion2024.03");
final String _pointerPass = """
{
    "iss": "enviromentalfriendly@enviromentalfriendly.iam.gserviceaccount.com",
    "iat": $iat,
    "aud": "google",
    "typ": "savetowallet",
    "origins": [],
    "payload": {
        "genericObjects": [ {

  "id": "3388000000022319375.POINTER003",
  "classId": "3388000000022319375.tool",
  "cardTitle": {
    "defaultValue": {
      "language": "en-US",
      "value": "You Got a new Tool"
    }
  },
  "header": {
    "defaultValue": {
      "language": "en-US",
      "value": "Pointer"
    }
  },
  "textModulesData": [
    {
      "id": "useful_for",
      "header": "Useful for",
      "body": "Plastic"
    }
  ],
  "barcode": {
    "type": "QR_CODE",
    "value": "$pointerEncryptedData",
    "alternateText": ""
  },
  "hexBackgroundColor": "#ff914d",
  "heroImage": {
    "sourceUri": {
      "uri": "https://inv3ncion.cl/images/googleImages/Plastic.png"
    }
  }
}
   ]
    }
  }
""";

final magnetData = """
{
   "type": "Metal"
}
""";
final String magnetEncryptedData = EncryptData.encryptAES(magnetData, "inv3ncion2024.03");
final String _magnetPass = """
{
    "iss": "enviromentalfriendly@enviromentalfriendly.iam.gserviceaccount.com",
    "iat": $iat,
    "aud": "google",
    "typ": "savetowallet",
    "origins": [],
    "payload": {
        "genericObjects": [ {

  "id": "3388000000022319375.MAGNET003",
  "classId": "3388000000022319375.tool",
  "cardTitle": {
    "defaultValue": {
      "language": "en-US",
      "value": "You Got a new Tool"
    }
  },
  "header": {
    "defaultValue": {
      "language": "en-US",
      "value": "Magnet"
    }
  },
  "textModulesData": [
    {
      "id": "useful_for",
      "header": "Useful for",
      "body": "Metal"
    }
  ],
  "barcode": {
    "type": "QR_CODE",
    "value": "$magnetEncryptedData",
    "alternateText": ""
  },
  "hexBackgroundColor": "#8C52FF",
  "heroImage": {
    "sourceUri": {
      "uri": "https://inv3ncion.cl/images/googleImages/Metal.png"
    }
  }
}
   ]
    }
  }
""";
final cameraData = """
{
   "type": "Animal"
}
""";
final String cameraEncryptedData = EncryptData.encryptAES(cameraData, "inv3ncion2024.03");

final String _cameraPass = """
{
    "iss": "enviromentalfriendly@enviromentalfriendly.iam.gserviceaccount.com",
    "iat": $iat,
    "aud": "google",
    "typ": "savetowallet",
    "origins": [],
    "payload": {
        "genericObjects": [ {

  "id": "3388000000022319375.CAMERA003",
  "classId": "3388000000022319375.tool",
  "cardTitle": {
    "defaultValue": {
      "language": "en-US",
      "value": "You Got a new Tool"
    }
  },
  "header": {
    "defaultValue": {
      "language": "en-US",
      "value": "Camera"
    }
  },
  "textModulesData": [
    {
      "id": "useful_for",
      "header": "Useful for",
      "body": "Animals"
    }
  ],
  "barcode": {
    "type": "QR_CODE",
    "value": "$cameraEncryptedData",
    "alternateText": ""
  },
  "hexBackgroundColor": "#FFDE59",
  "heroImage": {
    "sourceUri": {
      "uri": "https://inv3ncion.cl/images/googleImages/Animal.png"
    }
  }
}
   ]
    }
  }
""";