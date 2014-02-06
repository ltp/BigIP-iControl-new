package BigIP::iControl::LocalLB::MonitorRule;

use strict;
use warnings;

our $VERSION = '0.01';

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{type} = $args->{type};
	$self->{quorum} = $args->{quorum};
	$self->{monitor_templaes} = $args->{monitor_templates};
	return $self
}

1;
