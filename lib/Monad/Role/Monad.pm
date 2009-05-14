package Monad::Role::Monad;
use Mouse::Role;

requires qw/bind inject/;

sub fail {
    confess @_;
}

=head1 NAME

Monad::Role::Monad - Monad interface

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Mouse;

    with 'Monad::Role::Monad';

=head1 FUNCTION

=over

=item B<fail> fail

=back

=head1 AUTHOR

Tom Tsuruhara, C<< <tom.lpsd at gmail.com> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Monad::Role::Monad

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tom Tsuruhara, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
