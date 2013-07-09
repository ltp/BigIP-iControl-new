package BigIP::iControl::LocalLB::Rule;

use strict;
use warnings;

use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, $name, %args ) = @_;
	my $self = bless {}, $class;
	$self->{ name } = $name;
	weaken( $self->{_icontrol} = $icontrol );
	return $self;
}

sub name {
	my $self = shift;
	$self->{name} or return;
	return @{ $self->{_icontrol}->_request(module	=> 'LocalLB',
					      interface	=> 'Rule',
					      method	=> 'query_rule',
					      data	=> { rule_names => [ $self->{name} ] }
					)
		}[0]->{rule_name};
}

sub definition {
	my $self = shift;
	$self->{name} or return;
	return @{ $self->{_icontrol}->_request(module	=> 'LocalLB',
					      interface	=> 'Rule',
					      method	=> 'query_rule',
					      data	=> { rule_names => [ $self->{name} ] }
					)
		}[0]->{rule_definition};
}

1;
