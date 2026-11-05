import 'package:flutter_test/flutter_test.dart';
import 'package:tp_inscription/utils/validators.dart';

void main() {
  group('nom', () {
    test('vide', () => expect(Validators.nom(''), isNotNull));
    test('trop court', () => expect(Validators.nom('A'), isNotNull));
    test('chiffres refusés', () => expect(Validators.nom('Ali3'), isNotNull));
    test('accents, tiret, apostrophe',
        () => expect(Validators.nom("Jean-Éric D'Arc"), isNull));
  });

  group('email', () {
    test('sans @', () => expect(Validators.email('claire.com'), isNotNull));
    test('sans domaine', () => expect(Validators.email('claire@'), isNotNull));
    test('valide', () => expect(Validators.email('claire@exemple.com'), isNull));
  });

  group('motDePasse', () {
    test('trop court', () => expect(Validators.motDePasse('Ab1'), isNotNull));
    test('sans majuscule',
        () => expect(Validators.motDePasse('abcdefg1'), isNotNull));
    test('sans chiffre',
        () => expect(Validators.motDePasse('Abcdefgh'), isNotNull));
    test('valide', () => expect(Validators.motDePasse('Abcdefg1'), isNull));
  });

  test('confirmation', () {
    expect(Validators.confirmation('x', 'y'), isNotNull);
    expect(Validators.confirmation('Abcdefg1', 'Abcdefg1'), isNull);
  });

  group('experience', () {
    test('hors bornes', () => expect(Validators.experience('51'), isNotNull));
    test('non numérique', () => expect(Validators.experience('abc'), isNotNull));
    test('valide', () => expect(Validators.experience('5'), isNull));
  });

  group('tjm', () {
    test('trop bas', () => expect(Validators.tjm('10'), isNotNull));
    test('trop haut', () => expect(Validators.tjm('3001'), isNotNull));
    test('virgule acceptée', () => expect(Validators.tjm('450,5'), isNull));
  });

  group('biographie', () {
    test('facultative', () => expect(Validators.biographie(''), isNull));
    test('trop courte', () => expect(Validators.biographie('Court'), isNotNull));
    test('valide', () {
      expect(Validators.biographie('Développeuse mobile passionnée.'), isNull);
    });
  });

  test('conditions', () {
    expect(Validators.conditions(false), isNotNull);
    expect(Validators.conditions(true), isNull);
  });
}
