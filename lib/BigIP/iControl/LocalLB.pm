package BigIP::iControl::LocalLB;

use strict;
use warnings;

use BigIP::iControl::LocalLB::Pool;
use BigIP::iControl::LocalLB::VirtualServer;
use BigIP::iControl::LocalLB::Rule;
use BigIP::iControl::LocalLB::Class::StringClass;
use Scalar::Util qw(weaken);

sub new {
	my( $class, $icontrol, %args ) = @_;
	my $self = bless {}, $class;
	weaken( $self->{_icontrol} = $icontrol );
	return $self;
}

sub string_class {
	my( $self, $name ) = @_;
	my $members = @{ $self->{_icontrol}->_request(
				module		=> 'LocalLB', 
				interface	=> 'Class', 
				method		=> 'get_string_class', 
				data		=> { class_names => [$name] } 
			) }[0] ;
	
	my @values = @{ $self->{_icontrol}->_request(
				module		=> 'LocalLB', 
				interface	=> 'Class',
				method		=> 'get_string_class_member_data_value', 
				data		=> { name => $name, class_members => [$members] } 
			) }[0];
	
	my %members;
	@members{ @{ $members->{members} } } = @{ $values[0] };
	my $string_class = BigIP::iControl::LocalLB::Class::StringClass->new( $name, $self->{_icontrol}, %members );
	return $string_class;
}

sub string_class_list {
	my( $self ) = @_;
	return $self->{_icontrol}->_request(module => 'LocalLB', interface => 'Class', method => 'get_string_class_list') 
}

sub pool {
	my( $self, $name ) = @_;
	my $pool = BigIP::iControl::LocalLB::Pool->new( $self->{_icontrol}, $name );
	return $pool
}

sub virtual_server {
	my( $self, $name ) = @_;
	my $virtual = BigIP::iControl::LocalLB::VirtualServer->new( $self->{_icontrol}, $name );
	return $virtual
}

sub query_rule {
	my( $self, $name ) = @_;
	my $rule = BigIP::iControl::LocalLB::Rule->new( $self->{_icontrol}, { name => $name } );
	return $rule;
}

sub create_rule {
	my( $self, %args ) = @_;
	defined $args{name}		or do { warn "name parameter must not be null\n"; return undef 		};
	defined $args{definition}	or do { warn "definition parameter must not be null\n"; return undef 	};
	my $rule = BigIP::iControl::LocalLB::Rule->_create( $self->{_icontrol}, %args );
}

sub delete_rule {
	my ( $self, %args ) = @_;
	defined $args{rule_names}	or do { warn "rule_names parameter must not be null\n"; return undef	};
	( ref( $args{rule_names} ) eq 'ARRAY' ) 
					or do { warn "rule_names parameter type must be array\n"; return undef	};
	my $res = $self->{_icontrol}->_request(
				module		=> 'LocalLB',
				interface	=> 'Rule',
				method		=> 'delete_rule',
				data		=> { rule_names => $args{rule_names} }
		);

	return ( (ref $res) eq 'HASH' and defined $res->{_has_fault} )
		? do { warn $res->{faulstring}; undef }
		: 1 ;
}

sub rule {
	my $self = shift;
	return ( defined $self->{_rule}
		? $self->{_rule}
		: BigIP::iControl::LocalLB::Rule->_new( $self->{_icontrol} ) );
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB - Class for operations with the LocalLB module of BigIP devices.

=head1 DESCRIPTION

This module provides an interface to the LocalLB (LTM) module of a BigIP device.

=head1 METHODS

=head3 pool

Returns a L<BigIP::iControl::LocalLB::Pool> object representing a logical connection
to the Pool interface in the LocalLB module and facilitating access to the methods in
this namespace.

=head3 rule

Returns a L<BigIP::iControl::LocalLB::Rule> object representing a logical connection
to the Rule interface in the LocalLB module facilitating access to the methods in this
namespace.

=head3 string_class( $SCALAR )

Returns a L<BigIP::iControl::LocalLB::Class::StringClass> object representing the requested
String Class and its members.

=head3 string_class_list

Returns an array containing the names of all string classes on the target device.

=head3 create_rule( name => $SCALAR, definition => $SCALAR )

	my $rule = <<"RULE";
when HTTP_REQUEST {
  if { [HTTP::uri] starts_with "/foo/" } {
    pool foo_pool
  }
}
RULE
	$icontrol->ltm->create_rule( name => "Redirect_foo", definition => $definition );

Creates a new iRule in the LocalLB (LTM) scope.

=head3 delete_rule( rule_names => \@ARRAY )

	my @rules = qw(My_Rule My_Other_Rule);
	$icontrol->ltm->delete_rules( \@rules );

Deletes the LocalLB iRules identified by the members of the array passed to the method.

=head3 query_rule( $SCALAR )

	my $rule = $icontrol->ltm->query_rule( 'Redirect Fu' );
	print "Rule: Redirect Fu\nCode:\n" . $rule->definition;

Returns the rule identified by the given name as a L<BigIP::iControl::LocalLB::Rule>
object.

=head3 virtual_server( $SCALAR )

Returns the virtual server specified by the value of the mandatory parameter as a
L<BigIP::iControl::LocalLB::VirtualServer> object.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
