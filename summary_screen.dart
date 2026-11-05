import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/step_scaffold.dart';
import 'step_one_screen.dart';

/// Maquette 03_Recapitulatif
class SummaryScreen extends StatefulWidget {
  final UserProfile profil;
  const SummaryScreen({super.key, required this.profil});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();

  void _retourDebut() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const StepOneScreen()),
      (route) => false,
    );
  }

  Future<void> _reinitialiser() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tout effacer ?'),
        content: const Text('Les informations saisies seront perdues.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Annuler')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Effacer')),
        ],
      ),
    );
    if (ok == true && mounted) _retourDebut();
  }

  /// Dialogue de succès (overlay de la maquette), non fermable à côté.
  Future<void> _confirmer() async {
    if (!_formKey.currentState!.validate()) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        icon: const Icon(Icons.check_circle_outline,
            size: 48, color: AppColors.primary),
        title: const Text('Compte créé', textAlign: TextAlign.center),
        content: const Text('Votre inscription a bien été enregistrée.',
            textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: () => Navigator.pop(ctx),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Terminer'),
            ),
          ),
        ],
      ),
    );
    if (mounted) _retourDebut();
  }

  /// Carte récapitulative : bordure fine, titre de section + lignes.
  Widget _carte(String titre, List<(String, String)> lignes) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.track),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Text(titre,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.title)),
            ),
            for (final (libelle, valeur) in lignes)
              ListTile(
                dense: true,
                title: Text(libelle,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.muted)),
                subtitle: Text(valeur.isEmpty ? '—' : valeur,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.ink)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profil;
    final tjm = p.tjm == null
        ? ''
        : '${p.tjm! % 1 == 0 ? p.tjm!.toInt() : p.tjm} €';

    return StepScaffold(
      title: 'Récapitulatif de votre profil',
      progress: 1,
      formKey: _formKey,
      autovalidate: AutovalidateMode.disabled,
      buttonLabel: 'Confirmer et créer le compte',
      onPressed: _confirmer,
      actions: [
        IconButton(
          tooltip: 'Réinitialiser',
          icon: const Icon(Icons.restart_alt),
          onPressed: _reinitialiser,
        ),
      ],
      children: [
        _carte('Identité', [
          ('Nom', p.nom),
          ('Prénom', p.prenom),
          ('E-mail', p.email),
          // Le mot de passe n'est jamais affiché en clair
          ('Mot de passe', '•' * p.motDePasse.length),
        ]),
        _carte('Profil professionnel', [
          ('Profession', p.profession),
          ('Expérience', p.experience == null ? '' : '${p.experience} ans'),
          ('TJM', tjm),
          ('Biographie', p.biographie),
        ]),
        // Champ personnalisé : case à cocher obligatoire
        FormField<bool>(
          initialValue: false,
          validator: Validators.conditions,
          builder: (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primary,
                checkColor: AppColors.onPrimary,
                title: const Text('J’accepte les conditions',
                    style: TextStyle(fontSize: 14)),
                value: state.value,
                onChanged: (v) => state.didChange(v),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(state.errorText!,
                      style: const TextStyle(
                          color: AppColors.errorText, fontSize: 12)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
