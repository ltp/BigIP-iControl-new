package BigIP::iControl::LocalLB::EnabledStatus;

use strict;
use warnings;

use overload ( '""' => \&_stringify );

our $map = {
	ENABLED_STATUS_NONE => {
		value	=> 0,
		desc	=> 'Error scenario.' 
	},
	ENABLED_STATUS_ENABLED => {
		value	=> 1,
		desc	=> 'The object is active when in Green availability status. '
			.  'It may or may not be active when in Blue availability status. ' 
	},
	ENABLED_STATUS_DISABLED	=> {  	
		value	=> 2,
		desc	=> 'The object is inactive regardless of availability status.' 
	},
	ENABLED_STATUS_DISABLED_BY_PARENT => {
		value	=> 3,
		desc	=> 'The object is inactive regardless of availability status because its '
			.  'parent has been disabled, but the object itself is still enabled.'
	},
};

sub new {
	my( $class, $status ) = @_;

	$status	or do { warn 'Mandatory value required for constructor'; return undef };

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

BigIP::iControl::LocalLB::ObjectStatus - Utility class for representing enabled status.

=head1 DESCRIPTION

This module implements a utility class providing enabled status representation.

=head1 METHODS

=head3 status

Returns the enabled status.

=head3 value

Returns the numeric value corresponding to the enabled status - see
L<https://devcentral.f5.com/wiki/iControl.LocalLB__EnabledStatus.ashx> for complete
details of values.

=head3 desc

Returns a short textual description of the availability status.


Note that this class also implements an overloaded stringification method that returns
the same output as the I<status()> method.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-EnabledStatus>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::EnabledStatus


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-EnabledStatus>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-EnabledStatus>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-EnabledStatus>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-EnabledStatus/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
