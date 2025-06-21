import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/deep/controller/language_controller.dart';

class language extends StatelessWidget {
  language({super.key});

  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
                  'Language',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.languages.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 10),
                  child: SizedBox(
                    height: 50,
                    width: 380,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Text(
                              controller.languages[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          leading: Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child:
                                Image.asset(controller.languages[index].flag),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: controller.selectedIndex.value == index
                                ? Icon(Icons.radio_button_checked,
                                    color: Colors.green)
                                : Icon(Icons.radio_button_off),
                          ),
                          tileColor: Colors.green[100],
                          onTap: () => controller.selectLanguage(index),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
