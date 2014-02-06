package BigIP::iControl::LocalLB::MonitorIPPort;

use strict;
use warnings;

use BigIP::iControl::Common::IPPortDefinition;

our $VERSION = '0.01';

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{ipport} = BigIP::iControl::Common::IPPortDefinition->new( $args->{enabled_state} );
	$self->{address_type} = $args->{address_type};
	$self->{instance} = $args->{instance};
	return $self
}

1;
