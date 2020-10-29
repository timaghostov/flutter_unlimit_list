

import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/data_list_bloc.dart';
import 'package:unlimit_list/bloc/head_index_bloc.dart';
import 'package:unlimit_list/bloc/stack_bloc.dart';
import 'package:unlimit_list/model/state/head_index_state.dart';
import 'package:unlimit_list/model/state/list_state.dart';
import 'package:unlimit_list/model/state/stack_state.dart';
import 'package:unlimit_list/service/isolate_init.dart';
import 'package:unlimit_list/widgets/app.dart';


Future<void> runUnlimitListApp() async {
    await initialize(isolateInit);
    runApp(
        MultiIsolateBlocProvider(
            providers: [
                IsolateBlocProvider<HeadIndexStateBloc, HeadIndexState>(),
                IsolateBlocProvider<StackBloc, StackState>(),
                IsolateBlocProvider<ListPersonBloc, ListState>(),
            ],
            child: App(),
        ),
    );
}