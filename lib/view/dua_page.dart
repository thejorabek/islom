import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:islom/bloc/counter_bloc/counter_bloc.dart';
import 'package:islom/bloc/counter_bloc/counter_event.dart';
import 'package:islom/bloc/counter_bloc/counter_state.dart';
import 'package:islom/utils/colors/colors.dart';

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
                Center(
                  child: GestureDetector(
                    onTap: state.remaining > 0
                        ? () {
                            context.read<CountdownBloc>().add(DecrementCountdown());
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: CircularCountdown(
                        countdownTotal: 30,
                        countdownRemaining: state.remaining,
                        countdownCurrentColor: state.currentColor,
                        strokeWidth: width * .07,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: height * .34,
                    left: state.remaining >= 10 ? width * .32 : width * .40,
                    child: GestureDetector(
                      onTap: state.remaining > 0
                          ? () {
                              context.read<CountdownBloc>().add(DecrementCountdown());
                            }
                          : null,
                      child: Text(
                        '${state.remaining}',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 135,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Positioned(
                    top: height * .73,
                    left: width * .44,
                    child: IconButton(
                        onPressed: () => {context.read<CountdownBloc>().add(ResetCountdown())},
                        icon: Icon(Icons.refresh_rounded, color: Colors.white, size: 50)))
              ],
            );
          },
        ));
  }
}
