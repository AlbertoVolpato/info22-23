indexToChoice(int index) {
  switch (index) {
    case 0:
      return 'r';
    case 1:
      return 'p';
    case 2:
      return 's';
  }
}

choiceToWord(String choice) {
  switch (choice) {
    case 'r':
      return 'sasso';
    case 'p':
      return 'carta';
    case 's':
      return 'forbice';
  }
}

game(String userChoice) {
  List<String> choices = ['r', 'p', 's'];
  choices.shuffle();

  String computerChoice = choices.first;

  int result;
  var results;

  switch (userChoice + computerChoice) {
    // Draw
    case 'rr':
      result = 0;
      break;
    case 'pp':
      result = 0;
      break;
    case 'ss':
      result = 0;
      break;

    // User Wins
    case 'rs':
      result = 1;
      break;
    case 'pr':
      result = 1;
      break;
    case 'sp':
      result = 1;
      break;

    // Computer Wins
    case 'rp':
      result = -1;
      break;
    case 'pt':
      result = -1;
      break;
    case 'sr':
      result = -1;
      break;
  }

  return {results: "resoult", computerChoice: 'computerChoice'};
}