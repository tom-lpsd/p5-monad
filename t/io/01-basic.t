use strict;
use warnings;
use Test::More 'no_plan';
use Monad::IO;

my $io = Monad::IO->inject(10);

my $io2 = $io->bind(sub { $io->inject($_[0] + 10) });

is(runIO($io), 10);
is(runIO($io2), 20);
