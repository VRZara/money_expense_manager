import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense/controllers/db_helper.dart';
import 'package:expense/static.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String note = "Milk";
  String types = "income";
  DateTime sdate = DateTime.now();
  List<String> months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: sdate,
      firstDate: DateTime(1990, 8),
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != sdate) {
      setState(() {
        sdate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.grey[900],
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          SizedBox(height: 20.0),
          Text(
            "Add Transaction",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.green),
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryMaterialColor,
                  borderRadius: BorderRadius.circular(16.0)
                ),
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.attach_money, size: 24.0, color: Colors.white),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Amount",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                  onChanged: (val) {
                    try {
                      amount = int.parse(val);
                    } catch (e) {}
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryMaterialColor,
                  borderRadius: BorderRadius.circular(16.0)
                ),
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.description, size: 24.0, color: Colors.white),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Transaction Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                  onChanged: (val) {
                    note = val;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Static.PrimaryMaterialColor,
                  borderRadius: BorderRadius.circular(16.0)
                ),
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.moving_sharp, size: 24.0, color: Colors.white),
              ),
              SizedBox(width: 12.0),
              ChoiceChip(
                label: Text(
                  "Income",
                  style: TextStyle(fontSize: 16.0, color: types == "Income" ? Colors.white : Colors.black),
                ),
                selectedColor: Static.PrimaryMaterialColor,
                selected: types == "Income",
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      types = "Income";
                      if (note.isEmpty || note == "Expense") {
                        note = 'Income';
                      }
                    });
                  }
                },
              ),
              SizedBox(width: 12.0),
              ChoiceChip(
                label: Text(
                  "Expense",
                  style: TextStyle(fontSize: 16.0, color: types == "Expense" ? Colors.white : Colors.black),
                ),
                selectedColor: Static.PrimaryMaterialColor,
                selected: types == "Expense",
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      types = "Expense";
                      if (note.isEmpty || note == "Income") {
                        note = 'Expense';
                      }
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20.0),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);
              },
              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Static.PrimaryMaterialColor,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.date_range, size: 24.0, color: Colors.white),
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    "${sdate.day} ${months[sdate.month - 1]}",
                    style: TextStyle(fontSize: 20.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (amount != null) {
                    DbHelper dbHelper = DbHelper();
                    dbHelper.addData(amount!, sdate, types, note);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please enter a valid amount",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
