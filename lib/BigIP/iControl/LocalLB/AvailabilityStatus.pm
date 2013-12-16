package BigIP::iControl::LocalLB::AvailabilityStatus;

use strict;
use warnings;

use overload ( '""' => \&_stringify );

our $map = {
	AVAILABILITY_STATUS_NONE => {
		value	=> 0,
		desc	=> 'Error scenario.' 
	},
	AVAILABILITY_STATUS_GREEN => {
		value	=> 1,
		desc	=> 'The object is available in some capacity.' 
	},
	AVAILABILITY_STATUS_YELLOW => {
		value	=> 2,
		desc	=> 'The object is not available at the current moment, but may '
			 . 'become available again even without user intervention.' 
	},
	AVAILABILITY_STATUS_RED	=> {
		value	=> 3,
		desc	=> 'The object is not available, and will require user '
			 . 'intervention to make this object available again.' 
	},
	AVAILABILITY_STATUS_BLUE => {
		value	=> 4,
		desc	=> 'The object\'s availability status is unknown.' 
	},
	AVAILABILITY_STATUS_GRAY => {
		value	=> 5,
		desc	=> 'The object\'s is unlicensed.' 
	},
};

sub new {
	my( $class, $status ) = @_;

	$status	or do { warn 'Mandatory value required for constructor'; return undef };
	exists $map->{ $status } or do { warn 'Invalid status value'; return undef };

	my $self = bless {}, $class;
	$self->{status}	= $status;
	return $self
}

sub status	{ return $_[0]->{status} 			}

sub value	{ return $map->{ $_[0]->{status} }->{ value } 	}

sub desc	{ return $map->{ $_[0]->{status} }->{ desc } 	}

sub _stringify 	{ return "$_[0]->{ status }" 			}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::AvailabilityStatus - Utility class for representing availability statuses.

=head1 DESCRIPTION

This module implements a utility class providing object status state representation.

=head1 METHODS

=head3 status

Returns the availability status.

=head3 value

Returns the numeric value corresponding to the availability status - see 
L<https://devcentral.f5.com/wiki/iControl.LocalLB__AvailabilityStatus.ashx> for complete
detail of values.

=head3 desc

Returns a short textual description of the availability status.


Note that this class also implements an overloaded stringification method that returns
the same output as the I<status()> method.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-AvailabilityStatus>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::AvailabilityStatus


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-AvailabilityStatus>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-AvailabilityStatus>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-AvailabilityStatus>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-AvailabilityStatus/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
