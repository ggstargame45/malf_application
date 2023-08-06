import 'package:flutter/material.dart';

class UserContainer extends StatelessWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 20),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("assets/yerin.jpg"),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 68, 176, 253),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Text(
                  "현지인",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const Row(
                children: [
                  Text(
                    "travis",
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(Icons.adobe_outlined)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
