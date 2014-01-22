package BigIP::iControl::Common::HAAction;

use strict;
use warnings;

use overload ( '""' => \&stringify );

our $VERSION = '0.01';

our $map = {
	HA_ACTION_NONE => {
		value	=> 0,
		desc	=> 'No action.'
	},
	HA_ACTION_REBOOT => {
		value	=> 1,
		desc	=> 'Reboot the system.'
	},
	HA_ACTION_RESTART => {
		value	=> 2,
		desc	=> 'Restart the HA daemon.'
	},
	HA_ACTION_FAILOVER => {
		value	=> 3,
		desc	=> 'Failover to the peer system.'
	},
	HA_ACTION_FAILOVER_RESTART => {
		value	=> 4,
		desc	=> 'Failover to the peer system, then restart.'
	},
	HA_ACTION_GO_ACTIVE => {
		value	=> 5,
		desc	=> 'Become the active device in a redundant pair.'
	},
	HA_ACTION_RESTART_ALL => {
		value	=> 6,
		desc	=> 'Restart all daemons.'
	},
	HA_ACTION_FAILOVER_ABORT_TRAFFIC_MGT => {
		value	=> 7,
		desc	=> 'Failover and abort TMM and BCM56XXD.'
	},
	HA_ACTION_GO_OFFLINE => {
		value	=> 8,
		desc	=> 'Go offline.'
	},
	HA_ACTION_GO_OFFLINE_RESTART => {
		value	=> 9,
		desc	=> 'Go offline & restart.'
	},
	HA_ACTION_GO_OFFLINE_ABORT_TM => {
		value	=> 10,
		desc	=> 'Go offline & abort the Traffic Manager.',
	},
	HA_ACTION_GO_OFFLINE_DOWNLINKS => {
		value	=> 11,
		desc	=> 'Go offline & down the links (TMM network ports).'
	},
	HA_ACTION_GO_OFFLINE_DOWNLINKS_RESTART => {
		value	=> 12,
		desc	=> 'Go offline, down the links (TMM network ports), & restart.'
	}
};

sub new {
	my ($class, $haaction) = @_;
	my $self = bless {}, $class;
	$self->{haaction} = $haaction;
	return $self
}

sub value 	{ return $map->{ $_[0] }->{value} 	}

sub desc 	{ return $map->{ $_[0] }->{desc} 	}

sub stringify 	{ return "$_[0]->{haaction}"		}
1;
