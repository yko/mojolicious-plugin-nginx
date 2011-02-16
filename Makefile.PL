use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Mojolicious::Plugin::Nginx',
    AUTHOR        => 'Yaroslav Korshak <yaroslav@korshak.name>',
    VERSION_FROM  => 'lib/Mojolicious/Plugin/Nginx.pm',
    ABSTRACT_FROM => 'lib/Mojolicious/Plugin/Nginx.pm',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Test::More'  => 0,
        'version'     => 0,
        'Mojolicious' => 1.1
    },
    dist => {COMPRESS => 'gzip -9f', SUFFIX => 'gz',},
    clean => {FILES => 'mojolicious-plugin-nginx-*'},
);
