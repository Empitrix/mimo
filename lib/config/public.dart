import 'package:flutter/cupertino.dart';

String dbPath = "";

int genNum = 2;  // Number of Row/Column s
// ValueNotifier<int> genNum = ValueNotifier<int>(2);

// Different of levels: 2, 3, 4
int level = 1;

// Number of repetition of each level
// Max level (4) have number of infinite for repeat
int repetition = 10;


bool gameIsRunning = true;

bool isComputerFinished = false;