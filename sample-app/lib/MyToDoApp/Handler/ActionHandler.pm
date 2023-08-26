package MyToDoApp::Handler::ActionHandler;
use v5.36;
use feature 'try';
use Mojolicious::Lite -signatures;

use MyToDoApp::Types qw(CreateActionRequestBody);

use aliased 'MyToDoApp::Service::ActionService';
use aliased 'MyToDoApp::Service::TaskService';
use aliased 'MyToDoApp::Domain::ActionDomain';
use aliased 'MyToDoApp::Domain::HTTPDomain';

sub add ($c) {
  my $task_id = $c->param('task_id');
  my $json = $c->req->json;
  if (!CreateActionRequestBody->check($json)) {
    $c->render(
      HTTPDomain->invalid_request(),
    );
    return;
  }
  my $task = TaskService->get_by_id($task_id);
  if (!$task) {
    $c->render(
      HTTPDomain->resource_not_found(),
    );
    return;
  }
  my $action;
  try {
    $action = ActionService->add($task_id, $json->{description});
  } catch ($e) {
    $c->render(
      HTTPDomain->internal_server_error($e),
    );
    return;
  }
  $c->render(json => $action);
}

sub apply {
  my ($class, $app) = @_;
  $app->routes->post('/tasks/:task_id/actions', \&add);
}

1;