import 'package:fani/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:fani/main.dart';
import 'package:fani/serv/globalserv.dart';
import 'package:fani/serv/worker.dart';
import 'package:fani/auth/user.dart';
import 'package:multi_select_item/multi_select_item.dart';

class DateAndTime extends StatefulWidget {
  const DateAndTime({Key? key}) : super(key: key);

  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

String ordrepeated = "";
List<String> ordadd = [];
String orddate = "";
String typef = typeofserv;
List<String> selectedHour = [];
MultiSelectController controller = new MultiSelectController();

class _DateAndTimeState extends State<DateAndTime> {
  int _selectedRepeat = 1;
  List<int> _selectedExteraCleaning = [];
  ItemScrollController _scrollController = ItemScrollController();
  final List<String> _hours = <String>[
    '4-6',
    '2-4',
    '12-2',
    '10-12',
    '8-10',
  ];

  final List<String> _repeat = ['مرة واحدة', 'يومياً', 'اسبوعياً', 'شهرياً '];
  DateTime datatime = DateTime(2000);
  final List<dynamic> _exteraCleaning = [
    [
      'غسيل ملابس',
      'https://img.icons8.com/office/2x/washing-machine.png',
      '20'
    ],
    ['الثلاجة', 'https://img.icons8.com/cotton/2x/fridge.png', '20'],
    [
      'الفرن',
      'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png',
      '20'
    ],
    [
      'السيارات',
      'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png',
      '20'
    ],
    [
      'النوافذ',
      'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png',
      '50'
    ],
  ];
  String formatter = "";

  Widget buildate() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(6, 8, 6, 0),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        height: 175,
        child: SizedBox(
          height: 175,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            maximumYear: DateTime.now().year + 4,
            minimumDate: DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
            onDateTimeChanged: (DateTime nt) {
              setState(() =>
                  //datatime = nt
                  orddate = nt.toString());
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
    selectedHour = [];
    print(selectedHour);
    controller.disableEditingWhenNoneSelected = true;
    controller.set(_hours.length);
  }

  @override
  Widget build(BuildContext context) {
    onWillPop:
    () async {
      var before = !controller.isSelecting;
      setState(() {
        controller.deselectAll();
      });
      return before;
    };
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Gserv()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          ),
          backgroundColor: dy,
          title: Text(
              'مرحبا, $nee  ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => tech()),
            );
          },
          child: Icon(Icons.arrow_forward_ios),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: FadeAnimation(
                  1,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 70.0, right: 20.0, left: 20.0),
                    child: Text(
                      'اختيار اليوم والوقت ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildate(),
                SizedBox(
                  height: 25,
                ),
                FadeAnimation(
                    1.2,
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border:
                            Border.all(width: 2, color: Colors.grey.shade200),
                      ),
                      child: ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _hours.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  print(index);
                                },
                                child: MultiSelectItem(
                                  isSelecting: controller.isSelecting,
                                  onSelected: () {
                                    //print(index);
                                    setState(() {
                                      controller.toggle(index);
                                      if (controller.isSelected(index)) {
                                        selectedHour.add(_hours[index]);
                                      } else {
                                        selectedHour.remove(_hours[index]);
                                      }
                                      print(selectedHour);
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: controller.isSelected(index)
                                          ? Colors.orange.shade100
                                              .withOpacity(0.5)
                                          : Colors.orange.withOpacity(0),
                                      border: Border.all(
                                        color: controller.isSelected(index)
                                            ? Colors.orange
                                            : Colors.white.withOpacity(0),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _hours[index]
                                                  .replaceAll('-', ':00-') +
                                              ':00',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          }),
                    )),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                      width: 400,
                      child: (Text(
                        "تكرار",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _repeat.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRepeat = index;
                              ordrepeated = _repeat[index];
                            });
                            // print(
                            //     "selectedRepeat : ${_repeat[_selectedRepeat]}");
                          },
                          child: FadeAnimation(
                              (1.2 + index) / 4,
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _selectedRepeat == index
                                      ? Colors.blue.shade400
                                      : Colors.grey.shade100,
                                ),
                                margin: EdgeInsets.only(right: 20),
                                child: Center(
                                    child: Text(
                                  _repeat[index],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: _selectedRepeat == index
                                          ? Colors.white
                                          : Colors.grey.shade800),
                                )),
                              )),
                        );
                      },
                    )),
                SizedBox(
                  height: 40,
                ),
                //64159bdf2c786e4739044085
                typeofserv == "64159bdf2c786e4739044085"
                    ? Container(
                        width: 400,
                        child: (Text(
                          "خدمات اضافية",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )))
                    : SizedBox(
                        height: 10,
                      ),
                SizedBox(
                  height: 10,
                ),
                typeofserv == "64159bdf2c786e4739044085"
                    ? Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _exteraCleaning.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_selectedExteraCleaning
                                        .contains(index)) {
                                      ordadd.remove(_exteraCleaning[index]);
                                      _selectedExteraCleaning.remove(index);
                                    } else {
                                      _selectedExteraCleaning.add(index);
                                      ordadd.add(_exteraCleaning[index]);
                                    }
                                  });
                                },
                                child: FadeAnimation(
                                    (1.4 + index) / 4,
                                    Container(
                                        width: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: _selectedExteraCleaning
                                                  .contains(index)
                                              ? Colors.blue.shade400
                                              : Colors.transparent,
                                        ),
                                        margin: EdgeInsets.only(right: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              _exteraCleaning[index][1],
                                              height: 40,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              _exteraCleaning[index][0],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: _selectedExteraCleaning
                                                          .contains(index)
                                                      ? Colors.white
                                                      : Colors.grey.shade800),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "+${_exteraCleaning[index][2]}\$",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        ))));
                          },
                        ))
                    : SizedBox(
                        height: 10,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
