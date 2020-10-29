





import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/bloc/data_list_bloc.dart';
import 'package:unlimit_list/model/event/load_new_person.dart';
import 'package:unlimit_list/model/state/list_state.dart';

class ErrorItem extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Center(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        SizedBox(height: 10),
                        Text(
                            'Произошла ошибка',
                            style: TextStyle(
                                fontSize: 18
                            ),
                        ),
                        Flexible(
                            child: Container(
                                child: FlatButton(
                                    child: Text(
                                        'Повторить',
                                        style: TextStyle(
                                            color: Theme.of(context).accentColor,
                                            fontSize: 18
                                        ),
                                    ),
                                    onPressed: () {
                                        IsolateBlocProvider.of<ListPersonBloc, ListState>(context)
                                            .add(LoadNewPerson());
                                    },
                                ),
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}