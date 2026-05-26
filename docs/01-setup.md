[← Index](../index.md)

1. Install and Setup
====================

Prerequisites
-------------

  * Raku (2026.04 or later)

  * `zef` package manager

  * An OpenAI or Anthropic API key

Install the module
------------------

```shell
zef install Slangify::Tutorial
```

Or, to work from source:

```shell
git clone https://github.com/librasteve/Slangify-Tutorial
cd Slangify-Tutorial
zef install --/test .
```

Set your API key
----------------

`LLM::Functions` picks up your key from the environment:

```shell
export OPENAI_API_KEY=sk-...
```

Verify the install
------------------

```raku
use Slangify::Tutorial;

say parse-booking("Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde");
```

You should see a JSON string with `name`, `party`, `time`, `restaurant`, and `date` fields.

