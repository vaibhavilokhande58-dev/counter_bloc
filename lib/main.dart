import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';
import 'bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter BLoC',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Arial'),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: const CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      body: SafeArea(
        child: BlocConsumer<CounterBloc, CounterState>(
          listener: (context, state) {
            if (state.isReset) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Counter reset successfully'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },

          builder: (context, state) {
            final int counter = state.counter;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

              child: Column(
                children: [
                  const SizedBox(height: 15),

                  const Text(
                    'Counter BLoC',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'State Management',
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 35),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6C63FF), Color(0xFF8B7CFF)],
                      ),

                      borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.25),
                          blurRadius: 25,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Text(
                          'CURRENT VALUE',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          '$counter',
                          style: const TextStyle(
                            fontSize: 78,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          '$counter / 100',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),

                        const SizedBox(height: 18),

                        ClipRRect(borderRadius: BorderRadius.circular(20)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 45),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CounterButton(
                        icon: Icons.remove,
                        onPressed: counter == 0
                            ? null
                            : () {
                                context.read<CounterBloc>().add(Decrement());
                              },
                      ),

                      const SizedBox(width: 35),

                      _CounterButton(
                        icon: Icons.add,
                        onPressed: counter == 100
                            ? null
                            : () {
                                context.read<CounterBloc>().add(Increment());
                              },
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          'Decrease',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 35),

                      SizedBox(
                        width: 90,
                        child: Text(
                          'Increase',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  if (counter == 100)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        'Maximum limit reached',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,
                    height: 58,

                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<CounterBloc>().add(Reset());
                      },

                      icon: const Icon(Icons.refresh_rounded),

                      label: const Text(
                        'RESET COUNTER',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6C63FF),

                        side: const BorderSide(
                          color: Color(0xFF6C63FF),
                          width: 1.5,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _CounterButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null;

    return SizedBox(
      height: 75,
      width: 90,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          elevation: disabled ? 0 : 5,

          backgroundColor: disabled ? Colors.grey.shade300 : Colors.white,

          foregroundColor: disabled
              ? Colors.grey.shade500
              : const Color(0xFF6C63FF),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),

        child: Icon(icon, size: 32),
      ),
    );
  }
}
