package BigIP::iControl::Common::ULong64;

use strict;
use warnings;

use Math::BigInt;

use overload ( '""' => \&_stringify );

our $VERSION = '0.01';


for my $att (qw(high low abs)) {
	no strict 'refs';
	*{__PACKAGE__."::$att" } = sub { return $_[0]->{$att} }
}

sub new {
	my ( $class, $data ) = @_;
	my $self = bless {}, $class;
	$self->{high} = $data->{high};
	$self->{low} = $data->{low};
	$self->{abs} = Math::BigInt->new("0x" 
		     . unpack( "H*", pack( "N2", $self->{high}, $self->{low} ) ) )->bstr;
	return $self
}

sub _stringify { return "$_[0]->{ abs }" }

1;

__END__

=head1 NAME

BigIP::iControl::Common::ULong64 - Utility class for 64 bit number representation.

=head1 DESCRIPTION

This module implements a utility class providing 64 bit number representation.

=head1 METHODS

=head3 high

Returns the high-order 32-bit unsigned integer.

=head3 low

Returns the low-order 32-bit unsigned integer.

=head3 abs

Returns the 64-bit unsigned value.

Note that this class also implements an overloaded stringification method that returns
the same output as the I<abs()> method.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-Common-ULong64>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::Common::ULong64


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-Common-ULong64>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-Common-ULong64>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-Common-ULong64>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-Common-ULong64/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
