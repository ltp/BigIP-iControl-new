use strict;
use warnings;
use Test::More;

my $min_tpc = 1.08;
eval "use Test::Pod::Coverage $min_tpc";
plan skip_all => "Test::Pod::Coverage $min_tpc required for testing POD coverage"
    if $@;

my $min_pc = 0.18;
eval "use Pod::Coverage $min_pc";
plan skip_all => "Pod::Coverage $min_pc required for testing POD coverage"
    if $@;

pod_coverage_ok( 'BigIP::iControl' );
pod_coverage_ok( 'BigIP::iControl::LocalLB',	 			{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::Class::Member', 		{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::Class::StringClass',	{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::Rule', 			{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::Rule::RuleDefinition',	{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::VirtualServer', 		{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence', 		
									{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::Class::Member', 		{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::LocalLB::Class::StringClass',	{ also_private => [ 'new' ] } );
pod_coverage_ok( 'BigIP::iControl::Common::EnabledState',		{ also_private => [ 'new', 'stringify' ] } );
pod_coverage_ok( 'BigIP::iControl::Common::IPPortDefinition',		{ also_private => [ 'new', 'stringify' ] } );
pod_coverage_ok( 'BigIP::iControl::Common::ProtocolType',		{ also_private => [ 'new', 'stringify' ] } );
done_testing();

