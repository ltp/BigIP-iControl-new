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

1;

__END__


=head1 NAME

BigIP::iControl::LocalLB::VirtualServerRule - Class for operations with LocalLB virtual server rules.

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
