import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/di/di.dart';
import '../domain/usecase/get_cosultantId_usecase.dart';
import 'case_consultant_vm.dart';

class ConsultantData extends StatefulWidget {
  final int caseRequestId;
  static const String routeName = 'consulData';
  const ConsultantData({super.key, required this.caseRequestId});

  @override
  State<ConsultantData> createState() => _ConsultantDataState();
}

class _ConsultantDataState extends State<ConsultantData> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              CaseConsultantCubit(getIt<GetCaseConsultantDataUseCase>())
                ..fetchCaseConsultants(widget.caseRequestId),
      child: Scaffold(
        appBar: AppBar(title: const Text("تفاصيل الاستشارة")),
        body: BlocBuilder<CaseConsultantCubit, CaseConsultantState>(
          builder: (context, state) {
            if (state is CaseConsultantLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CaseConsultantLoaded) {
              return ListView.builder(
                itemCount: state.consultants.length,
                itemBuilder: (context, index) {
                  final consultant = state.consultants[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'http://skillbridge1.runasp.net/uploads/${consultant.consultantPhoto}',
                      ),
                    ),
                    title: Text(consultant.consultantName),
                    subtitle: Text(consultant.shortBiography),
                    trailing: Text(
                      "Rate: ${consultant.rate.toStringAsFixed(2)}",
                    ),
                  );
                },
              );
            } else if (state is CaseConsultantError) {
              return Center(child: Text("خطأ: ${state.message}"));
            } else {
              return const Center(child: Text("لا يوجد بيانات بعد"));
            }
          },
        ),
      ),
    );
  }
}
