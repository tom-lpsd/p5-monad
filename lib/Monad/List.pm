package Monad::List;
use Moose;

extends qw(autobox);

with 'Monad::Role::Monad';

sub import {
    my $class = shift;
    $class->SUPER::import(ARRAY => __PACKAGE__);
}

sub bind {
    my ($xs, $code) = @_;
    [map { @{$code->($_)} } @$xs];
}

sub inject {
    shift;
    [@_];
}

=head1 NAME

Monad::List - List Monad

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Monad::List;

=head1 METHODS

=over

=item B<bind>

=item B<inject>

=back

=head1 AUTHOR

Tom Tsuruhara, C<< <tom.lpsd at gmail.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tom Tsuruhara, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
