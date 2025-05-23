import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'level_vm.dart';

class ConsultantLevelScreen extends StatefulWidget {
  const ConsultantLevelScreen({super.key});
  static const String routeName ='consulLevel';

  @override
  State<ConsultantLevelScreen> createState() => _ConsultantLevelScreenState();
}

class _ConsultantLevelScreenState extends State<ConsultantLevelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultant Levels")),
      body: BlocBuilder<LevelCubit, LevelState>(
        builder: (context, state) {
          if (state is LevelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LevelLoaded) {
            return ListView.builder(
              itemCount: state.levels.length,
              itemBuilder: (context, index) {
                final level = state.levels[index];
                return ListTile(
                  leading: const Icon(Icons.star, color: Colors.orange),
                  title: Text(level.name),
                  subtitle: Text("ID: ${level.id}"),
                );
              },
            );
          } else if (state is LevelError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<LevelCubit>().fetchLevels(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
