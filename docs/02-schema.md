[← Index](../index.md)

# 02. Your First Schema

In Slangify, the schema is a Raku Grammar. Each named token is a field; the `TOP` rule defines the canonical DSL line the LLM must produce.

## The booking grammar

```raku
grammar Slangify::Tutorial::Grammar {
    token TOP {
        <.ws>
        name        <.ws> <name>       <.ws>
        party       <.ws> <party>      <.ws>
        time        <.ws> <time>       <.ws>
        restaurant  <.ws> <restaurant> <.ws>
        date        <.ws> <date>       <.ws>?
        $
    }

    token name       { '"' <( <-["]>+ )> '"' }
    token party      { \d+                   }
    token time       { \d+ ':' \d\d          }
    token restaurant { '"' <( <-["]>+ )> '"' }
    token date       { \S+                   }
    token ws         { \h*                   }
}
```

## Field types

**name / restaurant**

Quoted string — any characters except C<">. The C<< <( )> >> markers strip the surrounding quotes from the capture.

**party**

One or more digits — coerced to C<Int> by the C<Booking> class.

**time**

24-hour C<HH:MM> — e.g. C<19:30> for 7:30 pm.

**date**

Any non-whitespace token: C<today>, C<tomorrow>, a weekday, or C<2026-06-01>.

## Required vs optional

Every field in `TOP` is required by default. To make a field optional, add `**{0..1}` or `?` after its subrule call, and handle the missing case in `Booking`.

## Testing the grammar standalone

The grammar parses the canonical DSL line without any LLM, keeping the schema that defines your DSL distinct and concrete to maximize clarity, effectiveness and ease of test:

```raku
my $m = Slangify::Tutorial::Grammar.parse(
    'name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow'
);
say $m<name>;        # Jane
say $m<party>;       # 4
say $m<restaurant>;  # Bistro Verde
```

