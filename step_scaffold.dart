import 'package:flutter/material.dart';
import 'tp_inscription/theme/app_theme.dart';

/// Gabarit commun aux 3 maquettes :
/// AppBar (56) + barre de progression (4) + contenu défilant (padding 16,
/// espacement 16) + bouton Primary collé en bas.
class StepScaffold extends StatelessWidget {
  final String title;
  final double progress;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Widget? leading;
  final List<Widget>? actions;
  final AutovalidateMode autovalidate;

  const StepScaffold({
    super.key,
    required this.title,
    required this.progress,
    required this.formKey,
    required this.children,
    required this.buttonLabel,
    required this.onPressed,
    this.leading,
    this.actions,
    this.autovalidate = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading,
        title: Text(title),
        actions: actions,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4,
            color: AppColors.primary,
            backgroundColor: AppColors.track,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidate,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < children.length; i++) ...[
                        if (i > 0) const SizedBox(height: 16),
                        children[i],
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: FilledButton(
                    onPressed: onPressed, child: Text(buttonLabel)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
