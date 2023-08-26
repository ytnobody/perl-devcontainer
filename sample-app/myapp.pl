#!/usr/bin/env perl
use Mojolicious::Lite -signatures;
use lib 'lib';

use aliased 'MyToDoApp::Handler::PingHandler';
use aliased 'MyToDoApp::Handler::TaskHandler';
use aliased 'MyToDoApp::Handler::ActionHandler';

my $app = app;
PingHandler->apply($app);
TaskHandler->apply($app);
ActionHandler->apply($app);

get '/' => sub ($c) {
  $c->render(json => {message => 'Hello World!'});
};

$app->start;