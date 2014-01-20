package BigIP::iControl::LocalLB::PersistenceMode;

use strict;
use warnings;

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
	my ($class, $status) = @_;
	my $self = bless {}, $class;
	$self->{status} = $status;

	return $self
}
