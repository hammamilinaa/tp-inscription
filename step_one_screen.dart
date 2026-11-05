import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../utils/validators.dart';
import '../widgets/step_scaffold.dart';
import 'step_two_screen.dart';

/// Maquette 01_Etape1_InfosPerso
class StepOneScreen extends StatefulWidget {
  const StepOneScreen({super.key});

  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmKey = GlobalKey<FormFieldState<String>>();
  final _nom = TextEditingController();
  final _prenom = TextEditingController();
  final _email = TextEditingController();
  final _mdp = TextEditingController();
  final _confirm = TextEditingController();
  bool _masque = true;

  @override
  void dispose() {
    for (final c in [_nom, _prenom, _email, _mdp, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _suivant() {
    if (!_formKey.currentState!.validate()) return;
    final profil = UserProfile(
      nom: _nom.text.trim(),
      prenom: _prenom.text.trim(),
      email: _email.text.trim(),
      motDePasse: _mdp.text,
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StepTwoScreen(profil: profil)),
    );
  }

  Widget? get _oeil => IconButton(
        tooltip: _masque ? 'Afficher' : 'Masquer',
        icon: Icon(_masque ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() => _masque = !_masque),
      );

  @override
  Widget build(BuildContext context) {
    return StepScaffold(
      title: 'Inscription – Étape 1/3',
      progress: 1 / 3,
      formKey: _formKey,
      buttonLabel: 'Suivant',
      onPressed: _suivant,
      children: [
        TextFormField(
          controller: _nom,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              labelText: 'Nom', prefixIcon: Icon(Icons.person_outline)),
          validator: Validators.nom,
        ),
        TextFormField(
          controller: _prenom,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              labelText: 'Prénom', prefixIcon: Icon(Icons.person_outline)),
          validator: Validators.nom,
        ),
        TextFormField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
              labelText: 'E-mail', prefixIcon: Icon(Icons.mail_outline)),
          validator: Validators.email,
        ),
        TextFormField(
          controller: _mdp,
          obscureText: _masque,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Mot de passe',
            helperText: '8 caractères min., 1 majuscule, 1 chiffre',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: _oeil,
          ),
          validator: Validators.motDePasse,
          // Revalidation croisée de la confirmation
          onChanged: (_) {
            if (_confirm.text.isNotEmpty) _confirmKey.currentState?.validate();
          },
        ),
        TextFormField(
          key: _confirmKey,
          controller: _confirm,
          obscureText: _masque,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: 'Confirmation du mot de passe',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: _oeil,
          ),
          validator: (v) => Validators.confirmation(v, _mdp.text),
          onFieldSubmitted: (_) => _suivant(),
        ),
      ],
    );
  }
}
