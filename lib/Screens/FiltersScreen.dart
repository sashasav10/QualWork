import 'package:flutter/material.dart';
import 'package:my_app/constants/AppConstant.dart';
import 'package:my_app/constants/CustomColor.dart';
import 'package:my_app/custom%20widgets/CustomText.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool italian = false;
  bool asian = false;
  bool indian = false;
  bool japanese = false;
  bool pizzeria = false;
  bool european = false;

  final List<FilterModel> _list=[
    FilterModel('Italian', false),
    FilterModel('Indian', false),
    FilterModel('Pizzeria', false),
    FilterModel('European', false),
    FilterModel('Japanese', false),
    FilterModel('Asian', false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text(
          ' Filters ',
          style: TextStyle(
            fontSize: AppConstant.font20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
              onPressed: () {
                List<String> l=[];
                for(var item in _list){
                  if(item.value){
                    l.add(item.name);
                  }
                }
                if(l.isEmpty){
                  l = ['Italian','Indian','Pizzeria','European','Japanese','Asian'];
                  Navigator.pop(context,l);
                }else{
                  Navigator.pop(context,l);
                }

              },
              child: CustomText(
                title: 'Apply',
                fontWeight: FontWeight.bold,
                fontSize: AppConstant.font18,
                color: blueColor,
              ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder:(_,index){
            return Row(
              children: [
                Checkbox(
                    value: _list[index].value,
                    onChanged: (v) {
                      _list[index].value=v!;
                      setState(() {
                        indian = v;
                      });
                    }),
                CustomText(
                  title: _list[index].name,
                )
              ],
            );
          }),
    );
  }
}

// Filter Model for make the list of filters
class FilterModel{
  String name;
  bool value;
  FilterModel(this.name, this.value);
}