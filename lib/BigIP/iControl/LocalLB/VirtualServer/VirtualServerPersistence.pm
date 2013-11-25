package BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence;

use strict;
use warnings;

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{profile_name} = $args->{profile_name};
	$self->{default_profile} = $args->{default_profile};
	return $self;
}

sub profile_name {
	return $_[0]->{profile_name}
}

sub default_profile {
	return $_[0]->{default_profile}
}

1;

__END__
