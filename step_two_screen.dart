import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_profile.dart';
import '../utils/validators.dart';
import '../widgets/step_scaffold.dart';
import 'summary_screen.dart';

/// Maquette 02_Etape2_ProfilPro
class StepTwoScreen extends StatefulWidget {
  final UserProfile profil;
  const StepTwoScreen({super.key, required this.profil});

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _profession = TextEditingController();
  final _experience = TextEditingController();
  final _tjm = TextEditingController();
  final _bio = TextEditingController();

  @override
  void dispose() {
    for (final c in [_profession, _experience, _tjm, _bio]) {
      c.dispose();
    }
    super.dispose();
  }

  void _suivant() {
    if (!_formKey.currentState!.validate()) return;
    // Fusion : on enrichit une copie du profil reçu
    final profil = widget.profil.copyWith(
      profession: _profession.text.trim(),
      experience: int.parse(_experience.text.trim()),
      tjm: double.parse(_tjm.text.trim().replaceAll(',', '.')),
      biographie: _bio.text.trim(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SummaryScreen(profil: profil)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      title: 'Profil Professionnel – Étape 2/3',
      progress: 2 / 3,
      formKey: _formKey,
      buttonLabel: 'Suivant',
      onPressed: _suivant,
      leading: IconButton(
        tooltip: 'Retour',
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      children: [
        TextFormField(
          controller: _profession,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              labelText: 'Profession', prefixIcon: Icon(Icons.work_outline)),
          validator: Validators.profession,
        ),
        TextFormField(
          controller: _experience,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          decoration: const InputDecoration(
              labelText: 'Années d’expérience',
              prefixIcon: Icon(Icons.timeline)),
          validator: Validators.experience,
        ),
        TextFormField(
          controller: _tjm,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            LengthLimitingTextInputFormatter(7),
          ],
          decoration: const InputDecoration(
            labelText: 'TJM',
            helperText: 'Entre 50 et 3000 €',
            prefixIcon: Icon(Icons.payments_outlined),
            suffixText: '€',
          ),
          validator: Validators.tjm,
        ),
        TextFormField(
          controller: _bio,
          minLines: 5,
          maxLines: 5,
          maxLength: 300, // compteur « 0/300 » sous le champ
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            labelText: 'Biographie (facultative)',
            alignLabelWithHint: true,
          ),
          validator: Validators.biographie,
        ),
      ],
    );
  }
}
