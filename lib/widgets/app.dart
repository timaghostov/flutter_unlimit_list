

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/data_list_bloc.dart';
import 'package:unlimit_list/bloc/stack_bloc.dart';
import 'package:unlimit_list/model/event/load_new_person.dart';
import 'package:unlimit_list/model/state/list_state.dart';
import 'package:unlimit_list/model/state/stack_state.dart';
import 'package:unlimit_list/widgets/screen/horizontal_list.dart';
import 'package:unlimit_list/widgets/screen/vertical_list.dart';



class App extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        IsolateBlocProvider.of<ListPersonBloc, ListState>(context)
            .add(LoadNewPerson());
        List<Widget> listWidget = new List();        
        var vList = VerticalListPersonScreen();
        // var hList = HorizontalListPersonScreen();
        listWidget.add(vList);
        return MaterialApp(
            home: IsolateBlocBuilder<StackBloc, StackState>(
                builder: (context, stackState) {
                    if ( stackState.isOpen ) {
                        if (listWidget.length < 2) {
                            var hList = HorizontalListPersonScreen( stackState.index );
                            listWidget.add(hList);
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                                hList.state?.jumpTo( stackState.index );
                            });
                        }
                        return Stack(
                            children: listWidget,
                        );
                    } else {
                        if (listWidget.length > 1) {
                            listWidget.removeRange(1, listWidget.length);
                        }
                        return Stack(
                            children: listWidget,
                        );
                    }
                },
            ),
        );
    }
}




