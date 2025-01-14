import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/dua_bloc/dua_bloc.dart';
import 'package:islom/bloc/dua_bloc/dua_event.dart';
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
        leading: IconButton(onPressed: () => context.pop(context), icon: Icon(Icons.arrow_back_ios_new_outlined)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
          itemCount: DuaList.duaList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  context.read<DuaBloc>().add(
                        SelectDuaEvent(
                          dua: DuaList.duaList[index],
                          translation: DuaList.duaTranslation[index],
                          index: index,
                        ),
                      );
                  context.push('/dua');
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: CustomColors.tile),
                  width: width * .85,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Makes column wrap its content
                      children: [
                        SizedBox(height: height * .02),
                        Text(
                          DuaList.duaList[index],
                          style: TextStyle(color: Colors.white, fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * .02),
                        Text(
                          DuaList.duaTranslation[index],
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * .02),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
