package BigIP::iControl::LocalLB::Rule::RuleDefinition;

use strict;
use warnings;

sub new {
	my ($class, $rule ) = @_;
	my $self = bless {}, $class;
	$self->{rule_name} = $rule->{rule_name};
	$self->{rule_definition} = $rule->{rule_definition};
	return $self
}

sub name { return $_[0]->{rule_name} }

sub definition { return $_[0]->{rule_definition} }

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::Rule::RuleDefinition - Utility class for rule LocalLB definitions.

=head1 DESCRIPTION

This module implements a utility class for working with LocalLB rule definitions.

=head1 METHODS

=head3 rule_name

Returns the name of the specified rule.

=head3 rule_definition

Returns the rule definition of the specified rule - this is the complete iRule text.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-Rule-RuleDefinition>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::Rule::RuleDefinition


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-Rule-RuleDefinition>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-Rule-RuleDefinition>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-Rule-RuleDefinition>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-Rule-RuleDefinition/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
