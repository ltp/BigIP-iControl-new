package BigIP::iControl::Common::ProtocolType;

use strict;
use warnings;
use overload ('""' => \&_stringify );

our $VERSION    = '0.01';

our %DATA = (
	PROTOCOL_ANY		=> 0,
	PROTOCOL_IPV6		=> 1,
	PROTOCOL_ROUTING	=> 2,
	PROTOCOL_NONE		=> 3,
	PROTOCOL_FRAGMENT	=> 4,
	PROTOCOL_DSTOPTS	=> 5,
	PROTOCOL_TCP		=> 6,
	PROTOCOL_UDP		=> 7,
	PROTOCOL_ICMP		=> 8,
	PROTOCOL_ICMPV6		=> 9,
	PROTOCOL_OSPF		=> 10,
	PROTOCOL_SCTP		=> 11
);

sub new {
        my( $class, $protocol ) = @_; 
        my $self		= bless {}, $class;
        $self->{ protocol }	= $protocol;
        $self->{ value }	= $DATA{ $protocol };
        return $self
}

sub protocol { return $_[0]->{ protocol } }

sub value { return $_[0]->{ value } }

sub _stringify { return "$_[0]->{ protocol }" }

1;
