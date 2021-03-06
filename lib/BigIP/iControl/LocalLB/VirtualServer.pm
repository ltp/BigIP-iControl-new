package BigIP::iControl::LocalLB::VirtualServer;

use strict;
use warnings;

use Scalar::Util qw(weaken);
use BigIP::iControl::Common::EnabledState;
use BigIP::iControl::Common::IPPortDefinition;
use BigIP::iControl::Common::ProtocolType;
use BigIP::iControl::Common::VLANFilterList;
use BigIP::iControl::Common::VirtualServerDefinition;
use BigIP::iControl::LocalLB::ObjectStatus;
use BigIP::iControl::LocalLB::PersistenceMode;
use BigIP::iControl::LocalLB::PersistenceRecord;
use BigIP::iControl::LocalLB::VirtualServerRule;
use BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence;
use BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatistics;
use BigIP::iControl::LocalLB::VirtualServer::VirtualServerProfileAttribute;
our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, $name, %args ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub get_enabled_state {
	my( $self, $virtual_servers ) = @_;

	my @states = map { BigIP::iControl::Common::EnabledState->new( $_ ) } 
		@{  $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method		=> 'get_enabled_state',
						data		=> { virtual_servers => $virtual_servers }
					) };


	return @states;
							
}

sub destination { 
	my $self = shift;
	$self->{name} or return;
	return BigIP::iControl::Common::IPPortDefinition->new(
		@{$self->{_icontrol}->_request(	module		=> 'LocalLB', 
						interface 	=> 'VirtualServer',
						method 		=> 'get_destination', 
						data 		=> { virtual_servers => [ $self->{name} ] }
					)
		}[0] )
}

sub rules { 
	my $self = shift;
	$self->{name} or return;
	return map { BigIP::iControl::LocalLB::VirtualServerRule->new( $self->{_icontrol}, $_ ) }
		@{ @{$self->{_icontrol}->_request(module		=> 'LocalLB', 
						interface 	=> 'VirtualServer',
						method 		=> 'get_rule',
						data 		=> { virtual_servers => [ $self->{name} ] }
					)
		}[0] };
}

sub state { 
	my $self = shift;
	$self->{name} or return;
	return @{$self->{_icontrol}->_request(	module		=> 'LocalLB', 
						interface 	=> 'VirtualServer',
						method 		=> 'get_enabled_state', 
						data 		=> { virtual_servers => [ $self->{name} ] }
					)
		}[0];
}

sub get_list {
	my( $self ) = shift;
	return @{ $self->{_icontrol}->_request(	module		=> 'LocalLB', 
						interface 	=> 'VirtualServer', 
						method 		=> 'get_list') 
		}
}

sub get_default_pool_name {
	my( $self, $virtual_servers ) = @_;

	my @states = 
		@{  $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method		=> 'get_default_pool_name',
						data		=> { virtual_servers => $virtual_servers }
					) };

	return @states
}

sub get_vlan {
	my( $self, $virtual_servers ) = @_;

	return map { BigIP::iControl::Common::VLANFilterList->new( $_ ) }
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_vlan',
						data		=> { virtual_servers => $virtual_servers }
					) };
}

sub get_translate_address_state {
	my( $self, $virtual_servers ) = @_;

	return map { BigIP::iControl::Common::EnabledState->new( $_ ) } 
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_translate_address_state',
						data		=> { virtual_servers => $virtual_servers }
					) };
}

sub get_translate_port_state {
	my( $self, $virtual_servers ) = @_;

	return map { BigIP::iControl::Common::EnabledState->new( $_ ) } 
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_translate_port_state',
						data		=> { virtual_servers => $virtual_servers }
					) };
}

sub get_snat_type {
	my( $self, $virtual_servers ) = @_;

	return @{ $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_snat_type',
						data		=> { virtual_servers => $virtual_servers }
					) };
}

sub get_snat_pool {
	my( $self, $virtual_servers ) = @_;

	return @{ $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_snat_pool',
						data		=> { virtual_servers => $virtual_servers }
					) };
}

sub get_destination {
	my( $self, $virtual_servers ) = @_;

	my @destinations = 
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_destination',
						data		=> { virtual_servers => $virtual_servers }
					) };
	@destinations = map { BigIP::iControl::Common::IPPortDefinition->new( undef, $_ ) } @destinations;

	return @destinations
}

