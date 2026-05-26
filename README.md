[![Actions Status](https://github.com/librasteve/Party-Tute/actions/workflows/test.yml/badge.svg)](https://github.com/librasteve/Party-Tute/actions)

NAME
====

Party::Tute - Extract structured data from natural language restaurant booking text

SYNOPSIS
========

```raku
use Party::Tute;

say extract-booking("Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde");
```

Output:

```json
{
  "name": "Jane",
  "party_size": 4,
  "time": "7:30 PM",
  "restaurant": "Bistro Verde",
  "date": "tomorrow"
}
```

DESCRIPTION
===========

Party::Tute demonstrates how to combine a Raku Grammar + Actions DSL with an
LLM pre-normalization step to extract structured data from free-form natural
language text.

The pipeline has two layers:

**DSL layer** — `Party::Tute::Grammar` parses a canonical mini-language directly.
This pair works standalone in the [Grammar Editor](https://play.slangify.org) /
[Slangify Playground](https://slangify.org):

```
name Jane party 4 time 19:30 restaurant "Bistro Verde" date tomorrow
```

**CLI layer** — `bin/party-tute` accepts free-form English, uses `LLM::Functions`
to normalize it to the canonical DSL form, then feeds it through the Grammar +
Actions pipeline.

### Grammar

```raku
grammar Party::Tute::Grammar {
    token TOP {
        <.ws>
        name        <.ws> <name>       <.ws>
        party       <.ws> <party>      <.ws>
        time        <.ws> <time>       <.ws>
        restaurant  <.ws> <restaurant> <.ws>
        date        <.ws> <date>       <.ws>?
        $
    }

    token name       { <[A..Za..z]> \w*      }
    token party      { \d+                   }
    token time       { \d+ ':' \d\d          }
    token restaurant { '"' <( <-["]>+ )> '"' }
    token date       { \S+                   }
    token ws         { \h*                   }
}
```

### Booking class

```raku
use Actionable;

class Party::Tute::Booking does Actionable {
    has Str $.name;
    has Int $.party-size;
    has Str $.time;
    has Str $.restaurant;
    has Str $.date;

    method capture-map { { 'party-size' => 'party' } }

    method transform(Str $attr, $raw) {
        if $attr eq 'time' {
            my ($h, $m) = $raw.split(':')».Int;
            my $suffix = $h >= 12 ?? 'PM' !! 'AM';
            my $h12    = $h > 12 ?? $h - 12 !! ($h == 0 ?? 12 !! $h);
            sprintf('%d:%02d %s', $h12, $m, $suffix)
        } else { $raw }
    }
}
```

The `Actionable` role auto-populates all attributes from named grammar captures.
`capture-map` maps the `party-size` attribute to the `party` grammar token.
`transform` converts 24-hour `HH:MM` to `"H:MM AM/PM"` display format.

### Actions

```raku
class Party::Tute::Actions {
    method TOP($/) {
        make Party::Tute::Booking.action($/)
    }
}
```

### Using in the Slangify Playground

Paste `Party::Tute::Grammar` and `Party::Tute::Actions` into the playground,
then use the canonical DSL as input:

```
name Jane party 4 time 19:30 restaurant "Bistro Verde" date tomorrow
```

### CLI usage

```
# Print JSON to stdout
raku -Ilib bin/party-tute "Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde"

# Write JSON to file
raku -Ilib bin/party-tute "Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde" --output=booking.json
```

Requires `OPENAI_API_KEY` to be set in the environment.

INSTALLATION
============

```
zef install Party::Tute
```

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2026 librasteve

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
