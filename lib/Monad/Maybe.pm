package Monad::Maybe;
use Moose;
use Exporter qw(import);

our @EXPORT = qw/Just Nothing isNothing fromJust/;

with 'Monad::Role::Monad';

has _val     => (is => 'rw', default => undef);
has _nothing => (is => 'rw', default => 0);

__PACKAGE__->meta->make_immutable;

use Monad::Attributes;

sub bind {
    my ($maybe, $code) = @_;
    if (isNothing($maybe)) {
        return $maybe;
    }
    $code->(fromJust($maybe));
}

sub inject {
    shift;
    Just(@_);
}

sub Just ($) {
    __PACKAGE__->new(_val => $_[0]);
}

sub Nothing () {
    __PACKAGE__->new(_nothing => 1);
}

sub isNothing {
    $_[0]->_nothing == 1;
}

sub fromJust {
    if (isNothing($_[0])) {
        confess 'Nothing';
    }
    $_[0]->_val;
}

=head1 NAME

Monad::Maybe - Maybe Monad

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Monad::Maybe;

=head1 METHODS

=over

=item B<bind>

=item B<inject>

=item B<Just>

=item B<Nothing>

=item B<isNothing>

=item B<fromJust>

=back

=head1 AUTHOR

Tom Tsuruhara, C<< <tom.lpsd at gmail.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tom Tsuruhara, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
