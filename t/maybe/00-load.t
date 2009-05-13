#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Monad::Maybe' );
}

diag( "Testing Monad $Monad::Maybe::VERSION, Perl $], $^X" );
