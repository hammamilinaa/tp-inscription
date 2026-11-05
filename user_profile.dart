/// Modèle immuable : on ne modifie jamais l'objet, on en crée une copie.
class UserProfile {
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final String profession;
  final int? experience;
  final double? tjm;
  final String biographie;

  const UserProfile({
    this.nom = '',
    this.prenom = '',
    this.email = '',
    this.motDePasse = '',
    this.profession = '',
    this.experience,
    this.tjm,
    this.biographie = '',
  });

  UserProfile copyWith({
    String? nom,
    String? prenom,
    String? email,
    String? motDePasse,
    String? profession,
    int? experience,
    double? tjm,
    String? biographie,
  }) {
    return UserProfile(
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      motDePasse: motDePasse ?? this.motDePasse,
      profession: profession ?? this.profession,
      experience: experience ?? this.experience,
      tjm: tjm ?? this.tjm,
      biographie: biographie ?? this.biographie,
    );
  }
}
