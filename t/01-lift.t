use strict;
use warnings;
use Test::More 'no_plan';

use Monad;
use Monad::List;
use Monad::Maybe;

sub add10 { $_[0] + 10 }

my $a = Just(10);
my $b = liftM(\&add10)->($a);

is(fromJust($b), 20);

my $xs = [1..10];
my $ys = liftM(\&add10)->($xs);
is_deeply($ys, [map {$_+10} 1..10]);

