#!/usr/bin/perl

use strict;
use warnings;

use Test::Builder::Tester tests => 2;
use Test::More;

BEGIN { 
    use_ok('Test::GD');
}

test_out("ok 1 - ... these are the same images");
test_out("not ok 2 - ... these are not the same images");
test_err("#     Failed test (t/20_cmp_image.t at line 21)");
test_out("ok 3 - ... these are the same images");
test_out("not ok 4 - ... these are not the same images");
test_err("#     Failed test (t/20_cmp_image.t at line 28)");

cmp_image('t/cpan.gif', 't/cpan.gif', '... these are the same images');
cmp_image('t/cpan.gif', 't/download_perl.gif', '... these are not the same images');

my $cpan = GD::Image->new('t/cpan.gif');
my $cpan2 = GD::Image->new('t/cpan.gif');
my $perl = GD::Image->new('t/download_perl.gif');

cmp_image($cpan, $cpan2, '... these are the same images');
cmp_image($cpan, $perl, '... these are not the same images');

test_test("cmp_image works");