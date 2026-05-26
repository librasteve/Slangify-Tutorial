[← Index](../index.md)

# 01. Install and Setup

## Prerequisites

  * An AI key (such as OpenAI)

## Install Raku

The Slangify focus is writing DSLs in Raku. [Raku](https://raku.org) is an open source programming language with built-in Grammar capability. [Why Raku?](https://slangify.org/why).

Use rakubrew to install a Raku compiler...

...for macOS:

```shell
curl https://rakubrew.org/install-on-macos.sh | sh
```

...for linux:

```shell
curl https://rakubrew.org/install-on-perl.sh | sh
```

See [https://raku.org/install](https://raku.org/install) for more options.

Raku comes complete with the `zef` package manager.

## Clone the Module

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

See [https://raku.land/zef:antononcube/LLM::Functions](https://raku.land/zef:antononcube/LLM::Functions) for other supported LLMs.

You can append the `export` cmd to your `~/.zshrc` or `~/.bashrc`.

## Verify the install

```raku
extract-booking "Jane Murphy booked a table for 4 at 7:30pm tomorrow at Bistro Verde"
```

You should see a JSON string with `name`, `party`, `time`, `restaurant`, and `date` fields.

