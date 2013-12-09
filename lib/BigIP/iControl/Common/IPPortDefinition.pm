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


__END__

=head1 NAME

BigIP::iControl::Common::IPPortDefinition - Utility class for working with IP port definition objects.

=head1 DESCRIPTION

This module implements a utility class for representation of IP port definition objects.

=head1 METHODS

=head3 address

Returns the address portion of the IP port definition object including the route domain (if any).

=head3 port

Returns the port portion of the IP port definition object.

B<Note> that this class also implements an overloaded stringification method that returns
the concatenated output of the I<address> and I<port> methods.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-Common-IPPortDefinition>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::Common::IPPortDefinition


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-Common-IPPortDefinition>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-Common-IPPortDefinition>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-Common-IPPortDefinition>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-Common-IPPortDefinition/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
