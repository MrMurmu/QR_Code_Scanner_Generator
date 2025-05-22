import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResult = '';
  bool isFlashOn = false;

  final MobileScannerController controller = MobileScannerController();

  void _toggleFlash() {
    isFlashOn = !isFlashOn;
    controller.toggleTorch();
    setState(() {});
  }

  void _switchCamera() {
    controller.switchCamera();
  }

  void _onDetect(BarcodeCapture capture) {
    final Barcode? barcode = capture.barcodes.first;
    if (barcode != null && barcode.rawValue != null) {
      setState(() {
        qrResult = barcode.rawValue!;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("QR Code Scanner", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
         iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: isFlashOn ? 'Turn off flash' : 'Turn on flash',
            icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off,),
            color: Colors.white,
            onPressed: _toggleFlash,
          ),
          IconButton(
            tooltip: 'Switch camera',
            icon: const Icon(Icons.cameraswitch),
            color: Colors.white,
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MobileScanner(
                    controller: controller,
                    onDetect: _onDetect,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (qrResult.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scan a QR code',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.qr_code_scanner, color: Colors.white),
                ],
              ),
            if (qrResult.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scan again or Scan another',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.qr_code_scanner, color: Colors.white),
                ],
              ),
            if (qrResult.isNotEmpty)
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Text(
                    qrResult,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
