

enum EventType {
    loadNew,
    verticalItemBuild,
    horizontalItemBuild,
    showPerson,
    hidePerson,
    updateCurrentIndex
}

abstract class AppEvent {
    EventType etype;

    AppEvent(this.etype);
}