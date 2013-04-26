package BigIP::iControl::LocalLB::Class::Member;

use strict;
use warnings;

sub new {
	my ( $class, $name, $value ) = @_;
	my $self	= bless {}, $class;
	$self->{name}	= $name;
	$self->{value}	= $value;
	return $self
}

sub name { return $_[0]->{name} }

sub value { return $_[0]->{value} }

1;
