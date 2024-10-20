import 'package:dowry_calculator/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class QuestionsUi extends StatefulWidget {
  const QuestionsUi({super.key});

  @override
  State<QuestionsUi> createState() {
    // TODO: implement createState
    return _QuestionsUiState();
  }
}

class _QuestionsUiState extends State<QuestionsUi> {
  final formatter = NumberFormat('#,##,000');
  final _vehicles = ["Bicycle", "Motorcycle", "Car", "Luxury Car"];
  final _jobPositions = [
    "Engineer",
    "Doctor",
    "Businessman",
    "Gov. Employee",
    "Influencer"
  ];
  final _cookingSkills = ["Masterchef", "Average", "Burnt Toast"];
  final _gymGuy = ["Gym Buff", "Average", "Couch Potato"];

  var _selectedVehicles = "Motorcycle";
  var _selectedjob = "Engineer";
  var _selectedCookingSkills = "Burnt Toast";
  var _selectedGym = "Couch Potato";
  final _incomeController = TextEditingController();
  final _landController = TextEditingController();
  final _followersController = TextEditingController();

  void Calculate() {
    int income = int.parse(_incomeController.text);
    int land = int.parse(_landController.text);
    Map<String, int> vehicleDowryMap = {
      "Bicycle": 10000,
      "Motorcycle": 50000,
      "Car": 200000,
      "Luxury Car": 1000000
    };
    Map<String, int> jobDowryMap = {
      "Engineer": 200000,
      "Doctor": 500000,
      "Businessman": 300000,
      "Gov. Employee": 700000,
      "Influencer": 100000
    };
    int followers = int.parse(_followersController.text);
    Map<String, int> cookingSkillDowryMap = {
      "Masterchef": 50000,
      "Average": 20000,
      "Burnt Toast": -20000
    };
    Map<String, int> gymDowryMap = {
      "Gym Buff": 50000,
      "Average": 20000,
      "Couch Potato": -50000
    };
    double dowry = income * 0.1;
    dowry += land * 50000;
    dowry += vehicleDowryMap[_selectedVehicles]!;
    dowry += jobDowryMap[_selectedjob]!;
    dowry += followers * 2;
    dowry += cookingSkillDowryMap[_selectedCookingSkills]!;
    dowry += gymDowryMap[_selectedGym]!;

    showModalBottomSheet(
        context: context,
        builder: (ctx) => Result(CalculatedDowry: dowry),
        isScrollControlled: true);
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _landController.dispose();
    _followersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              "assets/images/hand.png",
              scale: 3,
            ),
            TextField(
              controller: _incomeController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 50,
              decoration: InputDecoration(
                label: Text("What's your current yearly income? (₹)"),
                prefix: Text("₹"),
              ),
            ),
            TextField(
              controller: _landController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 50,
              decoration: InputDecoration(
                label: Text("How many acres of land do you own?"),
                suffix: Text("acre"),
              ),
            ),
            TextField(
              controller: _followersController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 50,
              decoration: InputDecoration(
                label: Text("How many social media followers do you have?"),
              ),
            ),
            Row(children: [
              Text(
                "What vehicle do you own?",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              DropdownButton(
                  alignment: Alignment.centerRight,
                  value: _selectedVehicles,
                  items: _vehicles
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedVehicles = value;
                      });
                    }
                  }),
            ]),
            Row(children: [
              Text(
                "What's your current job title?",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              DropdownButton(
                  alignment: Alignment.centerRight,
                  value: _selectedjob,
                  items: _jobPositions
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedjob = value;
                      });
                    }
                  }),
            ]),
            Row(children: [
              Text(
                "How good are your cooking skills?",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              DropdownButton(
                  alignment: Alignment.centerRight,
                  value: _selectedCookingSkills,
                  items: _cookingSkills
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedCookingSkills = value;
                      });
                    }
                  }),
            ]),
            Row(children: [
              Text(
                "How fit are you?",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              DropdownButton(
                  alignment: Alignment.centerRight,
                  value: _selectedGym,
                  items: _gymGuy
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedGym = value;
                      });
                    }
                  }),
            ]),
            SizedBox(
              height: 20,
            ),
            TextButton.icon(
                onPressed: () {
                  Calculate();
                },
                icon: Icon(Icons.moving_outlined),
                iconAlignment: IconAlignment.end,
                label: Text("Calculate Dowry"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 89, 147, 255),
                ))
          ],
        ),
      ),
    );
  }
}
