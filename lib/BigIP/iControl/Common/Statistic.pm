package BigIP::iControl::Common::Statistic;

use strict;
use warnings;

use BigIP::iControl::Common::ULong64;

our $VERSION = '0.01';

sub new {
	my ( $class, $data ) = @_;
	my $self = bless {}, $class;
	$self->{time_stamp} = $data->{time_stamp};
	$self->{type} = $data->{type};
	$self->{value} = BigIP::iControl::Common::ULong64->new( $data->{value} );
	return $self
}

1;
