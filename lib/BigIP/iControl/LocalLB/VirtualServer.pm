package BigIP::iControl::LocalLB::VirtualServer;

use strict;
use warnings;

use Scalar::Util qw(weaken);
use BigIP::iControl::Common::IPPortDefinition;

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, $name, %args ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub destination { 
	my $self = shift;
	$self->{name} or return;
	return BigIP::iControl::Common::IPPortDefinition->new(
		$self->{_icontrol},
		@{$self->{_icontrol}->_request(	module		=> 'LocalLB', 
						interface 	=> 'VirtualServer',
						method 		=> 'get_destination', 
						data 		=> { virtual_servers => [ $self->{name} ] }
					)
		}[0] )
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

1;
