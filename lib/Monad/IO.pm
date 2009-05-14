package Monad::IO;
use Moose;

extends 'Exporter';

our @EXPORT = qw/runIO
                 getLine
                 getContents
                 putChar
                 putStr
                 putStrLn/;

with 'Monad::Role::Monad';

has _action => (is => 'rw', isa => 'CodeRef');

__PACKAGE__->meta->make_immutable;

sub bind {
    my ($io, $code) = @_;
    my $next = sub {
        $code->($io->_action->())->_action->();
    };
    __PACKAGE__->new(_action => $next);
}

sub inject {
    shift; my @args = @_;
    __PACKAGE__->new(_action => sub { wantarray ? @args : $args[0] });
}

sub runIO {
    my $io = shift;
    $io->_action->();
}

sub getLine () {
    __PACKAGE__->new(_action => sub { $_ = <>; chomp; $_ });
}

sub getContents () {
    __PACKAGE__->new(_action => sub { join '', <> });
}

*putChar = \&putStr;

sub putStr {
    my $str = shift;
    __PACKAGE__->new(_action => sub { print $str });
}

sub putStrLn {
    my $str = shift;
    __PACKAGE__->new(_action => sub { print "$str\n" });
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
