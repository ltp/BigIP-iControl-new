package BigIP::iControl::Common::TimeStamp;

use strict;
use warnings;

use overload ('""' => \&_stringify );

our $VERSION = '0.01';
our @ATTR = qw(hour minute second month day year);

{
	no strict 'refs';

	foreach my $attr ( @ATTR ) {
		*{ __PACKAGE__ .'::'. $attr } = sub { return $_[0]->{$attr} }
	}
}

sub new {
	my ( $class, $timestamp ) = @_;
	my $self = bless {}, $class;
	map { $self->{ $_ } = $timestamp->{ $_ } } @ATTR;
	return $self
}

sub _stringify {
	return sprintf( "%02d:%02d:%02d %02d-%02d-%04d",
		$_[0]->hour,
		$_[0]->minute,
		$_[0]->second,
		$_[0]->day,
		$_[0]->month,
		$_[0]->year
	)
}

1;

__END__

=head1 NAME

BigIP::iControl::Common::TimeStamp - Utility class for timestamp representation.

=head1 DESCRIPTION

This module implements a utility class providing timestamp representation.

=head1 METHODS

=head3 second

Returns the second component of the timestamp.

=head3 minute

Returns the minute component of the timestamp.

=head3 hour

Returns the hour component of the timestamp.

=head3 day

Returns the day component of the timestamp.

=head3 month

Returns the month component of the timestamp.

=head3 year

Returns the year component of the timestamp.


Note that this class also implements an overloaded stringification method that returns the
timestamp in the format "HH:MM:SS DD-MM-YYYY".

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-Common-TimeStamp>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::Common::TimeStamp


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-Common-TimeStamp>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-Common-TimeStamp>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-Common-TimeStamp>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-Common-TimeStamp/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
