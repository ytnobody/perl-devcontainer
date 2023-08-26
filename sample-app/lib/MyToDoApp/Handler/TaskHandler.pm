package MyToDoApp::Handler::TaskHandler;
use v5.36;
use feature 'try';
use Mojolicious::Lite -signatures;

use MyToDoApp::Types qw(CreateTaskRequestBody UpdateTaskRequestBody TaskDetailResponse);

use aliased 'MyToDoApp::Service::ActionService';
use aliased 'MyToDoApp::Service::TaskService';

use aliased 'MyToDoApp::Domain::TaskDomain';
use aliased 'MyToDoApp::Domain::HTTPDomain';

sub list ($c) {
  my @tasks = TaskService->get_all;
  my $res = {
    items => [@tasks],
  };
  $c->render(json => $res);
}

sub add ($c) {
  my $json = $c->req->json;
  if (!CreateTaskRequestBody->check($json)) {
    $c->render(
      HTTPDomain->invalid_request(),
    );
    return;
  }
  my $task = TaskService->add($json->{title}, $json->{description});
  $c->render(json => $task);
}

sub update ($c) {
  my $id = $c->param('id');
  my $json = $c->req->json;
  if (!UpdateTaskRequestBody->check($json)) {
    $c->render(
      HTTPDomain->invalid_request(),
    );
    return;
  }
  my $task = TaskService->get_by_id($id);
  if (!$task) {
    $c->render(
      HTTPDomain->resource_not_found(),
    );
    return;
  }
  try {
    TaskService->update($id, $json->{title}, $json->{description});
  } catch ($e) {
    $c->render(
      HTTPDomain->internal_server_error($e),
    );
    return;
  }
  $task = TaskService->get_by_id($id);
  $c->render(json => $task);
}

sub done ($c) {
  my $id = $c->param('id');
  my $task;
  try {
    $task = TaskService->as_done($id);
  } catch ($e) {
    $c->render(
      HTTPDomain->internal_server_error($e),
    );
    return;
  }
  $c->render(json => $task);
}

sub delete ($c) {
  my $id = $c->param('id');
  TaskService->delete($id);
  $c->render(json => {message => 'deleted'});
}

sub show ($c) {
  my $id = $c->param('id');

  my $task = TaskService->get_by_id($id);
  if (!$task) {
    $c->render(
      HTTPDomain->resource_not_found(),
    );
    return;
  }
  my @actions = ActionService->get_by_task_id($id);

  my $res = TaskDomain->build_task_detail($task, \@actions);

  $c->render(json => $res);
}

sub apply {
  my ($class, $app) = @_;
  $app->routes->get('/tasks', \&list);
  $app->routes->post('/tasks', \&add);
  $app->routes->put('/tasks/:id', \&update);
  $app->routes->put('/tasks/:id/done', \&done);
  $app->routes->delete('/tasks/:id', \&delete);
  $app->routes->get('/tasks/:id', \&show);
  return app;
}

1;
