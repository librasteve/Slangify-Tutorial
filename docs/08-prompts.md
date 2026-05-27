[← Index](../index.md)

# 08. The LLM Prompts Used

This chapter walks through the design process behind this tutorial — from a first experiment that **didn't** need a DSL, through consulting an LLM for guidance, to the project spec that produced `Slangify::Tutorial`.

## First experiment: bill extraction

Starting point: a folder of utility bills.

    Ask Claude: "extract the data from these bills"
    Result: bills.csv  ✓

It worked — but there was no need for a DSL. A plain LLM prompt handled the extraction cleanly. The lesson: **reach for a DSL only when structure and validation matter downstream**.

This used approx. 10 bills, from the same utility provider. Possibly, the quality of data extraction would reduce with a more mixed bag of source material, more items or variations in LLM interpretation (eg different LLM models) which would suggest a return to the DSL strategy.

## Consulting an LLM: where does DSL + LLM shine?

A conversation with ChatGPT surfaced the right use case:

I want an LLM to extract structured information from messy text — but without hand-writing JSON schemas or fragile parsing logic.

Example input:

    Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde

Desired output:

```json
{
  "name": "Jane",
  "party_size": 4,
  "time": "7:30 PM",
  "restaurant": "Bistro Verde",
  "date": "tomorrow"
}
```

The DSL approach wins here because the output must be *typed* and *validated* — not just text.

## Project spec

Use `mi6` to scaffold a new Raku project `Slangify::Tutorial` in directory `Slangify-Tutorial`.

Set out the specification via `openspec`.

Make a DSL for this purpose using Raku Grammar and Actions (see examples at [https://slangify.org](https://slangify.org)). Declare any needed classes in the Actions file.

Make sure Grammar and Actions do the whole job so they can be used in the [Grammar Editor / Slangify Playground](https://play.slangify.org).

Use `JSON::Fast`, `Actionable`, and `LLM::Functions`. Prompt for other Raku modules if needed.

Make a command `Slangify-Tutorial` that takes the text as an argument and optionally a filename for the JSON output.

## Spec tweaks

  * Add docs and tests.

  * Use the standard Raku / IntelliJ `.gitignore`.

  * Any class instantiated inside an Actions method (e.g. via `.action($/)`) SHALL be declared with a simple unqualified name (e.g. `class Booking`) rather than a fully-qualified namespace name (e.g. `class Slangify::Tutorial::Booking`).

  * Make `name` cover names with titles, first name, middle name, last name, and so on.

## Result

[View in Slangify Playground](https://play.slangify.org/3b7e2bb192a398406574c72684d2b81a199d307a)

