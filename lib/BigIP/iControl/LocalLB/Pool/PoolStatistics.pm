package BigIP::iControl::LocalLB::Pool::PoolStatistics;

use strict;
use warnings;

use BigIP::iControl::LocalLB::Pool::PoolStatisticEntry;
use BigIP::iControl::Common::TimeStamp;

sub new {
	my ( $class, $data ) = @_;
	my $self = bless {}, $class;
	$self->{ time_stamp } = BigIP::iControl::Common::TimeStamp->new( $data->{ time_stamp } );
	$self->{ statistics } = [ map { BigIP::iControl::LocalLB::Pool::PoolStatisticEntry->new( $_ ) }
		  @{ $data->{statistics} } ];

	return $self
}

sub time_stamp	{ return $_[0]->{ time_stamp }	}

sub statistics	{ return @{ $_[0]->{ statistics } } }

sub pools { 
	my @res = map { $_->pool_name } @{ $_[0]->{statistics} }; 
	return @res 
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::Pool::PoolStatistics - Class for operations with LocalLB Pool statistics.

=head1 DESCRIPTION

This module provides an interface to LocalLB pool statistics.

=head1 METHODS

=head3 time_stamp( \@pools, \@members )

Adds members to the specified pools.

=head3 get_member( \@pools )

Returns a list of lists of pool members as L<BigIP::iControl::Common::IPPortDefinition>
objects for the specified pools.

=head3 get_object_status( \@pools )

Gets the statuses of the specified pools - returns a list of L<BigIP::iControl::LocalLB::ObjectStatus>
objects representing the statuses of the requested pools.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-Pool>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::Pool


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-Pool>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-Pool>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-Pool>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-Pool/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
