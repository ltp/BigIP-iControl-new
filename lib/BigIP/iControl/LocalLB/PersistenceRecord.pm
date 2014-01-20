package BigIP::iControl::LocalLB::PersistenceRecord;

use strict;
use warnings;

use BigIP::iControl::LocalLB::PersistenceMode;
use BigIP::iControl::Common::IPPortDefinition;
use BigIP::iControl::Common::VirtualServerDefinition;

our $VERSION = '0.01';
our $map = {
	PERSISTENCE_MODE_NONE => {
		value 	=> 0,
		desc	=> 'No persistence mode.'
	},
	PERSISTENCE_MODE_SOURCE_ADDRESS_AFFINITY => {
		value	=> 1,
		desc	=> 'Simple or Source Address affinity persistence mode.'
	},
	PERSISTENCE_MODE_DESTINATION_ADDRESS_AFFINITY => {
		value	=> 2,
		desc	=> 'Sticky or Destination Address affinity persistence mode.'
	},
	PERSISTENCE_MODE_COOKIE => {
		value	=> 3,
		desc	=> 'Cookie persistence mode.'
	},
	PERSISTENCE_MODE_MSRDP => {
		value	=> 4,
		desc	=> 'Microsoft Terminal Server persistence mode.'
	},
	PERSISTENCE_MODE_SSL_SID => {
		value 	=> 5,
		desc	=> 'SSL Session ID persistence mode.'
	},
	PERSISTENCE_MODE_SIP => {
		value	=> 6,
		desc	=> 'SIP (Call-ID) persistence mode.'
	},
	PERSISTENCE_MODE_UIE => {
		value	=> 7,
		desc	=> 'Universal persistence mode.'
	},
	PERSISTENCE_MODE_HASH => {
		value	=> 8,
		desc	=> 'Hash persistence mode.'
	}
};

sub new {
	my ($class, $args) = @_;
	#use Data::Dumper;
	#print Dumper( $args );
	#return 1;
	my $ref = ref( $args );
	my $self = bless {}, $class;
	$self->{pool_name} = $args->{pool_name};
	$self->{virtual_server} = BigIP::iControl::Common::VirtualServerDefinition->new( $args->{virtual_server} );
	$self->{node_server} = BigIP::iControl::Common::IPPortDefinition->new( $args->{node_server} );
	$self->{mode} = BigIP::iControl::LocalLB::PersistenceMode->new( $args->{mode} );
	$self->{persistence_value} = $args->{persistence_value};
	$self->{create_time} = $args->{create_time};
	$self->{age} = $args->{age};

	return $self
}
