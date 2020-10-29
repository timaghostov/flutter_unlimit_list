



import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/data_list_bloc.dart';
import 'package:unlimit_list/model/event/vertical_item_builder.dart';
import 'package:unlimit_list/model/state/list_state.dart';
import 'package:unlimit_list/widgets/vertical_list_item.dart';

class VerticalListPersonScreen extends StatefulWidget {

    const VerticalListPersonScreen( {Key key} ) : super(key: key);

    @override
    _VerticalListPersonScreenState createState() => _VerticalListPersonScreenState();

}

class _VerticalListPersonScreenState extends State<VerticalListPersonScreen> {

    ScrollController _controller;

    @override
    void initState() {
        super.initState();
        _controller = ScrollController();
    }

    void dispose(){
        _controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Unlimit list"),
            ),
            body: IsolateBlocBuilder<ListPersonBloc, ListState>(builder: (context, state) {
                var itemCount = state.size();
                // print("itemCount :: $itemCount");
                return ListView.builder(
                    controller: _controller,
                    itemCount: itemCount,                    
                    itemBuilder: (_, index) => VerticalItem (
                        onCreate: () {                            
                            IsolateBlocProvider.of<ListPersonBloc, ListState>(context)
                                .add( VItemBuilder(index) );
                        },
                        index: index,
                        itemData: state.item(index)
                    )
                );
            }),
        );
    }

}