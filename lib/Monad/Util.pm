package Monad::Util;
use strict;
use warnings;
use base qw/Exporter/;

our @EXPORT = qw/liftM/;

sub liftM {
    my $code = shift;
    sub {
        my $m = shift;
        $m->bind(sub { $m->inject($code->(shift)) });
    };
}

=head1

=over

=item B<liftM>

=back

=cut

1;
