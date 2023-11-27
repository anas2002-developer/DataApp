import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class addMenu extends StatefulWidget {
  const addMenu({super.key});

  @override
  State<addMenu> createState() => _addMenuState();
}

class _addMenuState extends State<addMenu> {

  var universityName = "Galgotias University";
  var foodCategoryList = [
    "breakfast",
    "lunch",
    "snacks",
    "dinner",
  ];
  // String appName="biteByteGU";
  var firestore = FirebaseFirestore.instance.collection("biteByteGU");



  var formKey = GlobalKey<FormState>();
  var foodCtrl = TextEditingController();
  var foodList = [];
  var categoryCtrl;
  var isboysSelected = false;
  var isgirlsSelected = false;
  late DateTime? dateCtrl =  null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text(universityName, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    height: 60,
                    decoration:BoxDecoration(
                      color: Color(0xffE7F0FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                      ),
                      hint: const Text(
                        'Category',
                        style: TextStyle (fontFamily: "Poppins", color: Color(0xff468DFF), fontSize: 16,),
                      ),
                      items: foodCategoryList
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'choose category';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          categoryCtrl = value.toString();
                        });
                        print(categoryCtrl);
                        //Do something when selected item is changed.
                      },
                      onSaved: (value) {
                        categoryCtrl = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down, color: Color(0xff468DFF), size: 30,),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xffE7F0FF),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: foodCtrl,
                            decoration: InputDecoration(
                              hintText: "food",
                              hintStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: Color(0xff468DFF), // Change this color to your desired hint text color
                              ),
                              prefixIcon: Icon(CupertinoIcons.circle_grid_3x3, color: Color(0xff418AFF),),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Choose food";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              showCupertinoModalPopup(context: context, builder: (context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.4,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          if (dateCtrl == null) {
                                            setState(() {
                                              dateCtrl = DateTime.now();
                                            });
                                          }
                                        },
                                        child: Text("Done"),
                                      ),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          initialDateTime: dateCtrl ?? DateTime.now(),
                                          mode: CupertinoDatePickerMode.date,
                                          minimumDate: DateTime(2023),
                                          // maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59),
                                          use24hFormat: false,
                                          onDateTimeChanged: (date) {
                                            setState(() {
                                              dateCtrl = date;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xffE7F0FF),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: dateCtrl != null ? Text(DateFormat('ddMMMyy').format(dateCtrl!)) : Text("date", style: TextStyle (fontFamily: "Poppins", color: Color(0xff468DFF), fontSize: 16,),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 15),
                                      child: Icon(Icons.keyboard_arrow_down, color: Color(0xff468DFF), size: 30,)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilterChip(
                          label: Text("boys"),
                          selected: isboysSelected,
                          onSelected: (bool val){
                            setState(() {
                              isboysSelected = !isboysSelected;
                            });
                          },
                        selectedColor: Colors.blue,
                        backgroundColor: Color(0xffE7F0FF),
                        labelStyle: TextStyle(
                          color: isboysSelected ? Colors.white : Colors.black, // Set text color based on selection
                        ),
                        checkmarkColor: Colors.white,
                      ),
                      FilterChip(
                          label: Text("girls"),
                          selected: isgirlsSelected,
                          onSelected: (bool val){
                            setState(() {
                              isgirlsSelected = !isgirlsSelected;
                            });
                          },
                        selectedColor: Colors.pinkAccent,
                        backgroundColor: Color(0xffffe7f0),
                        labelStyle: TextStyle(
                          color: isgirlsSelected ? Colors.white : Colors.black, // Set text color based on selection
                        ),
                        checkmarkColor: Colors.white,
                      ),
                    ],
                  ),

                  SizedBox(height: 30,),


                ],
              ),
              key: formKey,
            ),

            ElevatedButton(onPressed: () async{

              if (formKey.currentState!.validate() && dateCtrl!=null && (isboysSelected || isgirlsSelected)){

                if (!foodList.contains(foodCtrl.text)){
                  setState(() {
                    foodList.add(foodCtrl.text.replaceAll(" ", "").toLowerCase());
                    foodCtrl.clear();
                  });
                }
                else{
                  foodCtrl.clear();
                  toastError(context);
                }
              }
              else{
                toastError(context);
              }

            },style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              minimumSize: Size(200, 80), // Set the minimum size of the button
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Set padding for the button content
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14), // Set the border radius
              ),
            ),
                child: Text(
              "Add"
            )),

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{

              if (dateCtrl!=null && (isboysSelected || isgirlsSelected) && foodList.isNotEmpty){
                if (isboysSelected){
                  await firestore.doc("BoysMenu").collection(categoryCtrl).doc(DateFormat('ddMMMyy').format(dateCtrl!)).set(
                      {

                        "food" : foodList,
                        "date" : DateFormat('ddMMMyy').format(dateCtrl!),

                      }
                  );

                }

                if (isgirlsSelected){
                  await firestore.doc("GirlsMenu").collection(categoryCtrl).doc(DateFormat('ddMMMyy').format(dateCtrl!)).set(
                      {

                        "food" : foodList,
                        "date" : DateFormat('ddMMMyy').format(dateCtrl!),

                      }
                  );

                }
                toastSuccess(context);
                foodList.clear();
              }
              else{
                toastError(context);
              }

            },style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              minimumSize: Size(200, 40), // Set the minimum size of the button
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Set padding for the button content
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14), // Set the border radius
              ),
            ),
                child: Text(
                    "Upload to Firebase"
                )),


            ListView.builder(itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(foodList[index]));
            },
            itemCount: foodList.length,
            shrinkWrap: true,),
          ],
        ),
      ),
    );
  }

  void toastSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(20),
          height: 90,
          decoration: BoxDecoration(
            color: Color(0XFFBEED53),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Success",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 1),
      ),
    );
  }
  void toastError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(20),
          height: 90,
          decoration: BoxDecoration(
            color: Color(0XFFFF5349),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Error",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration(seconds: 1),
      ),
    );
  }

}