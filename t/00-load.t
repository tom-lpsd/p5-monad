#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Monad' );
}

diag( "Testing Monad $Monad::VERSION, Perl $], $^X" );
