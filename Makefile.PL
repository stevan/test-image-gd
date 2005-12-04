use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Test::GD',
    VERSION_FROM => 'lib/Test/GD.pm', 
    PREREQ_PM    => {
        'Test::More' => 0.47,
    }
);
