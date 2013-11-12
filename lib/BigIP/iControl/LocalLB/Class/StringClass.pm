package BigIP::iControl::LocalLB::Class::StringClass;

use strict;
use warnings;

use BigIP::iControl::LocalLB::Class::Member;
use Scalar::Util qw(weaken);

sub new {
	my ( $class, $name, $icontrol, %members ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;
	weaken( $self->{_icontrol} = $icontrol );

	foreach my $member ( keys %members ) {
		push @{ $self->{members} }, 
			BigIP::iControl::LocalLB::Class::Member->new(	$member, 
									$members{ $member },
									$self->{name},
									'string', 
									$self->{_icontrol} 
								);
	}

	return $self
}

sub members { 
	my $self = shift;
	return @{ $self->{members} } 
}

sub member {
	my ( $self, $member ) = @_;
	$member or return "Member name not specified";

	return grep { $_->name eq $member } $self->members;
	foreach my $m ( $self->members ) {
		if ( $m->name eq $member ) {
			return $m
		}
	}

	return undef
}


1;

=head1 NAME

BigIP::iControl::LocalLB::Class::StringClass - Class for operations with LocalLB string classes.

=head1 DESCRIPTION

This module provides an interface to the LocalLB (LTM) String Class methods.

=head1 METHODS

=head3 member( $SCALAR )

Returns the specified string class member of the target class identified by the 
named key parameter as a L<BigIP::iControl::LocalLB::Class::Member> object;

=head3 members

Returns an array of scalars representing the key values of all members in the
target string class.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-Class-StringClass>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::Class::StringClass


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-Class-StringClass>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-Class-StringClass>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-Class-StringClass>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-Class-StringClass/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
