[← Index](../../index.md)

Actions & Booking Class
=======================

`Slangify::Tutorial::Actions` uses the `Actionable` role to auto-populate a `Booking` object from a successful grammar match.

The Booking Class
-----------------

```raku
use Actionable;

class Booking does Actionable {
    has Str $.name;
    has Int $.party;
    has Str $.time;
    has Str $.restaurant;
    has Str $.date;

    method raku { self.action-to-json }
}
```

The `Actionable` role wires named grammar captures to attributes automatically. `Int` attributes are coerced from the capture string via `+$raw`.

Actions Class
-------------

```raku
class Slangify::Tutorial::Actions {
    method TOP($/) {
        make Booking.action($/)
    }
}
```

`Booking.action($/)` is the `Actionable` entry point — it reads all named captures from `$/` and populates the matching attributes.

JSON Output
-----------

`$booking.raku` delegates to `action-to-json`, returning a JSON string with all public attributes.

