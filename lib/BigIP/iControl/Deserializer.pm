package BigIP::iControl::Deserializer;

use strict;
use warnings;

our @ISA = qw(SOAP::Deserializer);

sub typecast {
	my ($self, $value, $name, $attrs, $children, $type) = @_;
	return ( defined $type ? $value : undef )
}   
