use strict;
use warnings;
use Test::More 'no_plan';

use Monad::Util;
use Monad::Maybe;

sub add10 { $_[0] + 10 }

my $a = Just(10);
my $b = liftM(\&add10)->($a);

is(fromJust($b), 20);
