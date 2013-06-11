package BigIP::iControl::Common::IPPortDefinition;

use strict;
use warnings;
use overload ( '""' => \&_stringify );

our $VERSION	= '0.01';
our @ACCESSORS	= qw(address port);

{ no strict 'refs';
	foreach my $attr ( @ACCESSORS ) {
		*{ __PACKAGE__ ."::$attr" } = sub { return $_[0]->{ $attr } }
	}
}

sub new {
	my( $class, $icontrol, $args ) = @_;
	my $self		= bless {}, $class;
	$self->{ address }	= $args->{ address };
	$self->{ port }		= $args->{ port };
	return $self
}

sub _stringify { 
        my $self        = shift; 
        return "$self->{ address }:$self->{ port }"
}

1;
