package BigIP::iControl::Common::TimeStamp;

use strict;
use warnings;

our $VERSION = '0.01';
our @ATTR = qw(hour minute second month day year);

{
	no strict 'refs';

	foreach my $attr ( @ATTR ) {
		*{ __PACKAGE__ .'::'. $attr } = sub { return $_[0]->{$attr} }
	}
}

sub new {
	my ( $class, $timestamp ) = @_;
	my $self = bless {}, $class;
	map { $self->{ $_ } = $timestamp->{ $_ } } @ATTR;
	return $self
}

1;
