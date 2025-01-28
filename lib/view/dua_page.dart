import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/counter_bloc/counter_bloc.dart';
import 'package:islom/bloc/counter_bloc/counter_event.dart';
import 'package:islom/bloc/counter_bloc/counter_state.dart';
import 'package:islom/bloc/dua_bloc/dua_bloc.dart';
import 'package:islom/bloc/dua_bloc/dua_state.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Dua', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Quicksand')),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: CustomColors.background,
            iconTheme: IconThemeData(color: Colors.white)),
        backgroundColor: CustomColors.background,
        body: BlocBuilder<CountdownBloc, CountdownState>(
          builder: (context, state) {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            return Stack(
              children: [
                Positioned(
                  left: width * .07,
                  child: GestureDetector(
                    onTap: () => context.push('/dua_helper'),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: CustomColors.tile),
                      width: width * .85,
                      child: Center(
                        child: BlocBuilder<DuaBloc, DuaState>(
                          builder: (context, state) {
                            if (state is DuaSelected) {
                              return Column(
                                children: [
                                  SizedBox(height: height * .02),
                                  Text(
                                    state.dua,
                                    style: TextStyle(color: Colors.white, fontSize: 26),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: height * .02),
                                  Text(
                                    state.translation,
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                            return Column(
                              children: [
                                SizedBox(height: height * .02),
                                Text(
                                  DuaList.duaList[0],
                                  style: TextStyle(color: Colors.white, fontSize: 26),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: height * .02),
                                Text(
                                  DuaList.duaTranslation[0],
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: state.remaining > 0
                        ? () {
                            context.read<CountdownBloc>().add(DecrementCountdown());
                          }
                        : null,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * .25, left: width * .1, right: width * .1),
                      child: CircularCountdown(
                        countdownTotal: 30,
                        countdownRemaining: state.remaining,
                        countdownCurrentColor: state.currentColor,
                        strokeWidth: width * .07,
                        diameter: width * .75,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: height * .39,
                    left: state.remaining >= 10 ? width * .29 : width * .40,
                    child: GestureDetector(
                        onTap: state.remaining > 0
                            ? () {
                                context.read<CountdownBloc>().add(DecrementCountdown());
                              }
                            : null,
                        child: AnimatedFlipCounter(
                          value: state.remaining,
                          textStyle: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 135,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ))),
                Visibility(
                  visible: state.remaining == 0,
                  child: Positioned(
                      top: height * .65,
                      left: width * .1,
                      child: SizedBox(
                          width: width * .8,
                          height: height * .15,
                          child: IconButton(
                              onPressed: () => {context.read<CountdownBloc>().add(ResetCountdown())},
                              icon: Icon(Icons.refresh_rounded, color: Colors.white, size: 50)))),
                ),
              ],
            );
          },
        ));
  }
}
