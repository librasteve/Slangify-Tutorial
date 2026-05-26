[![Actions Status](https://github.com/librasteve/Slangify-Tutorlal/actions/workflows/test.yml/badge.svg)](https://github.com/librasteve/Slangify-Tutorlal/actions)

NAME
====

Slangify::Tutorial - Extract structured data from natural language restaurant booking text

SYNOPSIS
========

```raku
use Slangify::Tutorial;

say extract-booking("Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde");
# {
#   "name": "Jane",
#   "party": 4,
#   "time": "19:30",
#   "restaurant": "Bistro Verde",
#   "date": "tomorrow"
# }
```

DESCRIPTION
===========

Uses `LLM::Functions` to normalize free-form booking text to a canonical DSL, then a Raku Grammar + Actions + Actionable pipeline to extract structured fields.

The canonical DSL form (parseable standalone in Grammar Editor / Slangify Playground):

    name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow

[Playground Link](https://play.slangify.org/91912aa811d5a940bdcb161d131a4c1004f4d053)

[Slangify Tutorial](https://librasteve.github.io/Slangify-Tutorial/)

AUTHOR
======

Stephen Roe <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2026 Stephen Roe

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

