package BigIP::iControl::LocalLB::VirtualServerRule;

use strict;
use warnings;

use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, $args )	= @_;
	my $self			= bless {}, $class;
	weaken( $self->{_icontrol} 	= $icontrol );
	$self->{ name }			= $args->{ rule_name };
	$self->{ priority }		= $args->{ priority };
	return $self
}

sub name { return $_[0]->{ name } }

sub priority { return $_[0]->{ priority } }
