package BigIP::iControl::LocalLB::ObjectStatus;

use strict;
use warnings;

use overload ( '""' => \&stringify );

use BigIP::iControl::LocalLB::AvailabilityStatus;
use BigIP::iControl::LocalLB::EnabledStatus;

sub new {
	my( $class, $state ) = @_;
	#use Data::Dumper; print Dumper( $state );

	$state
	and exists $state->{ availability_status}
	and exists $state->{ enabled_status	}
	and exists $state->{ status_description	}
	or do { warn 'Mandatory value required for constructor'; return undef };

	my $self = bless {}, $class;
	#$self->{availability_status}	= $state->{ availability_status };
	$self->{availability_status}	= BigIP::iControl::LocalLB::AvailabilityStatus->new( $state->{ availability_status } );
	$self->{enabled_status}		= BigIP::iControl::LocalLB::EnabledStatus->new( $state->{ enabled_status } );
	$self->{status_description}	= $state->{ status_description 	};
	return $self
}

sub availability_status	{ return $_[0]->{availability_status} 	}

sub enabled_status	{ return $_[0]->{enabled_status} 	}

sub status_description 	{ return "$_[0]->{ state }" 	}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::ObjectStatus - Utility class for representing object statuses.

=head1 DESCRIPTION

This module implements a utility class providing object status state representation.

=head1 METHODS

=head3 availability_status

Returns an L<BigIP::iControl::LocalLB::AvailabilityStatus> representing the availability
status of the specified object

=head3 enabled_status

Returns the enabled state of the virtual server as a integer value where:

	STATE_ENABLED  => 1
	STATE_DISABLED => 0

Note that this class also implements an overloaded stringification method that returns
the same output as the I<state()> method.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-Common-EnabledState>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::Common::EnabledState


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-Common-EnabledState>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-Common-EnabledState>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-Common-EnabledState>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-Common-EnabledState/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
