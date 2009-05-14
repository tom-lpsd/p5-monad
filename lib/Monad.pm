package Monad;
use strict;
use warnings;
use base qw/Exporter/;
use Monad::List;

our @EXPORT = qw/liftM/;

sub liftM {
    my $code = shift;
    sub {
        my $m = shift;
        $m->bind(sub { $m->inject($code->(shift)) });
    };
}

=head1 NAME

Monad - Monad with Perl

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Monad;

=head1 FUNCTION

=over

=item B<liftM> liftM

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
