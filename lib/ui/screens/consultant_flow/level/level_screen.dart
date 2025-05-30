import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'level_vm.dart'; // يفترض أن LevelCubit و LevelState هنا

class ConsultantLevelScreen extends StatefulWidget {
  const ConsultantLevelScreen({super.key});
  static const String routeName = 'consulLevel';

  @override
  State<ConsultantLevelScreen> createState() => _ConsultantLevelScreenState();
}

class _ConsultantLevelScreenState extends State<ConsultantLevelScreen> {
  @override
  void initState() {
    super.initState();
    // استدعاء تحميل البيانات تلقائياً عند دخول الشاشة
    context.read<LevelCubit>().fetchLevels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consultant Levels")),
      body: BlocBuilder<LevelCubit, LevelState>(
        builder: (context, state) {
          if (state is LevelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LevelLoaded) {
            if (state.levels.isEmpty) {
              return const Center(child: Text("No levels found."));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: state.levels.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final level = state.levels[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.jpeg'),
                    radius: 25,
                  ),
                  title: Text(level.fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rate: ${level.rate}"),
                      const SizedBox(height: 4),
                      Text(
                        level.shortBiography,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                );
              },
            );
          } else if (state is LevelError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          // حالة البداية أو أي حالة غير متوقعة
          return const Center(child: Text("Press refresh to load levels."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<LevelCubit>().fetchLevels(),
        tooltip: "Refresh Levels",
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
