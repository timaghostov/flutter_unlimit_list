

import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:unlimit_list/model/event/event.dart';
import 'package:unlimit_list/model/event/show_person.dart';
import 'package:unlimit_list/model/state/stack_state.dart';


class StackBloc extends IsolateBloc<AppEvent, StackState> {

    StackBloc(): super( new StackState() );

    @override
    void onEventReceived(AppEvent event) {
        if ( event.etype == EventType.showPerson  ) {
            int index = ( event as ShowPerson ).index;
            state.show(index);
            emit( state );
        }
        if ( event.etype == EventType.hidePerson  ) {
            state.hide();
            emit( state );
        }
    }

}