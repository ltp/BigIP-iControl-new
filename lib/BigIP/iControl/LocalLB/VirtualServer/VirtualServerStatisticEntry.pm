package BigIP::iControl::LocalLB::VirtualServer::VirtualServerStatisticEntry;

use strict;
use warnings;

use BigIP::iControl::Common::TimeStamp;
use BigIP::iControl::Common::Statistic;
use BigIP::iControl::Common::VirtualServerDefinition;

our $VERSION = '0.01';

sub new {
	my($class,$args) = @_;
	my $self = bless {}, $class;
	#use Data::Dumper; print Dumper($args);
	$self->{statistics} = [ map { BigIP::iControl::Common::Statistic->new( $_ ) } @{ $args->{statistics} } ];
	$self->{virtual_server} = BigIP::iControl::Common::VirtualServerDefinition->new( $args->{virtual_server} );
	#use Data::Dumper; print Dumper($self->{statistics});
	#$self->{virtual_server} = BigIP::iControl::Common::VirtualServerDefinition->new( $args->{virtual_server} );
	#$self->{time_stamp} = BigIP::iControl::Common::TimeStamp->new( $args->{time_stamp} );
	return $self
}

1;
