import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/public/enums/report_type.dart';
import 'package:mudakir/services/app_version.dart';

class ReportHandler extends StatelessWidget {
  
  final String title;
  final String description;
  final String serviceName;
  final ReportType reportType;
  
  const ReportHandler({
    required this.reportType,
    required this.serviceName, 
    required this.title,
    required this.description,   
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    AppVersion.log("ReportHandler <-> $serviceName", description);

    IconData icon = reportType == ReportType.bug
       ? Icons.bug_report
       : reportType == ReportType.future
          ? Icons.feedback
          : Icons.error;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          FilledButton.tonal(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: Text("${reportType.name} - $serviceName"),
                    icon: Icon(icon),
                    content: SizedBox(
                      height: 100,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(title),
                              Text(description),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () => Navigator.of(context).pop(), 
                        child: Center(child: Icon(Icons.close))
                      ),
                    ],
                  );
                },
              );
            }, 
            child: Center(
              child: Text(AppLocalizations.of(context)!.msg_report_send_button_name),
            )
          ),
        ],
      ),
    );
    
  }
  
}