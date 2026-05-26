use Actionable;

class Booking does Actionable {
    has Str $.name;
    has Int $.party;
    has Str $.time;
    has Str $.restaurant;
    has Str $.date;

    method raku {
        self.action-to-json;
    }
}

class Slangify::Tutorial::Actions {
    method TOP($/) {
        make Booking.action($/)
    }
}
