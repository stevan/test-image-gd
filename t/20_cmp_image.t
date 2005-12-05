#!/usr/bin/perl

use strict;
use warnings;

use Test::Builder::Tester tests => 2;
use Test::More;
use File::Spec::Functions;

BEGIN { 
    use_ok('Test::Image::GD');
}

test_out("ok 1 - ... these are the same images");
test_out("not ok 2 - ... these are not the same images");
test_err("#     Failed test (t/20_cmp_image.t at line 25)");
test_out("ok 3 - ... these are the same images");
test_out("not ok 4 - ... these are not the same images");
test_err("#     Failed test (t/20_cmp_image.t at line 32)");

my $path_to_cpan_gif = catdir('t', 'cpan.gif');
my $path_to_perl_gif = catdir('t', 'download_perl.gif');

cmp_image($path_to_cpan_gif, $path_to_cpan_gif, '... these are the same images');
cmp_image($path_to_cpan_gif, $path_to_perl_gif, '... these are not the same images');

my $cpan = GD::Image->new($path_to_cpan_gif);
my $cpan2 = GD::Image->new($path_to_cpan_gif);
my $perl = GD::Image->new($path_to_perl_gif);

cmp_image($cpan, $cpan2, '... these are the same images');
cmp_image($cpan, $perl, '... these are not the same images');

test_test("cmp_image works");