package BigIP::iControl::LocalLB;

use strict;
use warnings;

use BigIP::iControl::LocalLB::Class::StringClass;
use Scalar::Util qw(weaken);

sub new {
	my( $class, $icontrol, %args ) = @_;
	my $self = bless {}, $class;
	weaken( $self->{_icontrol} = $icontrol );
	return $self;
}

sub string_class {
	my( $self, $class ) = @_;
	my $members = @{ $self->{_icontrol}->_request(
				module		=> 'LocalLB', 
				interface	=> 'Class', 
				method		=> 'get_string_class', 
				data		=> { class_names => [$class] } 
			) }[0] ;
	
	my @values = @{ $self->{_icontrol}->_request(
				module		=> 'LocalLB', 
				interface	=> 'Class',
				method		=> 'get_string_class_member_data_value', 
				data		=> { name => $class, class_members => [$members] } 
			) }[0];
	
	my %members;
	@members{ @{ $members->{members} } } = @{ $values[0] };
	my $string_class = BigIP::iControl::LocalLB::Class::StringClass->new( $class, %members );
	return $string_class;
}

sub string_class_list {
	my( $self ) = @_;
	return $self->{_icontrol}->_request(module => 'LocalLB', interface => 'Class', method => 'get_string_class_list') 
}

1;
