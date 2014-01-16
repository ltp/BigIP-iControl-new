package BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatistics;

use warnings;
use strict;

use BigIP::iControl::Common::TimeStamp;
use BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatisticEntry;

our $VERSION = '0.01';

sub new {
	my($class,$args) = @_;
	my $self = bless {}, $class;
	$self->{time_stamp} = BigIP::iControl::Common::TimeStamp->new( $args->{ time_stamp } );
	$self->{statistics} = [ map { BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatisticEntry->new( $_ ) } @{ $args->{statistics} } ];
	return $self
}

1;


