package BigIP::iControl::LocalLB::Pool::MonitorAssociation;

use strict;
use warnings;

use BigIP::iControl::LocalLB::MonitorRule;

our $VERSION = '0.01';

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{pool_name} = $args->{pool_name};
	$self->{monitor_rule} = BigIP::iControl::LocalLB::MonitorRule->new ( $args->{monitor_rule} );
	return $self
}

1;
