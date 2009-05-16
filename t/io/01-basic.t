use strict;
use warnings;
use Test::More 'no_plan';
use Test::Output;
use Monad::IO;

my $io = Monad::IO->inject(10);

my $io2 = $io->bind(sub { $io->inject($_[0] + 10) });

is(runIO($io),  10, 'as is');
is(runIO($io2), 20, 'add 10');

my $input = 'o' x 100 . "\n";

sub interact_is {
    my ($io, $input, $expected, $msg) = @_;
    local *STDIN;
    open STDIN, '<', \$input;
    stdout_is { runIO($io) } $expected, $msg;
}

interact_is(getLine->bind(sub { putStrLn($_[0]) }),
            $input, $input, 'pass through');
