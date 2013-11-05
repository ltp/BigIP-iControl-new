package BigIP::iControl::LocalLB::Class::StringClass;

use strict;
use warnings;

use BigIP::iControl::LocalLB::Class::Member;
use Scalar::Util qw(weaken);

sub new {
	my ( $class, $name, $icontrol, %members ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;
	weaken( $self->{_icontrol} = $icontrol );

	foreach my $member ( keys %members ) {
		push @{ $self->{members} }, 
			BigIP::iControl::LocalLB::Class::Member->new(	$member, 
									$members{ $member },
									$self->{name},
									'string', 
									$self->{_icontrol} 
								);
	}

	return $self
}

sub members { 
	my $self = shift;
	return @{ $self->{members} } 
}

sub member {
	my ( $self, $member ) = @_;
	$member or return "Member name not specified";

	return grep { $_->name eq $member } $self->members;
	foreach my $m ( $self->members ) {
		if ( $m->name eq $member ) {
			return $m
		}
	}

	return undef
}


1;
