import 'dart:convert';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:enviromental_friendly/vision_detector_views/painters/barcode_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

import 'detector_view.dart';
import '../aes.dart';
import '../globals.dart' as globals;

class BarcodeScannerView extends StatefulWidget {
  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  CustomPaint? _customPaint;
  String? jsonRawValue;
  var _cameraLensDirection = CameraLensDirection.back;
  late var dialog;
  bool scanned = false;
  
  void getDialog(data) async{
    dialog = await globals.toolBox.addTool(data['type']);
  }

  @override
  void dispose() {
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return DetectorView(
      title: 'Barcode Scanner',
      customPaint: _customPaint,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    final barcodes = await _barcodeScanner.processImage(inputImage);
      final painter = BarcodeDetectorPainter(
        barcodes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
      for (final barcode in barcodes) {
        if(!scanned){
          jsonRawValue = barcode.rawValue;
          var jsonData = EncryptData.decryptAES(jsonRawValue!, "inv3ncion2024.03").toString();
          var data = jsonDecode(jsonData);
          scanned = true;
          Timer(const Duration(seconds: 3), () { 
            getDialog(data);
            showDialog(context: context, builder: (context)=>dialog);
            Timer(Duration(seconds: 3), () {Navigator.pop(context); });
          });
          }
        }
      // TODO: set _customPaint to draw boundingRect on top of image
  }
}