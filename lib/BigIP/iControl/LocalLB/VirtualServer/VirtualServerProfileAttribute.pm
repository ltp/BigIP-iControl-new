package BigIP::iControl::LocalLB::VirtualServer::VirtualServerProfileAttribute;

use strict;
use warnings;

our $VERSION = '0.01';

for (qw(profile_type profile_context profile_name)) {
	no strict 'refs';
	*{ __PACKAGE__."::$_" } = sub { return $_[0]->{$_} }
}

sub new {
	my ($class, $args) = @_;
	my $self = bless {}, $class;
	$self->{profile_name} = $args->{profile_name};
	$self->{profile_context} = $args->{profile_context};
	$self->{profile_type} = $args->{profile_type};
	return $self
}

1;

__END__
