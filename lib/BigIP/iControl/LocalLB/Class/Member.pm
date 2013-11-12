package BigIP::iControl::LocalLB::Class::Member;

use strict;
use warnings;
use overload ( '""' => \&_stringify );

use Scalar::Util qw(weaken);

sub new {
	my ( $class, $name, $value, $class_name, $type, $icontrol ) = @_;
	my $self		= bless {}, $class;
	$self->{name}		= $name;
	$self->{value}		= $value;
	$self->{class_name}	= $class_name;
	$self->{type}		= $type;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub name { 
	my $self = shift;
	return $self->{name} }

sub value { 
	my ( $self, $value ) = @_;

	return $self->{value} unless $value;
	
	if ( $self->{type} eq 'string' ) {
		$self->{_icontrol}->_request( 
					module		=> 'LocalLB',
					interface	=> 'Class',
					method		=> 'set_string_class_member_data_value',
					data		=> {
							class_members	=> [ 
									     {	name	=> $self->{class_name},
										members	=> [ $self->{name} ] 
									     }
									   ],
							values		=> [
									     [ $value ]
									   ]
							}
					);
		return $self
	}

}

sub _stringify {
	my $self = shift;
	return $self->{ value }
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::Class::Member - Class for operations with LocalLB class members.

=head1 DESCRIPTION

This module provides an interface to the LocalLB (LTM) Class interface.

=head1 METHODS

=head3 name

Returns the name of the specified class member.

=head3 value

Returns the value of the specified class member.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-Class-Member>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::Class::Member


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-Class-Member>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-Class-Member>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-Class-Member>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-Class-Member/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
