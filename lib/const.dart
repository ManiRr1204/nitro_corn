import 'package:flutter/material.dart';
import 'package:nitro_corn/textDoc.dart';

Map<int, Color> appThemeColor = {
  50: Color.fromRGBO(53, 220, 159, .1),
  100: Color.fromRGBO(53, 220, 159, .2),
  200: Color.fromRGBO(53, 220, 159, .3),
  300: Color.fromRGBO(53, 220, 159, .4),
  400: Color.fromRGBO(53, 220, 159, .5),
  500: Color.fromRGBO(53, 220, 159, .6),
  600: Color.fromRGBO(53, 220, 159, .7),
  700: Color.fromRGBO(53, 220, 159, .8),
  800: Color.fromRGBO(53, 220, 159, .9),
  900: Color.fromRGBO(53, 220, 159, 1),
};

Text getAppTitleText() {
  return Text(
    "NITRO CORN",
    style: getAppBarTextStyle(),
  );
}

TextStyle getAppBarTextStyle() {
  return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
}


BoxDecoration getGradientColorDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: appBarGradientColors,
    ),
  );
}

final appBarGradientColors = [
      Color.fromARGB(255, 92, 238, 119),
      Color.fromARGB(255, 26, 182, 65),
      Color.fromARGB(255, 8, 132, 39),
    ];

const Color lightGrey = const Color.fromARGB(255, 200, 196, 196);

double getInstructionPlayButtonWidth(double screenWidth) {
  return screenWidth < 450
      ? screenWidth * 0.3
      : screenWidth < 750
          ? screenWidth * 0.25
          : screenWidth < 950
              ? screenWidth * 0.2
              : screenWidth * 0.15;
}

const String breakString = "br_br";
const String singleBreakString = "_br_";


// Local texts (content) if no internet connection there and cant able to fetch game content from db.
Map<String, TextDocuments> localText = {
  "instruction":
      TextDocuments(textKey: "memoryGameInstructions", value: {
    "Instruction / வழிமுறைகள் :":
        "_br_1. This website is suitable only for maize/corn crop.  (or)\nஇந்த இணையதளம் மக்காச்சோளம்/சோளப் பயிருக்கு மட்டுமே பொருத்தமானது._br__br_2. You can check the nitrogen content only after 21 days of sowing.  (or)\n விதைத்து 21 நாட்களுக்குப் பிறகுதான் நைட்ரஜன் அளவை சரிபார்க்க வேண்டும்._br__br_3. if you have already checked before, then you can recheck again after an interval of 10 days from the date of check.  (or)\n நீங்கள் முன்பே சரிபார்த்திருந்தால், சரிபார்த்த தேதியிலிருந்து 10 நாட்கள் இடைவெளிக்குப் பிறகு மீண்டும் சரிபார்க்க வேண்டும்._br__br_4. You need to provide approximately ten photographs of various leaves from various plants, which will be chosen at random.  (or)\n பத்து புகைப்படமானது வெவ்வேறு செடிகளில் இருந்து வெவ்வேறு இலைகளைத் தேர்வு செய்து பதிவேற்றம் செய்யவேண்டும்._br__br_5. The leaves ought to be chosen so that a completely opened leaf is chosen from the top of the plant. Verify that no disease, pest infestation, water stress, or other nutrient shortage (apart from nitrogen deficiency) is affecting the chosen leaves.  (or)\n ேலிருந்து முழுவதும் விரிந்த இலைகளானாது இயல்பானதாகவும், நோய்களின்றி, பூச்சிகளால் பாதிக்கப்படாதவையாகவும் , தண்ணீர் தேக்கம் மற்றும் அழுத்தத்தினால் பாதிக்கப்படாத இலைகளாகவும், மற்ற  ஊட்டச்சத்து  குறைபாடு(நைட்ரஜன் ‌தவிர) இல்லாததாகவும் இருத்தல் வேண்டும்._br__br_6. After selecting those leaves, cut the leaves and place it in a white background and take photo of the leaf.  (or)\n ேர்ந்தெடுத்த இலைகளை வெட்டி வெள்ளை நிற ‌தாளில்/பின்னணியில் வைத்து இலையை புகைப்படம் எடுத்து பதிவேற்ற வேண்டும்._br__br_7. All of these tasks must be completed between the hours of 8 and 10 am and 2 and 4 pm.  (or)\n புகைப்படமானது  காலை 8 மணி முதல் 10 மணி வரையிலும், மாலை 2 மணி முதல் 4 மணி வரையிலும் எடுக்க வேண்டும்._br__br_8. If the silking stage has started (once flowers started to appear), then you have to stop doing this nitrogen check.  (or)\n பயிர் பூக்க‌‌ துவங்கிய பிறகு இந்த பயன்பாட்டை நிறுத்தி விட‌ வேண்டும்._br_",
    }),
  
};


