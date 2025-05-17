import 'package:flutter/material.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';

import '../../../../utils/widgets/appButton.dart';

class NotFoundTreatCaseDetails extends StatelessWidget {
  const NotFoundTreatCaseDetails({super.key});
  static const String routeName = 'notfound';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // مهم علشان يوسّط المحتوى
            children: [
              const Image(image: AssetImage('assets/sent.png')),
              const SizedBox(height: 30),
              const Text(
                'Your case is being sent to a specialist. You will receive a response as soon as possible.',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, MainDentistScreen.routeName);
                  },
                  text: "OK",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
