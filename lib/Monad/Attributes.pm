package Monad::Attributes;
use strict;
use warnings;
use Carp qw/croak/;
use Scalar::Util qw(refaddr);

our %monads;
our %types;

sub import {
    my $pkg = caller;
    return unless $pkg =~ /^Monad::(.*)$/;
    $monads{$1}++;
}

sub MODIFY_CODE_ATTRIBUTES {
    my ($pkg, $ref, @attrs) = @_;
    our (%monads, %types);
    my @monad = grep { exists $monads{$_} } @attrs;
    croak "invalid monad attributes (it's not just one.)"
        unless @monad == 1;
    $types{refaddr($ref)} = $monad[0];
    return;
}

sub FETCH_CODE_ATTRIBUTES {
    my ($pkg, $ref) = @_;
    $types{refaddr($ref)};
}

1;

