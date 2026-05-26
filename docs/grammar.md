[← Index](../index.md)

# Grammar DSL

`Slangify::Tutorial::Grammar` parses a canonical booking DSL line of the form:

    name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow

## Token Reference

#### name

Full name of the person, in double quotes. Accepts any characters except `"`. Example: `name "Dr. Jane Smith"`

#### party

Integer number of people. Example: `party 4`

#### time

24-hour time as `HH:MM`. Example: `time 19:30`

#### restaurant

Restaurant name in double quotes. Example: `restaurant "Bistro Verde"`

#### date

Single word: `today`, `tomorrow`, a weekday name, or an ISO date (`2026-06-01`). Example: `date tomorrow`

## Using in the Slangify Playground

Paste the grammar into [https://slangify.org](https://slangify.org) and use the canonical DSL as input. The grammar parses standalone — no LLM step required.

