import 'package:flutter/material.dart';
import 'package:nitro_corn/const.dart';
import 'package:nitro_corn/imageUploadPage.dart';
import 'package:nitro_corn/instructionScreenConst.dart';
import 'package:nitro_corn/loginScaffold.dart';
import 'package:nitro_corn/utils.dart';

class DateCheckPage extends StatefulWidget {
  @override
  _DateCheckPageState createState() => _DateCheckPageState();
}

class _DateCheckPageState extends State<DateCheckPage> {
  DateTime? _selectedDate;
  String? _checkInStatus;
  DateTime? _lastCheckedDate;

    Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now.subtract(const Duration(days: 365 * 10));
    final DateTime lastDate = now.subtract(const Duration(days: 21));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime now = DateTime.now();
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: now.subtract(const Duration(days: 21)),
  //   );
  //   if (picked != null && picked != _selectedDate)
  //     setState(() {
  //       _selectedDate = picked;
  //     });
  // }

  Future<void> _selectLastCheckedDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now.subtract(const Duration(days: 365 * 15));
    final DateTime lastDate = now.subtract(const Duration(days: 10));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _lastCheckedDate)
      setState(() {
        _lastCheckedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: MediaQuery.of(context).size.width < 600
            ? EdgeInsets.symmetric(horizontal: screenWidth < 400 ? 20 :  50.0, vertical: 80)
            : MediaQuery.of(context).size.width < 1000
                ? const EdgeInsets.symmetric(horizontal: 130.0, vertical: 80)
                : const EdgeInsets.symmetric(horizontal: 300.0, vertical: 100),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: screenWidth < 450 ? 20 : 50.0, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Date of sowing :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      _selectedDate == null
                          ? 'Choose Date'
                          : '${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Have you checked before?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: const Text('Yes'),
                    leading: Radio<String>(
                      value: 'Yes',
                      groupValue: _checkInStatus,
                      onChanged: (String? value) {
                        setState(() {
                          _checkInStatus = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('No'),
                    leading: Radio<String>(
                      value: 'No',
                      groupValue: _checkInStatus,
                      onChanged: (String? value) {
                        setState(() {
                          _checkInStatus = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (_checkInStatus == 'Yes') ...[
                const SizedBox(height: 20),
                const Text(
                  'Date of last check :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectLastCheckedDate(context),
                      child: Text(
                        _lastCheckedDate == null
                            ? 'Choose Date'
                            : '${_lastCheckedDate!.toLocal()}'.split(' ')[0],
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectLastCheckedDate(context),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: getInstructionPlayButtonWidth(screenWidth),
                  child: GestureDetector(
                      onTap: () {
                        if (_selectedDate == null) {
                          Utils.showSnackBar('Please select the "Date of sowing"');
                        } else if (_checkInStatus == null) {
                          Utils.showSnackBar(
                              'Please Choose "Have you previously checked?" question');
                        } else if (_checkInStatus == "Yes" &&
                            _lastCheckedDate == null) {
                          Utils.showSnackBar(
                              "Please select the date of last check");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       LoginScaffoldWidget(
                                          widget: ImageUploadPage())));
                        }
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                            decoration: getGradientButtonDecoration(
                                appBarGradientColors),
                            padding: const EdgeInsets.all(defaultPaddingSize),
                            child: Center(
                              child: Text(
                                "Test",
                                textAlign: TextAlign.center,
                                style: getPlayButtonTextStyle(),
                              ),
                            )),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
