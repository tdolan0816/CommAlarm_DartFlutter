import 'package:flutter/material.dart';

class SideButtonsCardBuild extends StatelessWidget {
 const SideButtonsCardBuild({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {

  var alarmIcon = Icons.alarm_sharp;
  var settingsIcon = Icons.settings_sharp;
  var helpIcon = Icons.help_sharp;
  var infoIcon = Icons.info_sharp;

  return Card(
      color: const Color.fromARGB(255, 126, 189, 245),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 275,
        width: 65,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
      
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          IconButton(
            iconSize: 35,
            icon: Icon(alarmIcon),
            color: const Color.fromARGB(255, 92, 145, 189),
            onPressed: () {},
          ),

          IconButton(
            iconSize: 35,
            icon: Icon(settingsIcon),
            color: const Color.fromARGB(255, 92, 145, 189),
            onPressed: () {},
          ),

          IconButton(
            iconSize: 35,
            icon: Icon(helpIcon),
            color: const Color.fromARGB(255, 92, 145, 189),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(infoIcon),
            color: const Color.fromARGB(255, 92, 145, 189),
            onPressed: () {},
          ),],
        ),
      )
    );
  }
}