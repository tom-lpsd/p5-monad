package Monad::IO;
use Moose;
use Monad::Attributes;
use Exporter qw(import);

our @EXPORT = qw/runIO
                 getLine
                 getContents
                 putChar
                 putStr
                 putStrLn/;

with 'Monad::Role::Monad';

has _action => (is => 'rw', isa => 'CodeRef');

__PACKAGE__->meta->make_immutable;

sub Action (&) {
    __PACKAGE__->new(_action => $_[0]);
}

sub runIO {
    shift->_action->();
}

sub bind {
    my ($io, $code) = @_;
    Action { runIO($code->(runIO($io))) };
}

sub inject {
    shift; my @args = @_;
    Action { wantarray ? @args : $args[0] };
}

sub getLine () {
    Action { $_ = <STDIN>; chomp; $_ };
}

sub getContents () {
    Action { local $/; <STDIN> };
}

*putChar = \&putStr;

my $unit = '()';

sub putStr {
    my $str = shift;
    Action { print $str; $unit };
}

sub putStrLn {
    my $str = shift;
    Action { print "$str\n"; $unit };
}

=head1 NAME

Monad::IO - IO Monad

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Monad::IO;

=head1 METHODS

=over

=item B<bind>

=item B<inject>

=item B<runIO>

=item B<Action>

make IO from codeRef.

=item B<getLine>

=item B<getContents>

=item B<putChar>

=item B<putStr>

=item B<putStrLn>

=back

=head1 AUTHOR

Tom Tsuruhara, C<< <tom.lpsd at gmail.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Tom Tsuruhara, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