sub get_profile {
	my( $self, $virtual_servers ) = @_;
	my @res;

	my @profiles = 
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_profile',
						data		=> { virtual_servers => $virtual_servers }
					) };

	foreach my $profile ( @profiles ) {
		my @r = map { BigIP::iControl::LocalLB::VirtualServer::VirtualServerProfileAttribute->new( $_ ) } @{ $profile };
		push @res, \@r
	}

	return @res
}

sub get_persistence_profile {
	my( $self, $virtual_servers ) = @_;

	my @profiles = @{
		   $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_persistence_profile',
						data		=> { virtual_servers => $virtual_servers }
					) };

	@profiles = map { BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence->new( $_ ) } @profiles;

	return @profiles
}

sub get_persistence_record {
	my( $self, $virtual_servers, $persistence_modes ) = @_;

	my @res;
	my @records = @{ 
		$self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_persistence_record',
						data		=> { virtual_servers => $virtual_servers,
								     persistence_modes => $persistence_modes }
					) };

	foreach my $record ( @records ) {
		my @r;

		if ($record ne '') {
			@r = map { defined $_ ? BigIP::iControl::LocalLB::PersistenceRecord->new( $_ ) : [] } @{ $record };
		}

		push @res, \@r;
	}

	return @res;
}

sub get_fallback_persistence_profile {
	my( $self, $virtual_servers ) = @_;

	return @{ $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_fallback_persistence_profile',
						data		=> { virtual_servers => $virtual_servers }
					) };
}

sub get_httpclass_profile {
	my( $self, $virtual_servers ) = @_;

	return @{ $self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_httpclass_profile',
						data		=> { virtual_servers => $virtual_servers }
		) };
}

sub get_object_status {
	my( $self, $virtual_servers ) = @_;

	return map { BigIP::iControl::LocalLB::ObjectStatus->new( $_ ) }
		@{ $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_object_status',
						data		=> { virtual_servers => $virtual_servers }
		) };
}

sub get_protocol {
	my( $self, $virtual_servers ) = @_;

	my @protocols = @{
		   $self->{_icontrol}->_request(module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_protocol',
						data		=> { virtual_servers => $virtual_servers }
					) };
	
	@protocols = map { BigIP::iControl::Common::ProtocolType->new( $_ ) } @protocols;
	print "proto: @protocols\n";

	return @protocols
}

sub get_statistics {
	my( $self, $virtual_servers ) = @_;

	my $statistics = BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatistics->new(
		$self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_statistics',
						data		=> { virtual_servers => $virtual_servers } 
					) );

	return $statistics
}

sub get_gtm_score {
	my( $self, $virtual_servers ) = @_;

	my @statistics = map { BigIP::iControl::Common::ULong64->new( $_ ) } @{
		$self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_gtm_score',
						data		=> { virtual_servers => $virtual_servers } 
					) };

	return @statistics
}

sub get_all_statistics {
	my $self = shift;

	my $statistics = BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatistics->new(
		$self->{_icontrol}->_request(	module		=> 'LocalLB',
						interface	=> 'VirtualServer',
						method 		=> 'get_all_statistics' ) );
	return $statistics
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::VirtualServer - Class for operations with LocalLB virtual servers.

=head1 DESCRIPTION

This module provides an interface to LocalLB virtual server management capabilities.

=head1 METHODS

=head3 get_default_pool_name( \@virtual_servers )

Gets the default pool names for the specified virtual servers.

=head3 get_destination( \@virtual_servers )

Gets the destination IP and port of the specified virtual servers as an array of 
 L<BigIP::iControl::Common::IPPortDefinition> objects.

=head3 get_enabled_state

Returns the enabled state of the virtual server as a L<BigIP::iControl::Common::EnabledState> object.

=head3 get_persistence_profile

Returns a list of persistence profiles the specified virtual server is associated with as an array of  
L<BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence> objects.

=head3 get_fallback_persistence_profile ( \@virtual_servers )

Returns a list of the fallback persistence profiles for the specified virtual servers.

=head3 get_protocol

Returns the protocols supported by the specified virtual server as an array of 
L<BigIP::iControl::Common::ProtocolType> objects.

=head3 destination

Returns the destination (the host or network IP address) of the L<BigIP::iControl::LocalLB::Virtual>
object.

=head3 state

Returns the operational state of the L<BigIP::iControl::LocalLB::Virtual> object.

=head3 rules

Returns an array of scalars with each scalar representing the name of an iRule attached
to the specified virtual server.

=head3 get_list

Returns a list of all virtual servers.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-VirtualServer>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::VirtualServer


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-VirtualServer>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-VirtualServer>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-VirtualServer>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-VirtualServer/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
