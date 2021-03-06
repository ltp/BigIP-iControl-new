package BigIP::iControl::Common::Statistic;

use strict;
use warnings;

use BigIP::iControl::Common::ULong64;

our $VERSION = '0.01';

sub new {
	my ($class, $data) = @_;
	my $self = bless {}, $class;
	$self->{type} = $data->{type};
	$self->{value} = BigIP::iControl::Common::ULong64->new( $data->{value} );
	return $self
}

sub time_stamp { return $_[0]->{ time_stamp } }

sub value { return $_[0]->{ value } }

sub type { return $_[0]->{ type } }

1;
