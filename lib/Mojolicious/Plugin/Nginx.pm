# Copyright (C) 2011, Yaroslav Korshak.

package Mojolicious::Plugin::Nginx;

use warnings;
use strict;
require Mojo::URL;

use base 'Mojolicious::Plugin';

our $VERSION = '0.01_0';

sub register {
    my ($self, $app, $params) = @_;
    $app->hook(
        before_dispatch => sub {
            my $c    = shift;
            my $base = $c->req->headers->header('X-Proxy-Path');

            unless ($base) {
                $app->log->debug(
                    "No 'X-Proxy-Path' header in request. Did you forget to set it into ngix.conf?"
                );
                return;
            }

            # Set base url to X-Proxy-Path
            $c->req->url->base->path->parse($base);
        }
    );
}

1;

__END__

=head1 NAME

Mojolicious::Plugin::Nginx - helps Mojolicious run behind nginx


=head1 SYNOPSIS
Mojolicious aplpication:

    use base 'Mojolicious';
    sub statup {
        my $self = shift;
        $self->plugin( 'nginx' );

        $self->routes->get('/')->to(cb => sub {
            shift->render_text("Current url: " . $self->url_for);
        })->name('/');
    }

Nginx configuration:

    http {

    # ...

        # Configure your backend
        upstream mojolicious {
            server 127.0.0.1:3000;
        }

        server {
            listen  *:80;

            location /test {
                    # Proxy request to your application
                    proxy_pass http://mojolicious/$request_uri;

                    # Set base path
                    proxy_set_header X-Proxy-Path "/test";

            }
        }

       # ...
    }

=head1 DESCRIPTION

Helps to manage scripts and styles included in document.

=head1 METHODS

L<Mojolicious::Plugin::Nginx> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register;

  Register plugin hooks in L<Mojolicious> application.

=head1 CONFIGURATION AND ENVIRONMENT

You are supposed to pass base path of your application in 'X-Proxy-Path' header.

=head1 AUTHOR

Yaroslav Korshak  C<< <ykorshak@gmail.com> >>
