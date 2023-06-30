import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimpleTimePicker extends StatefulWidget {
  SimpleTimePicker({
    Key? key,
    this.showIndicator = false,
    this.boxHeight,
    this.boxWidth,
    this.activeColor,
    this.inactiveColor,
    this.onTimeChanged
  }) : super(key: key){
    assert(onTimeChanged != null, 'onTimeChanged callback must be provided.');
  }

  bool ?showIndicator;
  double ?boxWidth;
  double ?boxHeight;
  Color ?activeColor;
  Color ?inactiveColor;
  Function(String time) ?onTimeChanged;
  
  @override
  State<SimpleTimePicker> createState() => _SimpleTimePickerState();
}

class _SimpleTimePickerState extends State<SimpleTimePicker> {

  PageController pageController = PageController(viewportFraction: 1/3);
  PageController noonController = PageController(viewportFraction: 1/2);

  int currentHour = DateTime.now().hour;

  int currentMinute = DateTime.now().minute;

  String currentHalf = "AM";
  String selectedTime = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.boxWidth ?? 25,
              height: widget.boxHeight ?? 80,
              child: PageView(
                onPageChanged: (v) {
                  if (kDebugMode) {
                    print(v);
                  }
                  setState(() {
                    currentHour = v + 1;
                    setTime();
                  });
                },
                controller: pageController,
                scrollDirection: Axis.vertical,
                children: List.filled(
                    12,
                    const SizedBox(
                      height: 30,
                    ))
                    .asMap()
                    .map((key, value) => MapEntry(
                    key,
                    SizedBox(
                      width: 40,
                      height: 15,
                      child: Center(
                          child: Text(
                            (key + 1).toString(),
                            style: TextStyle(
                                color: currentHour == key + 1
                                    ? widget.activeColor ?? Colors.redAccent
                                    : widget.inactiveColor ?? Colors.black),
                          )),
                    )))
                    .values
                    .toList(),
              ),
            ),
            SizedBox(
              width: widget.boxWidth ?? 25,
              height: widget.boxHeight ?? 80,
              child: const Center(child: Text(":")),
            ),
            SizedBox(
              width: widget.boxWidth ?? 25,
              height: widget.boxHeight ?? 80,
              child: PageView(
                onPageChanged: (v) {
                  if (kDebugMode) {
                    print(v);
                  }
                  setState(() {
                    currentMinute = v;
                    setTime();
                  });
                },
                controller: pageController,
                scrollDirection: Axis.vertical,
                children: List.filled(
                    60,
                    const SizedBox())
                    .asMap()
                    .map((key, value) => MapEntry(
                    key,
                    SizedBox(
                      width: 40,
                      height: 15,
                      child: Center(
                          child: Text(
                            key < 10 ? "${0}$key" : (key).toString(),
                            style: TextStyle(
                                color: currentMinute == key
                                    ? widget.activeColor ?? Colors.redAccent
                                    : widget.inactiveColor ?? Colors.black),
                          )),
                    )))
                    .values
                    .toList(),
              ),
            ),
            SizedBox(
              width: 25,
              height: 80,
              child: PageView(
                onPageChanged: (v) {
                  if (kDebugMode) {
                    print(v);
                  }
                  setState(() {
                    currentHalf = v == 0 ? "AM" : "PM";
                    setTime();
                  });
                },
                controller: pageController,
                scrollDirection: Axis.vertical,
                children: List.filled(
                    2,
                    const SizedBox(
                      height: 30,
                    ))
                    .asMap()
                    .map((key, value) => MapEntry(
                    key,
                    SizedBox(
                      width: 40,
                      height: 15,
                      child: Center(
                          child: Text(
                            key == 0 ? "AM" : "PM",
                            style: TextStyle(
                                color: (currentHalf == "AM" && key == 0) ||
                                    (currentHalf == "PM" && key == 1)
                                    ? widget.activeColor ?? Colors.redAccent
                                    : widget.inactiveColor ?? Colors.black),
                          )),
                    )))
                    .values
                    .toList(),
              ),
            )
          ],
        ),
      )
    );
  }

  //
  setTime(){
    String currentHour = this.currentHour<10?"0${this.currentHour}":"${this.currentHour}";
    String currentMinute = this.currentMinute<10?"0${this.currentMinute}":"${this.currentMinute}";
    selectedTime = "$currentHour:$currentMinute $currentHalf";
    if (kDebugMode) {
      print("$currentHour : $currentMinute $currentHalf");
    }
   widget.onTimeChanged ?? widget.onTimeChanged!(selectedTime);
  }

}
