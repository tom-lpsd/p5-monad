package Monad;
use strict;
use warnings;
use Exporter qw(import);
use Monad::List;

our @EXPORT = qw/mapM liftM/, map { "liftM$_" } (2..5);

sub _mk_lift {
    my $n = shift;
    sub {
        my $code = shift;
        sub {
            my $m = shift;
            $m->bind(sub { $m->inject($code->(@_[0..($n-1)])) });
        };
    };
}

*liftM = _mk_lift(1);

for (2..5) {
    no strict 'refs';
    *{"liftM$_"} = _mk_lift($_);
}

sub mapM (&$);

sub mapM (&$) {
    my ($code, $xs) = @_;
    return $code->()->inject([]) if @$xs == 0;
    my $x = shift @$xs;
    my $m = $code->($x);
    $m->bind(
        sub {
            my $y = shift;
            (mapM { $code->(@_) } $xs)->bind(sub { $m->inject([$y, @{+shift}]) });
        }
    );
}

=head1 NAME

Monad - Monad in Perl

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use Monad;

=head1 FUNCTION

=over

=item B<liftM> liftM

=item B<liftM2> liftM2

=item B<liftM3> liftM3

=item B<liftM4> liftM4

=item B<liftM5> liftM5

=back

=head1 AUTHOR

Tom Tsuruhara, C<< <tom.lpsd at gmail.com> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Monad

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tom Tsuruhara, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
