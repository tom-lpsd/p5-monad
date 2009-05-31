package Monad;
use strict;
use warnings;
use Exporter qw/import/;
use attributes qw/get/;
use Monad::List;
use Monad::Attributes;

our @EXPORT = qw/MODIFY_CODE_ATTRIBUTES
                 FETCH_CODE_ATTRIBUTES
                 mapM liftM /, map { "liftM$_" } (2..5);

*FETCH_CODE_ATTRIBUTES  = \&Monad::Attributes::FETCH_CODE_ATTRIBUTES;
*MODIFY_CODE_ATTRIBUTES = \&Monad::Attributes::MODIFY_CODE_ATTRIBUTES;

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

sub __mapM (&$$);

sub __mapM (&$$) {
    my ($code, $list, $class) = @_;
    return $class->inject([]) if @$list == 0;
    my ($x, @xs) = @{$list};
    my $m = $code->($x);
    $m->bind(
        sub {
            my $y = shift;
            (__mapM \&$code, \@xs, $class)->bind(
                sub { $class->inject([$y, @{+shift}]) }
            );
        }
    );
}

sub mapM (&$) {
    my ($code, $xs) = @_;
    __mapM \&$code, $xs, "Monad::@{[get($code)]}";
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

=item B<mapM> mapM

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
