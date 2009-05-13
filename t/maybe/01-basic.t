use strict;
use warnings;
use Test::More tests => 3;

use Monad::Maybe;

my $a = Just(10);

is(fromJust($a), 10);

my $b = $a->bind(sub { $a->inject($_[0] + 20) });
is(fromJust($b), 30);

my $c = $a->bind(sub { Nothing() })->bind(sub { $a->inject($_[0] + 2) });

ok(isNothing($c));
