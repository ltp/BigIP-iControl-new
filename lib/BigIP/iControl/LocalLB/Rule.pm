package BigIP::iControl::LocalLB::Rule;

use strict;
use warnings;

use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, %args ) = @_;
	my $self = bless {}, $class;
	$self->{ name } = $args{name};
	$self->{ _args } = \%args;
	weaken( $self->{_icontrol} = $icontrol );
	return $self;
}

sub _create {
	my $self = new( @_ );

	my $res = $self->{_icontrol}->_request(
				module		=> 'LocalLB',
				interface	=> 'Rule',
				method		=> 'create',
				data		=> { rules => [{
								rule_name 	=> $self->{name}, 
								rule_definition => $self->{definition}
								}] 
						   }
						);

	return ( (ref $res) eq 'HASH' and defined $res->{_has_fault} )
		? do { warn $res->{faultstring}; undef }
		: 1 ;
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

	my $rule = 
		$self->{_icontrol}->_request(module	=> 'LocalLB',
					      interface	=> 'Rule',
					      method	=> 'query_rule',
					      data	=> { rule_names => [ $self->{name} ] }
					);

	return ( (ref $rule) eq 'HASH' and defined $rule->{_has_fault} )
			? do { warn $rule->{faultstring}; undef }
			: $rule->[0]->{rule_definition} ;
}

1;
