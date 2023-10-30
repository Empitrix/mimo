import 'package:flutter/cupertino.dart';
import 'package:mimo/config/public.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sq;

Future<void> updateDbPath() async {
	dbPath = path.join(
		(await getApplicationSupportDirectory()).absolute.path,
		"mimo.db"
	);
	debugPrint("DB Path: $dbPath");
}



Future<Database> _createDB() async {
	Database? db;
	if(Platform.isWindows || Platform.isLinux){
		sq.sqfliteFfiInit();
		db = await sq.databaseFactoryFfi.openDatabase(dbPath);
	} else {
		db = await sq.openDatabase(dbPath);
	}
	return db;
}


class DB {
	Future<void> init() async {
		Database db = await _createDB();

		// Create integration table
		db.execute('''
			CREATE TABLE IF NOT EXISTS mimo (
				score BIGINT
			)
		''');
		List<Map<String, Object?>> result = await db.query("mimo");
		if(result.isEmpty){
			await db.insert("mimo", {"score": 0});
		}
		db.close();
	}

	Future<int> getScore() async {
		Database db = await _createDB();
		List<Map> result = await db.query("mimo");
		debugPrint("Result: ${result.first}");
		return int.parse(result.first["score"].toString());
	}

	Future<void> updateScore(int newScore) async {
		Database db = await _createDB();
		await db.update("mimo", {"score": newScore});
		db.close();
	}

}