package BigIP::iControl::Common::VirtualServerDefinition;

use strict;
use warnings;

our $VERSION = '0.01';

for my $att (qw(name port protocol address)) {
	no strict 'refs';
	*{ __PACKAGE__."::$att" } = sub {
		return $_[0]->{$att}
	}
}

sub new {
	my ($class, $args) = @_;
	my $self = bless {}, $class;
	$self->{name} = $args->{name};
	$self->{port} = $args->{port};
	$self->{protocol} = $args->{protocol};
	$self->{address} = $args->{address};
	return $self
}

1;
