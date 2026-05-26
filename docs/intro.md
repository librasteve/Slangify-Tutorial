Slangify::Tutorial
==================

A tutorial demonstrating how to combine a Raku Grammar + Actions DSL with an LLM pre-normalization step to extract structured data from free-form natural language text.

Overview
--------

The pipeline has two layers:

  * **DSL layer** — `Slangify::Tutorial::Grammar` parses a canonical mini-language directly. This pair works standalone in the [Grammar Editor](https://play.slangify.org) / [Slangify Playground](https://slangify.org).

  * **LLM layer** — `bin/party-tute` accepts free-form English, uses `LLM::Functions` to normalize it to the canonical DSL form, then feeds it through the Grammar + Actions pipeline.

Quick Start
-----------

```raku
use Slangify::Tutorial;

say parse-booking("Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde");
```

Installation
------------

    zef install Slangify::Tutorial

