import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';

class DuaHelperPage extends StatelessWidget {
  const DuaHelperPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.background,
        title: Text('Dua', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(onPressed: () => context.push('/dua'), icon: Icon(Icons.arrow_back_ios_new_outlined)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(itemCount: DuaList.duaList.length,itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: CustomColors.tile),
            width: width * .85,
            height: height * .3,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: height * .02),
                  Text(
                    DuaList.duaList[index],
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  SizedBox(height: height * .02),
                  Text(
                    DuaList.duaTranslation[index],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
