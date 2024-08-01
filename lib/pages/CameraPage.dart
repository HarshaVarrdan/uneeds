import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uneeds/widgets/CustomWidgets.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.camera, required this.imageName});

  final CameraDescription camera;
  final String imageName;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  late XFile _image = XFile("");

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(PageName: "Camera", context: context),
      body: Container(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1.4,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Wrap CameraPreview with AspectRatio
                    return CameraPreview(
                      _controller,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF202020),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                color: Color(0xFF202020),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await _initializeControllerFuture;
                      final image = await _controller.takePicture();

                      final String renamedFilePath =
                          '/data/user/0/com.f2f.uneeds/cache/${widget.imageName}';
                      await File(image.path).rename(renamedFilePath);

                      setState(() {
                        _image = _image;
                      });
                      if (!mounted) return;
                      Navigator.pop(context, renamedFilePath);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFFFFF),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }
}
