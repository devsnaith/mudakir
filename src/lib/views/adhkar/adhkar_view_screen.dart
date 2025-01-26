import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mudakir/models/adhkar/adhkar_model.dart';
import 'package:mudakir/models/adhkar/adhkar_section_model.dart';
import 'package:mudakir/repositories/adhkar_repository.dart';
import 'package:mudakir/views/adhkar/widgets/adhkar_view_screen_appbar.dart';
import 'package:mudakir/views/adhkar/widgets/view/adhkar_view_card.dart';

class AdhkarViewScreen extends StatefulWidget {
  
  final Object? adhkarSectionModel;
  const AdhkarViewScreen(this.adhkarSectionModel, {super.key});

  @override
  State<AdhkarViewScreen> createState() => _AdhkarViewScreenState();
}

class _AdhkarViewScreenState extends State<AdhkarViewScreen> {

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late AdhkarSectionModel model;

  final List<GlobalKey> _keys = [];
  List<AdhkarModel> _adhkars = [];

  AdhkarViewCard _card(
    Key? key,
    AdhkarModel dhukir, 
    VoidCallback? dismiss, 
    ScrollController? scrollController, 
    Animation<double> animation,
  ) {
    return AdhkarViewCard(
      key: key,
      animation: animation, 
      dismiss: dismiss ?? () {}, 
      scrollController: scrollController ?? ScrollController(), 
      dhukir: dhukir
    );
  }

  @override
  void initState() {
    super.initState();
    model = widget.adhkarSectionModel as AdhkarSectionModel;
    _adhkars = AdhkarRepository().getAdhkarsBySectionId(model.id);
    _adhkars.map((e) => _keys.add(GlobalKey())).toList();
  }

  void _dismiss(int index) => setState(() {
    _keys.remove(_keys[index]);
    
    AdhkarModel mode =  _adhkars[index];
    _adhkars.remove(mode);
    
    if(_listKey.currentState != null) {  
      _listKey.currentState!.removeItem(index, (context, animation) {
        return _card(null, mode, null, _scrollController, animation);
      }, duration: Duration(milliseconds: 300));
    }
  });

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return _card(_keys[index], _adhkars[index],  () => _dismiss(index), _scrollController, animation);
  }

  @override
  Widget build(BuildContext context) {
    
    if (_adhkars.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.pop(); 
      });
    }

    return Scaffold(
      appBar: AdhkarViewAppbar(model),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _adhkars.length,
        controller: _scrollController,
        itemBuilder: _buildItem
      ),
    );
    
  }
}