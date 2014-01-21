package BigIP::iControl::Common::VLANFilterList;

use strict;
use warnings;

our $VERSION = '0.01';

for (qw(state vlans)) {
	no strict 'refs';
	*{__PACKAGE__."::$_"} = sub { return $_[0]->{$_} }
}

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{state} = $args->{state};
	$self->{vlans} = $args->{vlans};
	return $self
}

1;
