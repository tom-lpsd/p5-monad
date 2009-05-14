use strict;
use warnings;
use Test::More 'no_plan';
use Monad::List;

my $xs = [1..10];

my $ys = $xs->bind(sub { [$_[0] + 1] });

is_deeply($ys, [2..11]);
