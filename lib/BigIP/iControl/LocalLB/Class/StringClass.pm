package BigIP::iControl::LocalLB::Class::StringClass;

use strict;
use warnings;

use BigIP::iControl::LocalLB::Class::Member;

sub new {
	my ( $class, $name, %members ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;

	foreach my $member ( keys %members ) {
		push @{ $self->{members} }, BigIP::iControl::LocalLB::Class::Member->new( $member, $members{ $member } );
	}

	return $self
}

sub members { return @{ $_[0]->{members} } }

1;
