

import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/data_list_bloc.dart';
import 'package:unlimit_list/bloc/head_index_bloc.dart';
import 'package:unlimit_list/bloc/stack_bloc.dart';


void isolateInit() {
    register(create: () => HeadIndexStateBloc());
    register(create: () => StackBloc());
    register(create: () => ListPersonBloc());
}