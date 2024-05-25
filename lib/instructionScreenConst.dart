import 'package:flutter/material.dart';
import 'package:nitro_corn/const.dart';

const int colorGameButtonCounts = 8;
const int colorGameNumberOfQuestionText = 12;
const int colorGameNumberOfLife = 3;

const double sizedBoxDefaultWidth = 30.0;
const double defaultPaddingSize = 8.0;
const double scrollbarThickness = 8.0;
const double scrollbarRadius = 30.0;

const String playButtonOnClickFailureLogText = "play button click Error - ";

String getGameName(String gameNameText) {
  return "Testing Instruction";
}

String getGameInstructionName(String gameNameText) {
  return "Instruction Page";
}

List<Color> getGameColorList(String gameNameText) {
  return appBarGradientColors;
}

double getInstructionBoxToPlayButtonDistance(double screenHeight) {
  return screenHeight < 550
      ? 20
      : screenHeight < 600
          ? 30
          : screenHeight < 650
              ? 40
              : 50;
}

double getPlayButtonToBottomEndPointDistance(double screenHeight) {
  return screenHeight < 65 ? 20 : 13;
}

double getInstructionContainerHeight(double screenHeight) {
  return screenHeight * 0.55;
}

double getInstructionContainerWidth(double screenWidth) {
  return screenWidth < 450
      ? screenWidth
      : screenWidth < 800
          ? screenWidth * 0.7
          : screenWidth * 0.5;
}

EdgeInsetsGeometry getInstructionContainerPadding(double screenWidth) {
  return EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 0.13);
}

BoxDecoration getInstructionContainerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: lightGrey,
  );
}

BoxDecoration getGradientButtonDecoration(List<Color> gameColor) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: gameColor,
    ),
  );
}

TextStyle getInstructionTitleTextStyle() {
  return TextStyle(
      color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold);
}

TextStyle getInstructionContentTextStyle() {
  return TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
}

TextStyle getPlayButtonTextStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);
}

String getInstructionPageLoadingLogText(String gameName) {
  return "Loading ${gameName.toLowerCase()} game instruction page";
}

String getTextDocumentGameInstructionKey(String gameName) {
  return "INSTRUCTION";
}
