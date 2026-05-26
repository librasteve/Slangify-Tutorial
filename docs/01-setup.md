[← Index](../index.md)

# 01. Install and Setup

## Prerequisites

  * Raku

  * An AI key (such as OpenAI)

## Install raku

Simply use rakubrew...

...for macOS...

```shell
curl https://rakubrew.org/install-on-macos.sh | sh
```

...or linux...

```shell
curl https://rakubrew.org/install-on-perl.sh | sh
```

Or, see [https://raku.org/install](https://raku.org/install) for more options.

Raku comes with the `zef` package manager.

## Clone the module

```shell
git clone https://github.com/librasteve/Slangify-Tutorial
cd Slangify-Tutorial
zef install --/test .
```

This will bring in all the dependencies - such as the `LLM::Functions` module.

## Set your API key

`LLM::Functions` picks up your key from the environment:

```shell
export OPENAI_API_KEY=sk-...
```

Or, see [https://raku.land/zef:antononcube/LLM::Functions](https://raku.land/zef:antononcube/LLM::Functions) for other LLM services.

## Verify the install

```raku
extract-booking "Jane Murphy booked a table for 4 at 7:30pm tomorrow at Bistro Verde"
```

You should see a JSON string with `name`, `party`, `time`, `restaurant`, and `date` fields.

