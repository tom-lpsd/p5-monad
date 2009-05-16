use strict;
use warnings;
use Test::More 'no_plan';

use Monad;
use Monad::IO;
use Monad::List;
use Monad::Maybe;

my $io = mapM { putStrLn(@_) } [1..10];
runIO($io);

my $maybe = mapM { Just($_[0]) } [1..10];
local $, = " ";
print @{fromJust($maybe)};
