package BigIP::iControl::LocalLB::MonitorInstanceState;

use strict;
use warnings;

use BigIP::iControl::LocalLB::MonitorInstance;

our $VERSION = '0.01';

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{enabled_state} = $args->{enabled_state};
	$self->{instance_state} = $args->{instance_state};
	$self->{instance} = BigIP::iControl::LocalLB::MonitorInstance->new ( $args->{instance} );
	return $self
}
