enum AgeCategory { everyone, adults, youth, children }

extension AgeCategoryX on AgeCategory {
  String get label {
    switch (this) {
      case AgeCategory.everyone:
        return 'Wszyscy';
      case AgeCategory.adults:
        return 'Dorośli';
      case AgeCategory.youth:
        return 'Młodzież';
      case AgeCategory.children:
        return 'Dzieci';
    }
  }

  static AgeCategory? fromLabel(String label) {
    return AgeCategory.values.firstWhere(
      (e) => e.label == label,
      orElse: () => AgeCategory.everyone,
    );
  }
}
