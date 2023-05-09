List<int> newCustomFunction(
  String allot1,
  String max1,
  String available1,
  String processesNum,
  String resourcesNum,
) {
  try {
    List<List<int>> convertStringTo2DArray(String inputString) {
      return inputString
          .split('\n')
          .map((row) => row.split(' ').map(int.parse).toList())
          .toList();
    }

    List<int> convertStringToArray(String inputString) {
      return inputString.split(' ').map(int.parse).toList();
    }

    List<List<int>> createEmpty2DArray(List<List<int>> inputArray) {
      int numRows = inputArray.length;
      int numCols = inputArray.isEmpty ? 0 : inputArray[0].length;
      return List.generate(numRows, (_) => List.filled(numCols, 0));
    }

    List<List<int>> max = convertStringTo2DArray(max1);

    List<int> available = convertStringToArray(available1);

    List<List<int>> allot = convertStringTo2DArray(allot1);

    List<List<int>> need = createEmpty2DArray(allot);

    List<bool> isFinished = List<bool>.filled(100, false);
    List<int> sequence = List<int>.filled(100, 0);

    List<int> isSafe(int N, int M) {
      List<int> work = List<int>.filled(100, 0);
      int count = 0;
      for (int i = 0; i < M; i++) {
        work[i] = available[i];
      }
      for (int i = 0; i < 100; i++) {
        isFinished[i] = false;
      }
      while (count < N) {
        bool canAllot = false;
        for (int i = 0; i < N; i++) {
          if (isFinished[i] == false) {
            int j;
            for (j = 0; j < M; j++) {
              if (work[j] < need[i][j]) {
                break;
              }
            }
            if (j == M) {
              for (j = 0; j < M; j++) {
                work[j] += allot[i][j];
              }
              sequence[count++] = i;
              isFinished[i] = true;
              canAllot = true;
            }
          }
        }
        if (canAllot == false) {
          print("System Is not safe");
          return [0, 0];
        }
      }
      print("System is in safe state");
      sequence = sequence.sublist(0, N);
      print("Safe sequence: ${sequence.sublist(0, N).join(' ')}");
      return sequence.sublist(0, N);
    }

    //Main

    int N = int.parse(processesNum); //proc
    int M = int.parse(resourcesNum); //resource

    // calculation of need matrix
    for (int i = 0; i < N; i++) {
      for (int j = 0; j < M; j++) {
        need[i][j] = max[i][j] - allot[i][j];
      }
    }

    return isSafe(N, M);
  } catch (e) {
    print(e);
    return [0, 0];
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
