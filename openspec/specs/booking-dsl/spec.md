## Purpose

Define the extraction of structured booking data from free-form natural language
restaurant booking text, using a Raku Grammar + Actions DSL with LLM pre-normalization.

## Requirements

### Requirement: LLM normalization

The system SHALL use `LLM::Functions` to normalize free-form booking text into a
canonical DSL line of the form:
`name <Name> party <N> time <HH:MM-24h> restaurant "<Restaurant>" date <date-token>`

#### Scenario: Normalize canonical example

- **WHEN** the input is `Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde`
- **THEN** the LLM SHALL produce a line matching the canonical DSL format

### Requirement: Grammar parsing

`Party::Tute::Grammar` SHALL parse a canonical DSL line and produce a structured
match with named captures for name, party, time, restaurant, and date.

#### Scenario: Parse full canonical DSL line

- **WHEN** the grammar parses `name Jane party 4 time 19:30 restaurant "Bistro Verde" date tomorrow`
- **THEN** the match SHALL succeed
- **AND** `$/<name>` SHALL equal `Jane`
- **AND** `$/<party>` SHALL equal `4`
- **AND** `$/<time>` SHALL equal `19:30`
- **AND** `$/<restaurant>` SHALL equal `Bistro Verde` (quotes stripped)
- **AND** `$/<date>` SHALL equal `tomorrow`

#### Scenario: Grammar rejects freeform input

- **WHEN** the grammar parses raw free-form English text
- **THEN** the parse SHALL return a falsy match object

### Requirement: Booking object population

`Party::Tute::Actions` SHALL use the Actionable role to populate a `Booking`
object from the grammar match.

#### Scenario: Booking object attributes

- **WHEN** Actions processes a successful grammar match
- **THEN** `$booking.name` SHALL equal `Jane`
- **AND** `$booking.party-size` SHALL equal `4` as an `Int`
- **AND** `$booking.time` SHALL equal `7:30 PM`
- **AND** `$booking.restaurant` SHALL equal `Bistro Verde`
- **AND** `$booking.date` SHALL equal `tomorrow`

#### Scenario: Time transform boundaries

- **WHEN** the time capture is `12:00`
- **THEN** `$booking.time` SHALL equal `12:00 PM`
- **WHEN** the time capture is `00:00`
- **THEN** `$booking.time` SHALL equal `12:00 AM`

### Requirement: JSON output

`extract-booking` (exported from `Party::Tute`) SHALL return a pretty-printed JSON
string with snake_case keys.

#### Scenario: JSON output shape

- **WHEN** `extract-booking("Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde")` is called
- **THEN** the result SHALL be valid JSON
- **AND** SHALL contain keys: `name`, `party_size`, `time`, `restaurant`, `date`
- **AND** `party_size` SHALL be the integer `4`

### Requirement: CLI command

The `bin/party-tute` script SHALL accept a positional `$text` argument and an
optional `:$output` file path.

#### Scenario: CLI prints JSON to stdout

- **WHEN** run as `party-tute "Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde"`
- **THEN** valid JSON SHALL be printed to stdout

#### Scenario: CLI writes JSON to file

- **WHEN** run with `--output=booking.json`
- **THEN** the JSON SHALL be written to that file
- **AND** nothing SHALL be printed to stdout
