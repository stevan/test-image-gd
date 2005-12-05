use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Test::Image',
    VERSION_FROM => 'lib/Test/Image.pm', 
    PREREQ_PM    => {
        'Test::More' => 0.47,
    }
);
