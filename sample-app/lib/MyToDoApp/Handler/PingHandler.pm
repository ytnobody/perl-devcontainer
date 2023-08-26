package MyToDoApp::Handler::PingHandler;
use v5.36;
use Mojolicious::Lite -signatures;

sub ping ($c) {
  $c->render(json => {message => 'pong'});
};

sub apply {
  my ($class, $app) = @_;
  $app->routes->get('/ping', \&ping);
}

1;
