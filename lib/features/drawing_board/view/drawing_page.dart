import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:thank_you_pro/features/drawing_board/view/drawing_canvas/drawing_canvas.dart';
import 'package:thank_you_pro/features/drawing_board/view/drawing_canvas/models/drawing_mode.dart';
import 'package:thank_you_pro/features/drawing_board/view/drawing_canvas/models/sketch.dart';
import 'package:thank_you_pro/features/drawing_board/view/drawing_canvas/widgets/canvas_side_bar.dart';
import 'package:thank_you_pro/main.dart';
import 'package:thank_you_pro/theme/styles.dart';
import 'package:thank_you_pro/utils/toast/my_toast.dart';
import 'package:universal_html/html.dart' as html;
import 'package:thank_you_pro/utils/widgets/my_appbar.dart';

class DrawingPage extends HookWidget {
  const DrawingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 0,
    );
    final undoRedoStack = useState(
      UndoRedoStack(
        sketchesNotifier: allSketches,
        currentSketchNotifier: currentSketch,
      ),
    );

    void saveFile(Uint8List bytes, String extension) async {
      try {
        final directory = await getApplicationDocumentsDirectory();

        await FileSaver.instance
            .saveFile(
          name: 'ThankYouPro-${DateTime.now().toIso8601String()}',
          bytes: bytes,
          ext: extension,
          mimeType: extension == 'png' ? MimeType.png : MimeType.jpeg,
        )
            .then((value) {
          if (value != "") {
            MyToast.successToast("File Saved Successfully!", context);
          }
          print(value);
        });
      } catch (e) {
        print('Error saving file: $e');
      }
    }

    Future<Uint8List?> getBytes() async {
      RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    }

    // Use `useValueListenable` to listen to changes in animationController.value
    final animationValue = useValueListenable(animationController);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: myAppBar(
        context: context,
        title: "Canvas",
        backgroundColor: Colors.transparent,
        action: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.download,
              color: Colors.black54,
            ),
            onPressed: () async {
              EasyLoading.show(status: "Downloading...");
              Uint8List? pngBytes = await getBytes();
              if (pngBytes != null) saveFile(pngBytes, 'jpeg');
              EasyLoading.dismiss();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: kCanvasColor),
            width: double.maxFinite,
            height: double.maxFinite,
            child: DrawingCanvas(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              drawingMode: drawingMode,
              selectedColor: selectedColor,
              strokeSize: strokeSize,
              eraserSize: eraserSize,
              sideBarController: animationController,
              currentSketch: currentSketch,
              allSketches: allSketches,
              canvasGlobalKey: canvasGlobalKey,
              filled: filled,
              polygonSides: polygonSides,
              backgroundImage: backgroundImage,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animationController),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                    ),
                    onPressed: () {
                      if (animationController.value == 0) {
                        animationController.forward();
                      } else {
                        animationController.reverse();
                      }
                    },
                    icon: Text(
                      'Close',
                      style: Styles.smallBoldText(context).copyWith(
                          color: Styles.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: CanvasSideBar(
                      drawingMode: drawingMode,
                      selectedColor: selectedColor,
                      strokeSize: strokeSize,
                      eraserSize: eraserSize,
                      currentSketch: currentSketch,
                      allSketches: allSketches,
                      canvasGlobalKey: canvasGlobalKey,
                      filled: filled,
                      polygonSides: polygonSides,
                      backgroundImage: backgroundImage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: animationValue == 1 ? false : true,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: allSketches.value.isNotEmpty
                      ? () => undoRedoStack.value.undo()
                      : null,
                  icon: const Icon(
                    FontAwesomeIcons.arrowRotateLeft,
                    color: Colors.black54,
                  ),
                ),
                IconButton(
                  onPressed: allSketches.value.isNotEmpty
                      ? () => undoRedoStack.value.redo()
                      : null,
                  icon: const Icon(FontAwesomeIcons.arrowRotateRight,
                      color: Colors.black54),
                ),
                IconButton(
                  onPressed: () async {
                    if (backgroundImage.value != null) {
                      backgroundImage.value = null;
                    } else {
                      backgroundImage.value = await getImage;
                    }
                  },
                  icon:
                      const Icon(FontAwesomeIcons.image, color: Colors.black54),
                ),
                const Spacer(),
                IconButton(
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(20),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
                    iconSize: const MaterialStatePropertyAll(30),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                    backgroundColor: MaterialStatePropertyAll(Styles.primary),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    if (animationController.value == 0) {
                      animationController.forward();
                    } else {
                      animationController.reverse();
                    }
                  },
                  icon: Icon(drawingMode.value == DrawingMode.pencil
                      ? FontAwesomeIcons.pencil
                      : drawingMode.value == DrawingMode.line
                          ? FontAwesomeIcons.minus
                          : drawingMode.value == DrawingMode.polygon
                              ? Icons.hexagon_outlined
                              : drawingMode.value == DrawingMode.eraser
                                  ? FontAwesomeIcons.eraser
                                  : drawingMode.value == DrawingMode.square
                                      ? FontAwesomeIcons.square
                                      : drawingMode.value == DrawingMode.circle
                                          ? FontAwesomeIcons.circle
                                          : Icons.menu),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ui.Image> get getImage async {
    final completer = Completer<ui.Image>();
    if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (file != null) {
        final filePath = file.files.single.path;
        final bytes = filePath == null
            ? file.files.first.bytes
            : File(filePath).readAsBytesSync();
        if (bytes != null) {
          completer.complete(decodeImageFromList(bytes));
        } else {
          completer.completeError('No image selected');
        }
      }
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        completer.complete(
          decodeImageFromList(bytes),
        );
      } else {
        completer.completeError('No image selected');
      }
    }

    return completer.future;
  }
}
