class BottomNavStates {
  final int currentIndex;
  final String? selectedGenre;

  BottomNavStates({required this.currentIndex, this.selectedGenre});

  BottomNavStates copyWith({int? currentIndex, String? selectedGenre}) {
    return BottomNavStates(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
  }
}
