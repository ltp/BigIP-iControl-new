package BigIP::iControl::Common::ULong64;

use strict;
use warnings;

use Math::BigInt;

our $VERSION = '0.01';

sub new {
	my ( $class, $data ) = @_;
	my $self = bless {}, $class;
	$self->{high} = $data->{high};
	$self->{low} = $data->{low};
	$self->{abs} = Math::BigInt->new("0x" 
		     . unpack( "H*", pack( "N2", $self->{high}, $self->{low} ) ) )->bstr;
	return $self
}

1;
