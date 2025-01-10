import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:islom/bloc/counter_bloc/counter_bloc.dart';
import 'package:islom/bloc/counter_bloc/counter_event.dart';
import 'package:islom/bloc/counter_bloc/counter_state.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.background,
        body: BlocBuilder<CountdownBloc, CountdownState>(
          builder: (context, state) {
            double width = MediaQuery.of(context).size.width;
            double height = MediaQuery.of(context).size.height;
            return Stack(
              children: [
                Positioned(
                  top: height * .09,
                  left: width * .07,
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
                            DuaList.duaList[7],
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                          SizedBox(height: height * .02),
                          Text(
                            DuaList.duaTranslation[7],
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
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
                      padding: EdgeInsets.only(top: height * .32, left: width * .1, right: width * .1),
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
                    top: height * .49,
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
                      top: height * .78,
                      left: width * .1,
                      child: SizedBox(
                          width: width * .8, // Adjust this value as needed
                          height: height * .15, // Adjust this value as needed
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
