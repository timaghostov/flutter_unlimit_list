



import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/head_index_bloc.dart';
import 'package:unlimit_list/model/state/head_index_state.dart';
class HeadIndex extends StatelessWidget {

    final int count;

    HeadIndex(this.count);

    @override
    Widget build(BuildContext context) {
        return IsolateBlocBuilder<HeadIndexStateBloc, HeadIndexState>(
            builder: (context, state) {
                int index = state.currentIndex == null ? 1 : state.currentIndex.index + 1;
                return Text( '$index из $count' );
            },
        );
    }
}