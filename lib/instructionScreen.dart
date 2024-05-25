
import 'package:flutter/material.dart';
import 'package:nitro_corn/const.dart';
import 'package:nitro_corn/datecheckScreen.dart';
import 'package:nitro_corn/instructionScreenConst.dart';
import 'package:nitro_corn/loginScaffold.dart';
import 'package:nitro_corn/textDoc.dart';

class InstructionScreen extends StatefulWidget {

  InstructionScreen();
  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  static String textDocumentGameInstructionKey = "";
  static Widget? gameUIWidget = null;

  Map<String, TextDocuments> textDocuments = localText;

  Map<String, dynamic> instructions = {};

  List<dynamic> instructionKeys = [], instructionValues = [];

  bool _isAlwaysShown = true;
  bool _showTrackOnHover = true;

  ScrollController _scrollController = ScrollController();
  bool isMaintenanceBreak = false;
  String instructionPageName = "";
  List<Color> gameColor = [];



  @override
  void initState() {
    instructionPageName = "INSTRUCTION PAGE";
    gameColor = appBarGradientColors;
    textDocumentGameInstructionKey = "instruction";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    instructions =
        (textDocuments[textDocumentGameInstructionKey] as TextDocuments).value;
    instructions = Map.fromEntries(instructions.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key)));

    instructionKeys = instructions.keys.toList();
    instructionValues = instructions.values.toList();

    return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: sizedBoxDefaultWidth,
                ),
                Center(
                    child: Text(
                  "INSTRUCTION SCREEN",
                  style: getInstructionTitleTextStyle(),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: sizedBoxDefaultWidth,
                ),
                Padding(
                  padding: getInstructionContainerPadding(screenWidth),
                  child: RawScrollbar(
                    controller: _scrollController,
                    thumbColor: Colors.grey[500],
                    radius: Radius.circular(scrollbarRadius),
                    thumbVisibility: _isAlwaysShown,
                    trackVisibility: _showTrackOnHover,
                    interactive: true,
                    thickness: scrollbarThickness,
                    child: Container(
                      decoration: getInstructionContainerDecoration(),
                      width: getInstructionContainerWidth(screenWidth),
                      height: getInstructionContainerHeight(screenHeight),
                      child: Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: defaultPaddingSize),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: instructions.length,
                            itemBuilder: (context, index) {
                              String valueString = instructionValues[index];
                              return ListTile(
                                title: Text(
                                  instructionKeys[index].toString(),
                                  style: getInstructionContentTextStyle(),
                                  textAlign: TextAlign.start,
                                ),
                                subtitle: Text(
                                  valueString.replaceAll(
                                      singleBreakString, "\n"),
                                  style: getInstructionContentTextStyle(),
                                  textAlign: TextAlign.start,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getInstructionBoxToPlayButtonDistance(screenHeight),
                ),
                SizedBox(
                  width: getInstructionPlayButtonWidth(screenWidth),
                  child: GestureDetector(
                      onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScaffoldWidget(
                                      
                                      widget: DateCheckPage())));
                        
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                            decoration: getGradientButtonDecoration(appBarGradientColors),
                            padding: EdgeInsets.all(defaultPaddingSize),
                            child: Center(
                              child: Text(
                                "Test",
                                textAlign: TextAlign.center,
                                style: getPlayButtonTextStyle(),
                              ),
                            )),
                      )),
                ),
                SizedBox(
                  height: getPlayButtonToBottomEndPointDistance(screenHeight),
                ),
              ],
            ),
          );
  }
}
