use Test::More tests => 4;
use Test::Mojo;

use Mojolicious::Lite;

local $ENV{MOJO_LOG_LEVEL} ||= 'fatal';

plugin 'nginx';

get '/(*name)' => [name => qr/.*/] => sub {
    my $c = shift;
    $c->render_text("Current url: "
          . $c->url_for
          . "\nTest url: "
          . $c->url_for('/bar/baz/'));
};

my $t = Test::Mojo->new(app => app);

$t->get_ok('/' => {'X-Proxy-Path' => '/foo'})
  ->content_is("Current url: /foo/\nTest url: /foo/bar/baz/");

$t->get_ok('/test' => {'X-Proxy-Path' => '/foo'})
  ->content_is("Current url: /foo/test\nTest url: /foo/bar/baz/");
