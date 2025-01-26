import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mudakir/models/adhkar/adhkar_model.dart';
import 'package:mudakir/models/adhkar/adhkar_section_model.dart';
import 'package:mudakir/services/app_version.dart';

class AdhkarRepository {
  
  AdhkarRepository._instance();
  static final AdhkarRepository _repository = AdhkarRepository._instance();
  factory AdhkarRepository() => _repository;
  
  List<AdhkarModel> _adhkars = [];
  List<AdhkarSectionModel> _sections = [];

  Future<void> fetchAdhkars() async {
    if (_adhkars.isNotEmpty && _sections.isNotEmpty) {
      AppVersion.log("AdhkarRepository", "Adhkars is not empty!");
      return;
    }

    final String adhkars = await rootBundle.loadString("assets/json/adhkar/adhkar.json");
    final String sections = await rootBundle.loadString("assets/json/adhkar/sections_db.json");
    
    List<dynamic> adhkarsList = await json.decode(adhkars);
    AppVersion.log("AdhkarRepository", "Fetching adhkars...");
    _adhkars = adhkarsList.map((e) => AdhkarModel.fromJson(e)).toList();
    AppVersion.log("AdhkarRepository", "Fetched ${_adhkars.length} adhkars");

    List<dynamic> sectionsList = await json.decode(sections);
    _sections = sectionsList.map((e) => AdhkarSectionModel.fromJson(e)).toList();
    AppVersion.log("AdhkarRepository", "Fetched ${_sections.length} Sections for adhkars");

  }

  List<AdhkarModel> getAdhkarsBySectionId(int section_id) {
    List<AdhkarModel> adhkars = [];
    for (AdhkarModel dhikr in _adhkars) {
      if(dhikr.section_id == section_id) {
        adhkars.add(dhikr);
      }
    }
    return adhkars;
  }

  List<AdhkarSectionModel> get sections => _sections;

}