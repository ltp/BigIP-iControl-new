package BigIP::iControl::LocalLB::Pool::PoolStatisticEntry;

use strict;
use warnings;

use BigIP::iControl::Common::Statistic;

our $VERSION = '0.01';

sub new {
	my ( $class, $data ) = @_;
	my $self = bless {}, $class;
	$self->{ pool_name } = $data->{ pool_name };
	$self->{ statistics } = [ map { BigIP::iControl::Common::Statistic->new( $_ ) }
				@{ $data->{ statistics } } ];

	return $self
}

sub pool_name	{ return $_[0]->{pool_name} }

sub statistics  { return @{ $_[0]->{ statistics } } }

1;
