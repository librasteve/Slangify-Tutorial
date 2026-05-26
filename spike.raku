use Slangify::Tutorial::Grammar;
use Slangify::Tutorial::Actions;

my $canonical = 'name "Jane" party 4 time 19:30 restaurant "Bistro Verde" date tomorrow';

my $m = Grammar.parse($canonical,
            :actions(Actions.new));
my $b = $m.made;
say $b.WHAT;        # (Booking)
say $b.name;        # Sam
say $b.party;       # 4  (Int, not Str)
say $b.restaurant;  # Pizza East
