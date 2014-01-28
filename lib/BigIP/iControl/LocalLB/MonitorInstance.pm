package BigIP::iControl::LocalLB::MonitorInstance;

use strict;
use warnings;

use BigIP::iControl::LocalLB::MonitorIPPort;

our $VERSION = '0.01';

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{template_name} = $args->{template_name};
	$self->{instance_definition} = BigIP::iControl::LocalLB::MonitorIPPort->new( $args->{instance_definition} );
	return $self
}
