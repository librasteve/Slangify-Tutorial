use Slangify::Tutorial::Grammar;
use Slangify::Tutorial::Actions;

use LLM::Functions;

sub normalize-text(Str $text --> Str) {
    my &normalizer = llm-function(
        -> :$input {
            qq:to/PROMPT/.trim
            Convert this restaurant booking text into the DSL format shown in the example.

            Example input:  Dr. Jane Smith booked a table for 4 at 7:30pm tomorrow at Bistro Verde
            Example output: name "Dr. Jane Smith" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow

            Rules:
            - name: full name of the person making the booking, in double quotes (include title, first, middle, last name as given)
            - party: integer number of people
            - time: 24-hour HH:MM (e.g. 19:30 for 7:30pm, 07:30 for 7:30am)
            - restaurant: full restaurant name in double quotes
            - date: single word (today, tomorrow, weekday name, or ISO date)

            Respond with ONLY the DSL line, no explanation.

            Input: $input
            PROMPT
        },
        llm-evaluator => 'chatgpt'
    );
    ~normalizer(input => $text)
}

sub parse-booking(Str $text --> Str) is export {
    my $canonical = normalize-text($text);
    my $match = Slangify::Tutorial::Grammar.parse(
        $canonical,
        :actions(Slangify::Tutorial::Actions.new)
    );
    die "Could not parse normalized text: '$canonical'" unless $match;
    $match.made.raku
}


=begin pod

=head1 NAME

Slangify::Tutorial - Extract structured data from natural language restaurant booking text

=head1 SYNOPSIS

=begin code :lang<raku>

use Slangify::Tutorial;

say parse-booking("Jane booked a table for 4 at 7:30pm tomorrow at Bistro Verde");
# {
#   "name": "Jane",
#   "party": 4,
#   "time": "19:30",
#   "restaurant": "Bistro Verde",
#   "date": "tomorrow"
# }

=end code

=head1 DESCRIPTION

Uses C<LLM::Functions> to normalize free-form booking text to a canonical DSL,
then a Raku Grammar + Actions + Actionable pipeline to extract structured fields.

The canonical DSL form (parseable standalone in Grammar Editor / Slangify Playground):

  name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow

=head1 AUTHOR

librasteve <librasteve@furnival.net>

=head1 COPYRIGHT AND LICENSE

Copyright 2026 librasteve

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
