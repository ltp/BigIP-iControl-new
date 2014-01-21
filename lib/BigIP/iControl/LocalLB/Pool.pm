package BigIP::iControl::LocalLB::Pool;

use strict;
use warnings;

use BigIP::iControl::LocalLB::ObjectStatus;
use BigIP::iControl::LocalLB::Pool::PoolStatistics;
use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, $name, %args ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub get_member {
	my ( $self, $pools ) = @_;
	my @res;
	
	foreach my $arr (@{ $self->{_icontrol}->_request(module	=> 'LocalLB',
						interface	=> 'Pool',
						method		=> 'get_member',
						data		=> { pool_names => $pools }
	) }) {
		push @res, [ map { BigIP::iControl::Common::IPPortDefinition->new( $self->{_icontrol}, $_ ) } @{ $arr } ]
	}

	return @res
}

sub get_active_member_count {
	my( $self, $pool_names ) = @_;
	return $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'Pool',
						method		=> 'get_active_member_count',
						data		=> { pool_names => $pool_names } )
}

sub get_object_status {
	my ( $self, $pools ) = @_;
	#foreach my $arr (@{ $self->{_icontrol}->_request(module	=> 'LocalLB',
	return map { BigIP::iControl::LocalLB::ObjectStatus->new( $_ ) } 
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'Pool',
						method		=> 'get_object_status',
						data		=> { pool_names => $pools } ) }
	#) }) {
	#	push @res, [ map { BigIP::iControl::Common::IPPortDefinition->new( $self->{_icontrol}, $_ ) } @{ $arr } ]
	#}

	#return @res
}

sub add_member {
	my ( $self, $pool_names, $members ) = @_;

	my $res = $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'Pool',
						method		=> 'add_member',
						data		=> { pool_names => $pool_names, members => $members } );

	return ( (ref $res) eq 'HASH' and defined $res->{_has_fault} )
		? do { warn $res->{faultstring}; undef }
		: 1 ;
}

sub get_statistics {
	my ( $self, $pool_names, $members ) = @_;

	my $res = $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'Pool',
						method		=> 'get_statistics',
						data		=> { pool_names => $pool_names } );
	
	my $stat = BigIP::iControl::LocalLB::Pool::PoolStatistics->new( $res );
	
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::Pool - Class for operations with LocalLB Pool interface.

=head1 DESCRIPTION

This module provides an interface to LocalLB pool management capabilities.

=head1 METHODS

=head3 add_member( \@pools, \@members )

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
